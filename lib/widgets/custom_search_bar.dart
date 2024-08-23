import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.06,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        color: const Color(0xFF2E2E2F)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                label: Text('Search for a movie'),
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B4B4B),
              foregroundColor: const Color(0xFFC7C5B1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              )
            ),
            child: Text(
              'Search',
              style: TextStyle(fontSize: screenWidth * 0.04),
            )
          )
        ],
      )
    );
  }
}