import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/cartitem.dart';
import 'package:nutrilab/checkout.dart';

class BuildCart extends StatefulWidget {
  const BuildCart({super.key});

  @override
  State<BuildCart> createState() => BuildCartState();
}

class BuildCartState extends State<BuildCart> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> cart = {};
  Map<DocumentSnapshot, int> documents = {};
  int totalItems = 0;
  int totalPrice = 0;
  @override
  void initState() {
    super.initState();
    _initializeCartItems();
  }

  Future<void> _initializeCartItems() async {
    await _checkCart();
    await fetchDocuments(cart);
    // if (mounted) {
    //   setState(
    //       () {}); 
    // }
  }

  Future<void> _checkCart() async {
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
          userDoc.data() as Map<String, dynamic>?; 
      setState(() {
        cart = userData?['cart'] ?? {};
      });
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> fetchDocuments(Map<String, dynamic> docIds) async {
    for (var entry in docIds.entries) {
      String docId = entry.key;
      int quantity = entry.value;
      if (quantity > 0) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('menuitems')
            .doc(docId)
            .get();

        if (docSnapshot.exists) {
          var data = docSnapshot.data() as Map<String, dynamic>;
          int price = data['Price'] as int;
          setState(() {
            totalPrice += quantity * price;
            totalItems += quantity;
            documents[docSnapshot] = quantity;
          });
        }
      }
    }
  }

  Future<void> rebuild() async {
    if (mounted) {
      setState(() {
        documents = {};
        totalItems = 0;
        totalPrice = 0;
      });
    }

    await _initializeCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('menuitems').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 24, 79, 87),
            ),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            totalItems == 0) {
          return Center(
            child: Text(
              'No items in cart.',
              style: TextStyle(
                fontFamily: 'Lalezar',
                color: Color.fromARGB(255, 83, 83, 83),
                fontSize: 25,
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final entry = documents.entries.elementAt(index);
                  final doc = entry.key;
                  final data = doc.data() as Map<String, dynamic>;

                  return Column(children: [
                    SizedBox(height: 10),
                    CartItemWidget(
                      name: data['Name'],
                      des: data['Description'],
                      img: data['Image'],
                      ingr: data['Ingr'],
                      type: data['Type'],
                      cal: data['Calories'],
                      price: data['Price'],
                      itemId: doc.id,
                    ),
                  ]);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Order Summary',
                style: TextStyle(
                  fontFamily: 'Lalezar',
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ITEMS         $totalItems',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 53, 53, 53),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'RS.$totalPrice.00',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 70, 112, 72),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHIPPING COSTS',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 53, 53, 53),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Rs.40.00',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 70, 112, 72),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL AMOUNT',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 53, 53, 53),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'RS. ' + (totalPrice + 40.00).toString() + '.00',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 70, 112, 72),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoToCheckout(
                          price: totalPrice,
                          items: totalItems,
                        ),
                      ),
                    );
                    rebuild();
                  },
                  child: Text(
                    "CHECKOUT",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos',
                      color: Color.fromARGB(255, 225, 226, 209),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 9),
                    backgroundColor: Color.fromARGB(255, 24, 79, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
