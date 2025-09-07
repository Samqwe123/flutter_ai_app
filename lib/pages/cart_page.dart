import 'package:e_commerce/components/cart_item.dart';
import 'package:e_commerce/models/favorite.dart';
import 'package:e_commerce/models/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override

  void initState(){
    super.initState();

    Future.microtask(() {
      Provider.of<favoriteImage>(context, listen: false).fetchUserCart();
    });
  }
  
  Widget build(BuildContext context) {
    return Consumer<favoriteImage>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  // get individual image
                  ImageModel individualImage = value.getUserCart()[index];

                  return CartItem(image: individualImage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
