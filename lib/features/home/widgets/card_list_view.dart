import 'package:flutter/material.dart';
import 'package:investement_app/features/home/models/category_model.dart';
import 'package:investement_app/features/home/widgets/squared_button.dart';
import 'package:investement_app/gen/assets.gen.dart';

class CardListView extends StatelessWidget {
  final List<Category> cards;
  const CardListView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final category = cards[index];
            return Column(children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02),
                height: 324,
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
                child: Column(children: [
                  Stack(alignment: Alignment.topCenter, children: [
                    SizedBox(
                      height: size.height * 0.16,
                      child: Image.asset(
                        width: size.width,
                        Assets.images.project1.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: const Color.fromARGB(255, 2, 0, 109),
                              size: size.height * 0.03,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border_outlined,
                              color: const Color.fromARGB(255, 2, 0, 109),
                              size: size.height * 0.03,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  const SizedBox(height: 8),
                  Center(
                    child: Column(children: [
                      Text(
                        category.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.03),
                      ),
                      Text(category.description),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 10),
                      SquaredButton(
                        text: 'View Details',
                        icon: Icons.info_outline,
                      ),
                      SizedBox(width: 10),
                      SquaredButton(
                        text: 'Invest Now',
                        icon: Icons.attach_money,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  Assets.images
                                      .a00756f144a0fb5daaf68dbfc01103a46.path,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            'Category ID: ${category.id}',
                            style: TextStyle(color: Colors.blue.shade900),
                          )
                        ],
                      ),
                      SquaredButton(
                        text: 'Created: ${category.createdAt.split('T')[0]}',
                        icon: Icons.calendar_today,
                      ),
                    ],
                  ),
                ]),
              ),
            ]);
          }),
    );
  }
}
