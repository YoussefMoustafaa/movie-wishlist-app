import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonText
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {}, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.02)))
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.05,
        ),
      ),
    );
  }
}