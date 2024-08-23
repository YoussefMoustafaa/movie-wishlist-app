import 'package:flutter/material.dart';
import 'package:movie_wish_list/widgets/custom_elevated_button.dart';
import 'package:movie_wish_list/widgets/custom_text_field.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.1,),
            Text(
              'Welcome!',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.1,
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            Text(
              'Movie Wishlist App',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.09,
              ),
            ),
            SizedBox(height: screenHeight * 0.1,),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                child: Column(
                  children: [
                    const CustomTextField(labelText: 'Username',),
                    SizedBox(height: screenHeight * 0.012,),
                    const CustomTextField(labelText: 'Password',),
                    SizedBox(height: screenHeight * 0.024,),
                    const CustomElevatedButton(buttonText: 'Login'),
                    SizedBox(height: screenHeight * 0.012,),
                    const CustomElevatedButton(buttonText: 'Register'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}