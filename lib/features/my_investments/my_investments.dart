import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/features/home/models/get_offers_model.dart';
import 'package:investement_app/features/home/screens/bottom_nav_bar.dart';
import 'package:investement_app/features/my_investments/data/get_offers_cubit.dart';
import 'package:investement_app/features/my_investments/data/get_offers_state.dart';

class MyInvestments extends StatefulWidget {
  static const String id = "/my_investments";
  const MyInvestments({super.key});

  @override
  State<MyInvestments> createState() => _MyInvestmentsState();
}

class _MyInvestmentsState extends State<MyInvestments> {
  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().loadOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Investments',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is OffersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OffersError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is OffersLoaded) {
            return _buildOffersList(state.offers);
          }
          return const Center(child: Text('No investments yet'));
        },
      ),
    );
  }

  Widget _buildOffersList(List<GetOfferModel> offers) {
    if (offers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('No investments yet',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 10),
            const Text('Start investing in businesses today!',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Explore Businesses',
              onPressed: () {
                // Navigate to businesses screen
                Navigator.pop(context);
                BottomNavBar.switchToTab(context, 2); // Switch to home tab
              },
              width: 200,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        final offer = offers[index];
        return _buildOfferCard(offer);
      },
    );
  }

  Widget _buildOfferCard(GetOfferModel offer) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Business Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: offer.business.businessPhoto != null
                        ? "http://10.0.2.2:8000/storage/${offer.business.businessPhoto!}"
                        : "http://10.0.2.2:8000/storage/default_business.jpg",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.business, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Business Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.business.businessName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.business.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            offer.business.user!.name,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // Offer Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Amount', offer.formattedAmount),
                _buildDetailItem('For', offer.formattedPercentage),
                _buildDetailItem('Date', offer.formattedDate),
              ],
            ),
            const SizedBox(height: 16),
            // Status and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: offer.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    offer.status.toUpperCase(),
                    style: TextStyle(
                      color: offer.statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Show offer details
                    _showOfferDetails(offer);
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showOfferDetails(GetOfferModel offer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Investment Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Business Info
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: offer.business.businessPhoto != null
                          ? "http://10.0.2.2:8000/storage/${offer.business.businessPhoto!}"
                          : "http://10.0.2.2:8000/storage/default_business.jpg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.business, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.business.businessName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          offer.business.user!.name,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Offer Details Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Investment Amount', offer.formattedAmount),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                        'Requested Equity', offer.formattedPercentage),
                    const SizedBox(height: 12),
                    _buildDetailRow('Offer Date', offer.formattedDate),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Status',
                      offer.status.toUpperCase(),
                      valueColor: offer.statusColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Message
              const Text(
                'Your Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  offer.message,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 24),

              // Actions

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  void _withdrawOffer(GetOfferModel offer) {
    // Implement withdraw functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Offer'),
        content: const Text(
            'Are you sure you want to withdraw this investment offer?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Offer #${offer.id} withdrawn'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Withdraw', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _modifyOffer(GetOfferModel offer) {
    // Implement modify offer functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Modify offer functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
