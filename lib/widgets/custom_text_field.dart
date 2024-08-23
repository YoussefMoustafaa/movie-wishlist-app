import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,

  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        color: const Color(0xffdfdddd),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          icon: const Icon(Icons.account_circle_rounded),
          label: Text(labelText),
          border: InputBorder.none,
        ),
        // validator: (value) {},
      ),
    );
  }
}