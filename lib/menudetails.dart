import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './snackbar.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;

  const DetailsPage({
    super.key,
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
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLiked = false;
  int quantity = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
    _checkQt();
  }

  void _checkQt() {
    Future<int> n = _fetchQt();
    n.then((value) {
      setState(() {
        quantity = value;
      });
    });
  }

  Future<int> _fetchQt() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Handle user not logged in
      return 0;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot userDoc =
          await userRef.get(); 
      Map<String, dynamic> cart = userDoc['cart'] ?? {}; 
      return cart[widget.itemId] ?? 0;
    } catch (e) {
      log("Error fetching user document: $e");
      return 0;
    }
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
      Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?; // Get user data
      List liked = userData?['liked'] ?? [];

      if (liked.contains(widget.itemId)) {
        setState(() {
          isLiked = true;
        });
      }
    } catch (e) {
      log("Error fetching user document: $e");
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
        setState(() {
          isLiked = false;
        });
        showNotif(context, 'Item removed from liked!');
      } else {
        // If item is not liked, add it to the array
        await userRef.update({
          'liked': FieldValue.arrayUnion([widget.itemId])
        });
        setState(() {
          isLiked = true;
        });
        showNotif(context, 'Item added to liked!');
      }
    } catch (e) {
      log("Error fetching user document: $e");
    }
  }

  Future<void> _removeFromCart() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      log("Not logged in");
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot userDoc =
          await userRef.get(); 
      Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?; 
      Map<String, dynamic> cart = userData?['cart'] ?? {}; 

      cart[widget.itemId] = (cart[widget.itemId] ?? 1) - 1;
      setState(() {
        quantity = cart[widget.itemId];
      });
      await userRef.update({'cart': cart}); // Update user document
      showNotif(context, '1 Item removed from cart!');
    } catch (e) {
      log("Error fetching user document: $e");
      // Handle error
    }
  }

  Future<void> _addToCart() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      log("Not logged in");
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot userDoc =
          await userRef.get(); // Await the userDoc retrieval
      Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?; // Get user data
      Map<String, dynamic> cart = userData?['cart'] ?? {}; // Get cart data
      cart[widget.itemId] = (cart[widget.itemId] ?? 0) + 1; // Update cart
      setState(() {
        quantity = cart[widget.itemId];
      });
      await userRef.update({'cart': cart}); // Update user document
      showNotif(context, '1 Item added to cart!');
    } catch (e) {
      log("Error fetching user document: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.07;
    double containerWidth = MediaQuery.of(context).size.width * 0.07;
    double height = MediaQuery.of(context).size.height * 0.05;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Column(children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      AspectRatio(
                        aspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height *
                                0.4), // Set aspect ratio to occupy half of the page
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              widget.img,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black.withOpacity(
                                  0.5), 
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            Text(
                              widget.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lalezar',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = Color.fromARGB(255, 153, 222, 233),
                              ),
                            ),
                            Text(
                              widget.name.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                color: Color.fromARGB(255, 24, 79, 87),
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *0.6,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        color: Color.fromARGB(
                                            255, 125, 172, 106),
                                        width: 1)),
                                // alignment: Alignment.topLeft,
                                child: Text(
                                  widget.type,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 24, 79, 87),
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            Text(
                              "Rs. ${widget.price}",
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                color: Color.fromARGB(255, 24, 79, 87),
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.des,
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Gayathri'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Calories: ${widget.cal}cal",
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'Gayathri'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingredients: ${widget.ingr}",
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'Gayathri'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Text("Quantity: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Gayathri',
                                      color: Color.fromARGB(255, 24, 79, 87),
                                    )),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                height: height,
                                width: buttonWidth,
                                child: ElevatedButton(
                                  onPressed:
                                      (quantity > 0) ? _removeFromCart : null,
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 24, 79, 87),
                                    ),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Color.fromARGB(255, 24, 79, 87),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.005,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 24, 79, 87),
                                )),
                                height: height,
                                width: containerWidth,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.007),
                                // color: Color.fromARGB(255, 255, 255, 255),
                                alignment: Alignment.center,
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gayathri',
                                    color: Color.fromARGB(255, 24, 79, 87),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.005,
                              ),
                              Container(
                                height: height,
                                width: buttonWidth,
                                child: ElevatedButton(
                                  onPressed: _addToCart,
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 24, 79, 87),
                                    ),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 24, 79, 87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 228, 228),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Color.fromARGB(255, 24, 79, 87),
                      ),
                      onPressed: _toggleLiked,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 228, 228),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 24, 79, 87),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
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
