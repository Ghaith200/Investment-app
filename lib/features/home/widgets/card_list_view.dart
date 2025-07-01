import 'package:flutter/material.dart';
import 'package:investement_app/features/home/models/category_model.dart';
import 'package:investement_app/features/home/widgets/squared_button.dart';
import 'package:investement_app/gen/assets.gen.dart';

class CardListView extends StatelessWidget {
  final List<Category> cards;
  const CardListView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return ListView.builder(
      itemCount: cards.length,
      padding: EdgeInsets.only(bottom: height * 0.02),
      itemBuilder: (context, index) {
        final category = cards[index];

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: height * 0.015,
          ),
          padding: EdgeInsets.only(bottom: height * 0.015),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.03),
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * 0.03),
                      topRight: Radius.circular(width * 0.03),
                    ),
                    child: Image.asset(
                      Assets.images.project1.path,
                      width: double.infinity,
                      height: height * 0.22,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: height * 0.01,
                    left: width * 0.02,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_outlined,
                        color: const Color.fromARGB(255, 2, 0, 109),
                        size: height * 0.03,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.01,
                    right: width * 0.02,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        color: const Color.fromARGB(255, 2, 0, 109),
                        size: height * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.025,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      category.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: height * 0.018),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        SquaredButton(
                          text: 'View Details',
                          icon: Icons.info_outline,
                        ),
                        SquaredButton(
                          text: 'Invest Now',
                          icon: Icons.attach_money,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              width: height * 0.04,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  Assets.images
                                      .a00756f144a0fb5daaf68dbfc01103a46.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.015),
                            Text(
                              'Category ID: ${category.id}',
                              style: TextStyle(
                                fontSize: height * 0.017,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        SquaredButton(
                          text: 'Created: ${category.createdAt.split('T')[0]}',
                          icon: Icons.calendar_today,
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
