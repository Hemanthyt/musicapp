// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final Icon? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      obscureText: isObscureText,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
