import 'package:flutter/material.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/screens/buissness_deatil_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Businesses")),
      body: FutureBuilder<List<BusinessModel>>(
        future: _futureBusinesses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No businesses found."));
          } else {
            final businesses = snapshot.data!;
            return ListView.builder(
              itemCount: businesses.length,
              itemBuilder: (context, index) {
                final business = businesses[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: business.businessPhoto != null
                        ? Image.network(
                            "http://10.0.2.2:8000/storage/${business.businessPhoto}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.business),
                    title: Text(business.businessName),
                    subtitle: Text(business.category.name),
                    trailing: Icon(
                      business.isActive ? Icons.check_circle : Icons.cancel,
                      color: business.isActive ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BusinessDetailScreen(business: business),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
