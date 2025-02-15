import 'package:flutter/material.dart';
import 'package:investement_app/gen/assets.gen.dart';
import 'package:investement_app/widgets/SquaredButton.dart';

class CardListView extends StatelessWidget {
  final List cards;
  const CardListView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02),
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(alignment: Alignment.topCenter, children: [
                        Container(
                          height: size.height * 0.14,
                          child: Image.asset(
                            width: size.width,
                            Assets
                                .images.a00756f144a0fb5daaf68dbfc01103a46.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: size.height * 0.02),
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
                      // SizedBox(height: size.height * 0.01),
                      Container(
                        // color: Colors.black12,
                        child: Center(
                          child: Column(children: [
                            Text(
                              'Project name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.03),
                            ),
                            Text('A small description about the project'),
                          ]),
                        ),

                      ),
                    ),
                    Container(
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
                  // SizedBox(height: size.height * 0.01),
                  Container(
                    // color: Colors.black12,
                    child: Center(
                      child: Column(children: [
                        Text(
                          'Project name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.03),
                        ),
                        Text('A small description about the project'),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Squaredbutton(
                        text: 'Required Money:',
                        icon: Icons.attach_money,
                      ),
                      Squaredbutton(
                        text: 'Required Ratio:',
                        icon: Icons.percent,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
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
                            'Project Owner Name',
                            style: TextStyle(color: Colors.blue.shade900),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Squaredbutton(
                          text: 'View',
                          icon: Icons.visibility,
                        ),
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
