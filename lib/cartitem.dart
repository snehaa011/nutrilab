import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/buildcart.dart';
import './snackbar.dart';
import './menudetails.dart';

class CartItemWidget extends StatefulWidget {
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;

  CartItemWidget({
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
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool isLiked = false;
  int quantity = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _checkIfLiked();
    _checkQt();
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

      if (liked.contains(widget.itemId) && mounted) {
        setState(() {
          isLiked = true;
        });
      }
    } catch (e) {
      log("Error fetching user document: $e");
    }
  }

  void _checkQt() {
    Future<int> n = _fetchQt();
    n.then((value) {
      if (mounted){
        setState(() {
        quantity = value;
      });
      }
      
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
          await userRef.get(); // Await the userDoc retrieval
      Map<String, dynamic> cart = userDoc['cart'] ?? {}; // Get cart data
      return cart[widget.itemId] ?? 0;
    } catch (e) {
      log("Error fetching user document: $e");
      return 0;
    }
  }

  Future<void> _saveForLater() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Handle user not logged in
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      if (!isLiked) {
        // If item is not liked, add it to the array
        await userRef.update({
          'liked': FieldValue.arrayUnion([widget.itemId])
        });
        if (mounted){
          setState(() {
          isLiked = true;
        });
        }
        showNotif(context, 'Saved for later!');
        _removeAll(show:0);
      }
    } catch (e) {
      log("Error fetching user document: $e");
    }
  }

  Future <void> _removeAll({int show=0}) async{
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

      cart[widget.itemId] = 0;
      if (mounted){
        setState(() {
        quantity = cart[widget.itemId];
      });
      }
      
      await userRef.update({'cart': cart}); // Update user document
      if (show==1) showNotif(context, 'Item removed from cart!');
      if (quantity == 0) {
      context.findAncestorStateOfType<BuildCartState>()?.rebuild();
    }
    } catch (e) {
      log("Error fetching user document: $e");
      // Handle error
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
          await userRef.get(); // Await the userDoc retrieval
      Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?; // Get user data
      Map<String, dynamic> cart = userData?['cart'] ?? {}; // Get cart data

      cart[widget.itemId] = (cart[widget.itemId] ?? 1) - 1;
      if (mounted){
        setState(() {
        quantity = cart[widget.itemId];
      });
      }
      
      await userRef.update({'cart': cart}); // Update user document
      showNotif(context, '1 Item removed from cart!');
      
      context.findAncestorStateOfType<BuildCartState>()?.rebuild();
    
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
      if (mounted){
        setState(() {
        quantity = cart[widget.itemId];
      });
      }
      
      await userRef.update({'cart': cart}); // Update user document
      showNotif(context, '1 Item added to cart!');
      context.findAncestorStateOfType<BuildCartState>()?.rebuild();
    } catch (e) {
      log("Error fetching user document: $e");
      // Handle error
    }
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = MediaQuery.of(context).size.width * 0.07;
    double containerWidth = MediaQuery.of(context).size.width * 0.07;
    double height = MediaQuery.of(context).size.height * 0.05;

    // Calculate width for each grid item (considering cross axis count of 2)
    double itemWidth =
        (screenWidth - 30); // 30 is for padding/margin adjustment
    double itemHeight = screenHeight * 0.2; // Adjust height as necessary
    return Container(
      height: itemHeight,
      width: itemWidth,
      margin: EdgeInsets.all(3),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: itemWidth*0.6,
                height: itemHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: itemWidth*0.4,
                            height: itemHeight*0.32,
                            child: SingleChildScrollView(
                              child: Text(
                                // overflow: TextOverflow.ellipsis,
                                widget.name.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Color.fromARGB(255, 24, 79, 87),
                                  fontSize: itemWidth *0.05, // Adjust font size based on screen width
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Rs. " + widget.price.toString(),
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              color: Color.fromARGB(255, 24, 79, 87),
                              fontSize: screenWidth *
                                  0.032, // Adjust font size based on screen width
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    // SizedBox(
                    //   height:itemHeight*0.003,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: _saveForLater, child: Text("Save for Later",
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 138, 207),
                            fontSize: 14,
                          ),
                          )),
                          TextButton(onPressed: (){_removeAll(show: 1);
                          }, child: Text("Remove",
                          style: TextStyle(
                            color: Color.fromARGB(255, 207, 64, 54),
                            fontSize: 14,
                          ),
                          )),
                        ],
                      ),
                    ),
                    // Spacer(),
                    // SizedBox(
                    //   height: itemHeight*0.003,
                    // ),
                    Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height,
                                  width: buttonWidth,
                                  child: ElevatedButton(
                                    onPressed:
                                        (quantity > 0) ? _removeFromCart : null,
                                    child: Icon(
                                      Icons.remove,
                                      color: Color.fromARGB(255, 24, 79, 87),
                                    ),
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
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 24, 79, 87),
                                    ),
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
                                  ),
                                ),

                  ],
                ),),
                SizedBox(
                  height:itemHeight*0.05
                ),
                // Spacer(),
                            ]
                          ),
              ),
          ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      ),
                      child: AspectRatio(
                        aspectRatio: (itemWidth*0.3)/itemHeight, // Adjust as necessary
                        child: Image.network(
                          widget.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ],),
    ),);
  }
}
