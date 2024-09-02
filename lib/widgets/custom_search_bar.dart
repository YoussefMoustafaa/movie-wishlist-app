import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {

  final Function(String) onSearch;
  final TextEditingController _controller = TextEditingController();

  CustomSearchBar({
    super.key,
    required this.onSearch
    });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.06,
      padding: EdgeInsets.only(left: screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        color: const Color(0xFF2E2E2F)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                icon: const Icon(Icons.search, color: Color(0xFFA5A5A5),),
                hintText: 'Search for a movie',
                hintStyle: TextStyle(
                  color: const Color(0xFFA5A5A5),
                  fontSize: screenWidth * 0.035
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Color(0xFFA5A5A5)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onSearch(_controller.text);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromHeight(screenHeight * 0.9),
              backgroundColor: const Color(0xFF4B4B4B),
              foregroundColor: const Color(0xFFC7C5B1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(screenWidth * 0.02),  bottomRight: Radius.circular(screenWidth * 0.02)),
              )
            ),
            child: Text(
              'Search',
              style: TextStyle(fontSize: screenWidth * 0.035),
            )
          )
        ],
      )
    );
  }
}