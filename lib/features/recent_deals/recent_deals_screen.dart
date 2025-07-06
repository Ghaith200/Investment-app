import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:investement_app/features/recent_deals/data/deals_repo.dart';
import 'package:investement_app/features/recent_deals/data/recent_deals_cubit.dart';
import 'package:investement_app/features/recent_deals/data/recent_deals_state.dart';
import 'package:investement_app/features/recent_deals/models/recent_offers_model.dart';

class RecentDealsScreen extends StatelessWidget {
  const RecentDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealsCubit(
        DealsRepository(Dio()),
      )..fetchRecentDeals(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recent Successful Deals',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: DealsListView(),
        ),
      ),
    );
  }
}

class DealsListView extends StatelessWidget {
  const DealsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsCubit, DealsState>(
      builder: (context, state) {
        if (state is DealsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DealsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}',
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      context.read<DealsCubit>().fetchRecentDeals(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is DealsLoaded) {
          if (state.deals.isEmpty) {
            return const Center(child: Text('No deals available'));
          }
          return ListView.separated(
            itemCount: state.deals.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => DealCard(deal: state.deals[index]),
          );
        }
        return const Center(child: Text('Pull to refresh'));
      },
    );
  }
}

class DealCard extends StatelessWidget {
  final Deal deal;

  const DealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business Header
            Row(
              children: [
                _buildBusinessAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.business.businessName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        deal.business.category.name,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(),
              ],
            ),
            const SizedBox(height: 16),

            // Deal Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailTile(
                  title: 'Amount',
                  value: '\$${deal.finalAmount.toStringAsFixed(0)}',
                  icon: Icons.attach_money,
                ),
                _buildDetailTile(
                  title: 'Equity',
                  value: '${deal.finalPercentage}%',
                  icon: Icons.pie_chart,
                ),
                _buildDetailTile(
                  title: 'Investor',
                  value: deal.investor.name.split('@').first,
                  icon: Icons.person,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMM dd, yyyy').format(deal.dealDate),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  'Valuation: \$${deal.business.valuation.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.green.shade50,
      child: deal.business.businessPhoto.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl:
                    'http://10.0.2.2:8000/storage/${deal.business.businessPhoto}',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.business),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.business, color: Colors.green),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: deal.status == 'active'
            ? Colors.green.shade50
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        deal.status.toUpperCase(),
        style: TextStyle(
          color: deal.status == 'active' ? Colors.green : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDetailTile(
      {required String title, required String value, required IconData icon}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
