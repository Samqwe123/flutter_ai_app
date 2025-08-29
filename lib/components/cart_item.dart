import 'package:e_commerce/models/favorite.dart';
import 'package:e_commerce/models/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  ImageModel image;
  CartItem({super.key, required this.image});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void removeItemFromCart(){
    Provider.of<favoriteImage>(context,listen: false).removeItemInCart(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        
        child: ListTile(
          leading: Image.asset(widget.image.imagePath),
          title: Text(widget.image.name),
          subtitle: Text(widget.image.price),
          trailing:IconButton(onPressed: removeItemFromCart, icon: Icon(Icons.delete)), iconColor: Colors.black,
        ),
      ),
    );
  }
}
