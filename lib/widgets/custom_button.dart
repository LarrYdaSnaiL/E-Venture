import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLandscape;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? const Color(0xFFD64F5C) : const Color(0xFFFDE4E7),
        disabledBackgroundColor: const Color(0xFFFDE4E7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: size.height * 0.015),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: isLandscape ? size.height * 0.03 : size.width * 0.05,
          fontWeight: FontWeight.w600,
          color: isEnabled ? Colors.white : const Color(0xFFD64F5C),
        ),
      ),
    );
  }
}
