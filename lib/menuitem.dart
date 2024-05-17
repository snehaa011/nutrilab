import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItemWidget extends StatefulWidget {
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;

  MenuItemWidget({
    required this.name,
    required this.des,
    required this.img,
    required this.ingr,
    required this.type,
    required this.cal,
    required this.price,
    required this.itemId,
  });

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  bool isLiked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // void initState() {
  //   super.initState();
  //   _checkIfLiked();
  // }

  // Future<void> _checkIfLiked() async {
  //   User? currentUser = _auth.currentUser;
  //   if (currentUser == null) {
  //     // Handle user not logged in
  //     return;
  //   }

  //   String userId = currentUser.uid;
  //   DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  //   DocumentSnapshot userDoc = await userRef.get();
  //   List liked = userDoc['liked'] ?? [];

  //   if (liked.contains(widget.itemId)) {
  //     setState(() {
  //       isLiked = true;
  //     });
  //   }
  // }

  // Future<void> _toggleLiked() async {
  //   User? currentUser = _auth.currentUser;
  //   if (currentUser == null) {
  //     // Handle user not logged in
  //     return;
  //   }

  //   String userId = currentUser.uid;
  //   DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  //   if (isLiked) {
  //     // If item is already liked, remove it from the array
  //     await userRef.update({
  //       'liked': FieldValue.arrayRemove([widget.itemId])
  //     });
  //     setState(() {
  //       isLiked = false;
  //     });
  //   } else {
  //     // If item is not liked, add it to the array
  //     await userRef.update({
  //       'liked': FieldValue.arrayUnion([widget.itemId])
  //     });
  //     setState(() {
  //       isLiked = true;
  //     });
  //   }
  // }

  // Future<void> _addToCart() async {
  //   User? currentUser = _auth.currentUser;
  //   if (currentUser == null) {
  //     // Handle user not logged in
  //     return;
  //   }

  //   String userId = currentUser.uid;
  //   DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  //   await userRef.update({
  //     'cart': FieldValue.arrayUnion([widget.itemId])
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {},
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 13, // Adjust as necessary
                        child: Image.network(
                          widget.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      // alignment: Alignment.center,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              constraints: BoxConstraints.tightFor(),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color.fromARGB(255, 125, 172, 106), width: 1)
                            ),
                              // alignment: Alignment.topLeft,
                              child: Text(widget.type, style: TextStyle(color: Color.fromARGB(255, 24, 79, 87), fontSize: 14),)),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Text(widget.name.toUpperCase(), 
                          style: TextStyle(
                            fontFamily: 'Lalezar',
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color.fromARGB(255, 125, 172, 106), width: 1)
                          ),
                          child: IconButton(
                            
                              icon: Icon(Icons.shopping_cart_outlined, color: const Color.fromARGB(255, 127, 189, 129),),
                              onPressed: () {} //_addToCart,
                              ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color.fromARGB(255, 125, 172, 106), width: 1),
                          ),
                          child: IconButton(
                              icon: Icon(Icons.favorite_border, color: const Color.fromARGB(255, 127, 189, 129),),
                              onPressed: () {} //_addToCart,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
