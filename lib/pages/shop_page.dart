import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/components/image_tile.dart';
import 'package:e_commerce/models/favorite.dart';
import 'package:e_commerce/models/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void addItemToCart(ImageModel image) async{
    
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).collection('cart').doc(image.id).set({
      'id': image.id,
      'name': image.name,
      'price': image.price,
      'description': image.description,
      'imagePath': image.imagePath,
    });
    

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("add into cart successfully.",textAlign: TextAlign.center,),
        content: Text('Check your cart',textAlign: TextAlign.center,),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<favoriteImage>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Search here", style: TextStyle(color: Colors.grey)),
                  Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                'check the latest update..',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    'Latest update ❤️‍🔥',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  ImageModel image = value.getImageList()[index];
                  return ImageTile(
                    image: image,
                    onTap: () {
                      addItemToCart(image);
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Divider(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
