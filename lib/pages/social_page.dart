import 'package:e_commerce/models/favorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<favoriteImage>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(child: Text("social")),
      ),
    );
  }
}
