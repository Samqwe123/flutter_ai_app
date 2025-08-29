import 'package:e_commerce/models/image.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class favoriteImage extends ChangeNotifier{
  // list of shoes for sale
  List<ImageModel> imageShop = [
    ImageModel(name: 'WH123', price: "322", description: "experience the peak", imagePath: 'lib/images/speaker.png'),
    ImageModel(name: 'YT577', price: "766", description: "worth for ur life", imagePath: 'lib/images/Vands.png'),
    ImageModel(name: 'WH005', price: "1233", description: "experience every lyrics in details", imagePath: 'lib/images/WH.png'),
    ImageModel(name: 'WH007', price: "priceless", description: "cool!", imagePath: 'lib/images/clown1.png'),
  ];

  List<ImageModel> getImageList(){
    return imageShop;
  }

  // list of items in user cart
  List<ImageModel> userCart = [];


  // get cart
  List<ImageModel> getUserCart(){
    return userCart;
  }

  // add items to cart

  void addItemToCart(ImageModel image){
    userCart.add(image);
    notifyListeners();
  }

  // remove item from cart
  void removeItemInCart(ImageModel image){
    userCart.remove(image);
    notifyListeners();
  }

}