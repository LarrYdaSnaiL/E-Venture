import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dynamicHeight = (size.height * 0.06).clamp(45.0, 60.0);

    final dynamicFontSize = (size.width * 0.04).clamp(14.0, 18.0);
    final dynamicIconSize = (size.width * 0.06).clamp(20.0, 24.0);

    return Container(
      height: dynamicHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD64F5C), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: dynamicFontSize,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: dynamicFontSize,
            color: const Color(0xFFCCCCCC),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFD64F5C),
            size: dynamicIconSize,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          isDense: true,
        ),
      ),
    );
  }
}
