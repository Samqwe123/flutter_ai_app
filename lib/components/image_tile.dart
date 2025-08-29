import 'package:flutter/material.dart';
import '../models/image.dart';

class ImageTile extends StatelessWidget {
  ImageModel image;
  void Function()? onTap;
  ImageTile({super.key, required this.image,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
      width: 245,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //shoe pic
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image.imagePath, width: 180, height: 180),
          ),

          //price + details
          
          
          Container(
            color: Colors.black,
            child:Center(
              child: Text(image.description, style: TextStyle(color: Colors.grey[600])),

            ) ,
          ),

          // button to add to favorite
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
  
                  children: [
                    Text(image.name , style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    const SizedBox(height: 5),
                    Text('\$ '+ image.price , style: const TextStyle(color:Colors.grey,fontSize: 12)),
                  ],
                ),
              ),

              GestureDetector(
                onTap:onTap,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Icon(Icons.favorite, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
