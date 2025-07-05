import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/core/models/offer_model.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/features/myBuisness/data/create_offers_cubit.dart';
import 'package:investement_app/features/myBuisness/data/create_offers_state.dart';

class BusinessOffersScreen extends StatelessWidget {
  final int businessId;
  const BusinessOffersScreen({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(businessId: businessId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Business Offers',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: BlocConsumer<OffersCubit, OffersState>(
          listener: (context, state) {
            if (state is OffersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is OfferAccepted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Offer accepted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is OfferRejected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Offer rejected successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is CounterOfferCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Counter offer created successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<OffersCubit>().loadOffers();
            }
          },
          builder: (context, state) {
            if (state is OffersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OffersLoaded) {
              return _buildOffersList(context, state.offers);
            } else if (state is OffersError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No offers yet'));
          },
        ),
      ),
    );
  }

  Widget _buildOffersList(BuildContext context, List<OfferModel> offers) {
    if (offers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('No Offers Yet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Your business hasn\'t received any offers yet',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Refresh',
              onPressed: () => context.read<OffersCubit>().loadOffers(),
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
        return _buildOfferCard(context, offer);
      },
    );
  }

  Widget _buildOfferCard(BuildContext context, OfferModel offer) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Investor Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Investor Profile
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: offer.investor.profileImage != null
                      ? CachedNetworkImage(
                          imageUrl:
                              "http://10.0.2.2:8000/storage/${offer.investor.profileImage!}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.person, size: 30),
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Icon(Icons.person, size: 30),
                        ),
                ),
                const SizedBox(width: 16),
                // Investor Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.investor.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.investor.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (offer.investor.title != null)
                        Text(
                          offer.investor.title!,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                    ],
                  ),
                ),
                // Status Badge
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
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Offer Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Offer Amount', offer.formattedAmount),
                _buildDetailItem('Equity Requested', offer.formattedPercentage),
                _buildDetailItem('Date', offer.formattedDate),
              ],
            ),
            const SizedBox(height: 16),

            // Message
            if (offer.message.isNotEmpty) ...[
              const Text(
                'Message',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  offer.message,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action Buttons
            if (offer.status == 'pending')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showCounterOfferDialog(context, offer),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                      child: const Text('Counter Offer'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          context.read<OffersCubit>().rejectOffer(offer.id),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<OffersCubit>().acceptOffer(offer.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Accept'),
                    ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
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

  void _showCounterOfferDialog(BuildContext context, OfferModel originalOffer) {
    final cubit = context.read<OffersCubit>();
    double counterAmount = originalOffer.offeredAmount;
    double counterPercentage = originalOffer.requestedPercentage;
    String message = "I'd like to propose a counter offer";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Make Counter Offer',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Offer Amount',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                initialValue: counterAmount.toString(),
                onChanged: (value) {
                  counterAmount = double.tryParse(value) ?? counterAmount;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Equity Percentage',
                  suffixText: '%',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                initialValue: counterPercentage.toString(),
                onChanged: (value) {
                  counterPercentage =
                      double.tryParse(value) ?? counterPercentage;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                initialValue: message,
                onChanged: (value) => message = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.counterOffer(
                originalOffer.id,
                offeredAmount: counterAmount,
                requestedPercentage: counterPercentage,
                message: message,
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: const Text('Submit Counter'),
          ),
        ],
      ),
    );
  }
}
