import 'package:flutter/material.dart';
import 'package:pingpong/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.buttonName, this.onTap});

  String buttonName;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
              fontFamily: kFont,
              color: Colors.deepPurple,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
