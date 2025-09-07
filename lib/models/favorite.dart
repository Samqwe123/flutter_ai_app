import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class favoriteImage extends ChangeNotifier {
  // list of shoes for sale
  List<ImageModel> imageShop = [
    ImageModel(
      id: '01',
      name: 'WH123',
      price: "322",
      description: "experience the peak",
      imagePath: 'lib/images/speaker.png',
    ),
    ImageModel(
      id: '02',
      name: 'YT577',
      price: "766",
      description: "worth for ur life",
      imagePath: 'lib/images/Vands.png',
    ),
    ImageModel(
      id: '03',
      name: 'WH005',
      price: "1233",
      description: "experience every lyrics in details",
      imagePath: 'lib/images/WH.png',
    ),
    ImageModel(
      id: '04',
      name: 'WH007',
      price: "priceless",
      description: "cool!",
      imagePath: 'lib/images/clown1.png',
    ),
  ];

  Future<void> fetchUserCart() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null){
      final snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('cart').get();

      userCart = snapshot.docs.map((doc) {
        final data = doc.data();
        return ImageModel(
          id: data['id'],
          name: data['name'],
          price: data['price'],
          description: data['description'],
          imagePath: data['imagePath'],
        );
      }).toList();

      notifyListeners();
    }
  }

  List<ImageModel> getImageList() {
    return imageShop;
  }

  // list of items in user cart
  List<ImageModel> userCart = [];

  // get cart
  List<ImageModel> getUserCart() {
    
    return userCart;
  }

  // add items to cart

  void addItemToCart(ImageModel image) {
    userCart.add(image);
    notifyListeners();
  }

  // remove item from cart
  void removeItemInCart(ImageModel image) async {
    userCart.remove(image);
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(image.id)
          .delete();
    }
  }
}
