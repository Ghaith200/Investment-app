import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/home/data/offer_cubit.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/screens/buissness_deatil_screen.dart';
import 'package:investement_app/features/home/widgets/squared_button.dart';
import 'package:investement_app/gen/assets.gen.dart';

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
              CachedNetworkImage(
                imageUrl:
                    "http://10.0.2.2:8000/storage/${business.businessPhoto}",
                placeholder: (context, url) => Container(
                  height: size.height * 0.2,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: size.height * 0.2,
                  color: Colors.grey.shade200,
                  child: Center(
                      child: Image.asset(
                    Assets.images.project1.path,
                    fit: BoxFit.cover,
                  )),
                ),
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
                                builder: (_) => BlocProvider(
                                  create: (context) => OfferCubit(),
                                  child:
                                      BusinessDetailScreen(business: business),
                                ),
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
