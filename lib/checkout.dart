// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './editprofile.dart';

class GoToCheckout extends StatefulWidget {
  final num price;
  final num items;
  const GoToCheckout({super.key, required this.price, required this.items});

  @override
  State<GoToCheckout> createState() => _GoToCheckoutState();
}

class _GoToCheckoutState extends State<GoToCheckout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';
  String mobile = '';
  Map<String, dynamic> address = {};
  String state = '';
  String city = '';
  String zip = '';
  String paymentMethod = 'cod'; // Default payment method
  bool isCardDetailsVisible = false;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
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
      if (mounted) {
        setState(() {
          name = userDoc['name'] ?? '';
          email = userDoc['email'] ?? '';
          mobile = userDoc['mobile'].toString();
          address = userDoc['address'] ?? {};
          if (address.isNotEmpty) {
            state = address['state'] ?? '';
            city = address['city'] ?? '';
            if (address.containsKey('zip') && address['zip'] != null) {
              zip = address['zip'].toString();
            }
          }
        });
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 226, 209),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Checkout",
              style: TextStyle(
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lalezar'),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 24, 79, 87),
              size: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                (address.isEmpty ||
                        state.isEmpty ||
                        city.isEmpty ||
                        zip.isEmpty)
                    ? TextButton(
                        onPressed: () async {
                          // Navigate to edit profile page
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                name: name,
                                mobile: mobile,
                                email: email,
                                state: state,
                                city: city,
                                zip: zip,
                              ),
                            ),
                          );
                          _getUser();
                        },
                        child: Text(
                          "Add address",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontFamily: 'Gayathri',
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontFamily: 'Gayathri',
                                fontWeight: FontWeight.w900,
                                fontSize: screenWidth * 0.05)),
                        Text(city,
                            style: TextStyle(
                                fontFamily: 'Gayathri',
                                fontSize: screenWidth * 0.05)),
                        Text(state,
                            style: TextStyle(
                                fontFamily: 'Gayathri',
                                fontSize: screenWidth * 0.05)),
                        Text(zip,
                            style: TextStyle(
                                fontFamily: 'Gayathri',
                                fontSize: screenWidth * 0.05)),
                        Text('Mobile: $mobile',
                            style: TextStyle(
                                fontFamily: 'Gayathri',
                                fontSize: screenWidth * 0.05)),
                        TextButton(
                          onPressed: () async {
                            // Navigate to edit profile page
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  name: name,
                                  mobile: mobile,
                                  email: email,
                                  state: state,
                                  city: city,
                                  zip: zip,
                                ),
                              ),
                            );
                            _getUser();
                          },
                          child: Text(
                            "Edit address",
                            style: TextStyle(
                              color: Color.fromARGB(255, 24, 79, 87),
                              fontFamily: 'Gayathri',
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text(
                  "Choose Payment Method:",
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 79, 87),
                    fontSize: screenWidth * 0.06,
                    fontFamily: 'Lalezar',
                  ),
                ),
                ListTile(
                  title: Text("Credit/Debit Card",
                      style: TextStyle(
                          fontFamily: 'Gayathri',
                          fontSize: screenWidth * 0.05)),
                  leading: Radio(
                    activeColor: Color.fromARGB(255, 24, 79, 87),
                    value: 'card',
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as String;
                        isCardDetailsVisible = true;
                      });
                    },
                  ),
                ),
                if (isCardDetailsVisible)
                  CardDetailsBox(
                    onClose: () {
                      setState(() {
                        isCardDetailsVisible = false;
                      });
                    },
                  ),
                ListTile(
                  title: Text("Cash on Delivery",
                      style: TextStyle(
                          fontFamily: 'Gayathri',
                          fontSize: screenWidth * 0.05)),
                  leading: Radio(
                    activeColor: Color.fromARGB(255, 24, 79, 87),
                    value: 'cod',
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as String;
                        isCardDetailsVisible = false;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal (${widget.items} items)',
                        style: TextStyle(
                          fontFamily: 'Lalezar',
                          color: Color.fromARGB(255, 53, 53, 53),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Rs. ${widget.price}',
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
                        'Shipping Costs',
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
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontFamily: 'Lalezar',
                            color: Color.fromARGB(255, 70, 112, 72),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Rs. ${widget.price + 40}',
                          style: TextStyle(
                            fontFamily: 'Lalezar',
                            color: Color.fromARGB(255, 70, 112, 72),
                            fontSize: 35,
                          ),
                        )
                      ]),
                      ElevatedButton(
                          onPressed: () async{
                            final updatedData = {
                              'cart':{}
                            };
                            try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email) 
                            .update(updatedData);
                        Navigator.pop(context);
                      } catch (e) {
                        print("Order failed: $e");
                      }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 24, 79, 87),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text("ORDER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Genos',
                                  fontSize: 30))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetailsBox extends StatelessWidget {
  final VoidCallback
      onClose; //voidcallback is a function that takes no parameters nor returns any

  const CardDetailsBox({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(255, 24, 79, 87)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Card Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          TextField(
            cursorColor: Color.fromARGB(255, 24, 79, 87),
            decoration: InputDecoration(
                labelText: "Card Number",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 71, 71, 71),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 24, 79, 87),
                ))),
            keyboardType: TextInputType.number,
          ),
          TextField(
            cursorColor: Color.fromARGB(255, 24, 79, 87),
            decoration: InputDecoration(
                labelText: "Expiry Date (MM/YY)",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 71, 71, 71),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 24, 79, 87),
                ))),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            cursorColor: Color.fromARGB(255, 24, 79, 87),
            decoration: InputDecoration(
                labelText: "CVV",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 71, 71, 71),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 24, 79, 87),
                ))),
            keyboardType: TextInputType.number,
            obscureText: true,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onClose,
            child: Text("Enter", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 24, 79, 87),
            ),
          ),
        ],
      ),
    );
  }
}
