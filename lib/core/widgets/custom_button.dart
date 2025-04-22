import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investement_app/gen/assets.gen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: SvgPicture.asset(
            Assets.images.btnShape.path,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
