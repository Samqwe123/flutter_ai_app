import 'package:e_commerce/components/bottom_navbar.dart';
import 'package:e_commerce/pages/cart_page.dart';
import 'package:e_commerce/pages/gemini_chat.dart';
import 'package:e_commerce/pages/shop_page.dart';
import 'package:e_commerce/pages/social_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [const ShopPage(), const GeminiChatPage() , const CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Image.asset('lib/images/incognito.png')),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Divider(color: Colors.grey),
                ),
                Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Home'),
                    textColor: Colors.white,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.info, color: Colors.white),
                    title: Text('about'),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0,bottom: 30.0),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('logout'),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange1: (index) {
          navigateBottomBar(index);
        },
      ),

      body: _pages[_selectedIndex],
    );
  }
}
