import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/buildsaved.dart';
import 'package:nutrilab/menudetails.dart';
import './snackbar.dart';

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
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Handle user not logged in
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot userDoc = await userRef.get();
      // Map<String, dynamic>? userData =
      //     userDoc.data() as Map<String, dynamic>?; // Get user data
      List liked = userDoc['liked'] ?? [];

      if (liked.contains(widget.itemId)) {
        if (mounted){
          setState(() {
          isLiked = true;
        });
        }
        
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _toggleLiked() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Handle user not logged in
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      if (isLiked) {
        // If item is already liked, remove it from the array
        await userRef.update({
          'liked': FieldValue.arrayRemove([widget.itemId])
        });
        if (mounted){
          setState(() {
          isLiked = false;
        });
        }
        
        showNotif(context,'Item removed from liked!');
        context.findAncestorStateOfType<BuildSavedState>()?.rebuild();
      } else {
        // If item is not liked, add it to the array
        await userRef.update({
          'liked': FieldValue.arrayUnion([widget.itemId])
        });
        if (mounted){
          setState(() {
          isLiked = true;
        });
        }
        
        showNotif(context,'Item added to liked!');
      }
    } catch (e) {
      showNotif(context,'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate width for each grid item (considering cross axis count of 2)
    double itemWidth =
        (screenWidth - 26) / 2; // 30 is for padding/margin adjustment
    double itemHeight = screenHeight * 0.35; // Adjust height as necessary

    return Container(
      height: itemHeight,
      width: itemWidth,
      margin: EdgeInsets.all(2), // Add margin for spacing between items
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                cal: widget.cal,
                des: widget.des,
                img: widget.img,
                ingr: widget.ingr,
                itemId: widget.itemId,
                name: widget.name,
                price: widget.price,
                type: widget.type,
              ),
            ),
          );
        },
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
                        aspectRatio: 16/11, // Adjust as necessary
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  constraints: BoxConstraints.tightFor(),
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 125, 172, 106),
                                      width: 1,
                                    ),
                                  ),
                                  // alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.type,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 24, 79, 87),
                                      fontSize: screenWidth *
                                          0.028, // Adjust font size based on screen width
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Rs. ${widget.price}",
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Color.fromARGB(255, 24, 79, 87),
                                  fontSize: screenWidth *
                                      0.032, // Adjust font size based on screen width
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  // overflow: TextOverflow.ellipsis,
                                  widget.name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Lalezar',
                                    color: Color.fromARGB(255, 24, 79, 87),
                                    fontSize: itemWidth *
                                        0.075, // Adjust font size based on screen width
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color.fromARGB(255, 125, 172, 106),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: const Color.fromARGB(255, 127, 189, 129),
                        ),
                        onPressed: _toggleLiked,
                      ),
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
