import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/service/wishlist_services.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessModel business;
  const BusinessDetailScreen({super.key, required this.business});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  bool isWishlisted = false;

  Future<void> handleWishlist() async {
    final success = await WishlistService.addToWishlist(widget.business.id!);
    if (success) {
      setState(() {
        isWishlisted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add to wishlist")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final business = widget.business;
    final createdAtFormatted = DateFormat('MMMM d, y')
        .format(DateTime.parse(business.category.createdAt));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              const Text("Overview", style: TextStyle(color: Colors.blue)),
              const SizedBox(width: 16),
              const Text("FAQ", style: TextStyle(color: Colors.grey)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: handleWishlist,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (business.businessPhoto != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "http://10.0.2.2:8000/storage/${business.businessPhoto!}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.description,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    Text(
                      business.businessName,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 6),
                    Text("@${business.userId}",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.business, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(business.businessModel),
                        const Spacer(),
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(business.location),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.monetization_on,
                                  color: Colors.green),
                              const SizedBox(width: 8),
                              Text("${business.moneyNeeded} Needed"),
                              const Spacer(),
                              const Icon(Icons.people_outline,
                                  color: Colors.orange),
                              const SizedBox(width: 8),
                              Text(business.targetMarket),
                              const Spacer(),
                              const Icon(Icons.calendar_today,
                                  color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(createdAtFormatted),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            business.competitiveAdvantages,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Invest Now"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                TextField(
                                  decoration:
                                      InputDecoration(labelText: 'Percentage'),
                                ),
                                TextField(
                                  decoration:
                                      InputDecoration(labelText: 'Offer Money'),
                                ),
                                TextField(
                                  decoration:
                                      InputDecoration(labelText: 'Valuation'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton(
                                child: const Text("Submit"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Center(
                        child: Text(
                          "Invest Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
