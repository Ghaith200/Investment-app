// import 'package:flutter/material.dart';

// class StartButton extends StatelessWidget {
//   final name;
//   final text;
//   final push;
//   const StartButton(
//       {super.key, required this.name, required this.text, this.push});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//       height: 75,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blueAccent.shade400,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           shadowColor: Colors.blueAccent,
//           elevation: 10,
//         ),
//         onPressed: () {
//           push;
//         },
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 29, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
