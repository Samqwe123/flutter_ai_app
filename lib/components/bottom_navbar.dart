import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {

  void Function(int)? onTabChange1;

  MyBottomNavBar({super.key,required this.onTabChange1});

  @override
  Widget build(BuildContext context) {

    
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12,top: 12),
        child: GNav(
          color: Colors.grey[400],
          activeColor: Colors.grey.shade800,
          tabActiveBorder: Border.all(
            color: const Color.fromARGB(255, 220, 214, 158),
          ),
          tabBackgroundColor: Colors.grey.shade100,
          tabBorderRadius: 25,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onTabChange: (value) {
            onTabChange1!(value);
            print("Tab $value selected");
          },

          tabs: [
            GButton(icon: Icons.home, text: ' Home'),
            GButton(icon: Icons.people, text: ' Social'),
            GButton(icon: Icons.shop, text: 'Cart'),
            GButton(icon: Icons.app_registration, text: 'Login')
          ],
        ),
      ),
    );
  }
}
