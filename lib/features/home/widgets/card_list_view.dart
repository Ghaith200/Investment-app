import 'package:flutter/material.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/screens/buissness_deatil_screen.dart';
import 'package:investement_app/features/home/widgets/squared_button.dart';

class CardListView extends StatelessWidget {
  final List<BusinessModel> cards;
  const CardListView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final business = cards[index];
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              business.businessPhoto != null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        "http://10.0.2.2:8000/storage/${business.businessPhoto!}",
                        height: size.height * 0.2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: size.height * 0.2,
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image)),
                    ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.businessName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(business.description,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SquaredButton(
                          text: 'More Info',
                          icon: Icons.info,
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
                        SquaredButton(
                          text: 'Invest',
                          icon: Icons.attach_money,
                          onTap: () {
                            // تنفيذ الاستثمار هنا
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
