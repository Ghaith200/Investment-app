import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:investement_app/core/utils/extensions.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/screens/buissness_deatil_screen.dart';
import 'package:investement_app/features/myBuisness/screens/bussiness_offers_screen.dart';
import 'package:investement_app/features/myBuisness/services/my_buissness_service.dart';

class MyBusinessesScreen extends StatefulWidget {
  static const id = '/my_buissness';
  const MyBusinessesScreen({super.key});

  @override
  State<MyBusinessesScreen> createState() => _MyBusinessesScreenState();
}

class _MyBusinessesScreenState extends State<MyBusinessesScreen> {
  late Future<List<BusinessModel>> _futureBusinesses;

  @override
  void initState() {
    super.initState();
    _futureBusinesses = BusinessService.getMyBusinesses();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureBusinesses = BusinessService.getMyBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Businesses",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add navigation to create business screen
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<BusinessModel>>(
          future: _futureBusinesses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildEmptyState();
            } else {
              final businesses = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: businesses.length,
                itemBuilder: (context, index) {
                  final business = businesses[index];
                  return _buildBusinessCard(context, business);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBusinessCard(BuildContext context, BusinessModel business) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BusinessDetailScreen(business: business),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Business Image
                  Hero(
                    tag: 'business-${business.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://10.0.2.2:8000/storage/${business.businessPhoto!}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Icon(Icons.business, size: 40),
                        ),
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
                          business.businessName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          business.category.name,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              business.location,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // Business Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(
                    "Valuation",
                    "\$${business.valuation.formatAsCurrency()}",
                    Icons.assessment,
                  ),
                  _buildStatItem(
                    "Funding Needed",
                    "\$${business.moneyNeeded.formatAsCurrency()}",
                    Icons.attach_money,
                  ),
                  _buildStatItem(
                    "Equity",
                    "${business.percentageOffered}%",
                    Icons.pie_chart,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Status and Action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: business.isActive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          business.isActive ? Icons.check_circle : Icons.cancel,
                          size: 16,
                          color: business.isActive ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          business.isActive ? "Active" : "Inactive",
                          style: TextStyle(
                            color:
                                business.isActive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BusinessOffersScreen(businessId: business.id!),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                      child: const Text('View Offers'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_business.png', // Add your own empty state image
              width: 200,
              height: 200,
              color: Colors.blueAccent.withOpacity(0.2),
            ),
            const SizedBox(height: 24),
            const Text(
              "No Businesses Yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "You haven't created any businesses yet. Start by adding your first business!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Add navigation to create business screen
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Your First Business"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
