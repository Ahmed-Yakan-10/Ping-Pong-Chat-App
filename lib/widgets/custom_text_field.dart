import 'package:flutter/material.dart';
import 'package:pingpong/constants.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({super.key, this.labelText, this.icon, this.onChanged, this.obscureText = false});

  String? labelText;
  IconData? icon;

  Function(String)? onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if(data!.isEmpty){
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: Colors.white
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: Colors.white
          ),
        ),
        hintText: 'Enter your $labelText',
        hintStyle: const TextStyle(
          fontFamily: kFont,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: kFont,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(icon),
        prefixIconColor: Colors.white,
      ),
    );
  }
}
