import 'package:e_commerce/app/auth_service.dart';
import 'package:e_commerce/components/bottom_navbar.dart';
import 'package:e_commerce/pages/cart_page.dart';
import 'package:e_commerce/pages/game_test.dart';
import 'package:e_commerce/pages/gemini_chat.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/pages/main_page.dart';
import 'package:e_commerce/pages/register_page.dart';
import 'package:e_commerce/pages/shop_page.dart';
import 'package:e_commerce/pages/social_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final List<Widget> _pages = [const ShopPage(), const GeminiChatPage() , const CartPage(), const GamePage()];

  final List<String> _titles = ['Shop', 'Chat', 'Cart', 'Game'];

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
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
        width: 220,
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
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
                onTap: () async{
                  await authService.value.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
                },
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
