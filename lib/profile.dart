// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrilab/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/editprofile.dart';

class GoToProfile extends StatefulWidget {
  const GoToProfile({super.key});

  @override
  State<GoToProfile> createState() => GoToProfileState();
}

class GoToProfileState extends State<GoToProfile> {
  final _user = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';
  String mobile = '';
  Map<String, dynamic> address = {};
  String state = '';
  String city = '';
  String zip = '';
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
            if (address.containsKey('zip') && address['zip']!=null) {
              zip = address['zip'].toString();
            }
          }
        });
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Widget createBox(String text, double screenWidth, double screenHeight) {
    double horizontalPadding = screenWidth * 0.025;
    double verticalPadding = screenHeight * 0.01;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          horizontalPadding, 0, horizontalPadding, verticalPadding),
      child: Container(
        decoration: mydeco,
        width: screenWidth * 0.85,
        height: screenHeight * 0.08,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: (text.isNotEmpty)
            ? Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.08 * 0.15, horizontal: 15),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Profile",
                  style: TextStyle(
                      color: Color.fromARGB(255, 24, 79, 87),
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lalezar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to edit profile page
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          name: name,
                          mobile: mobile,
                          email:email,
                          state: state,
                          city: city,
                          zip: zip,
                        ),
                      ),
                    );
                    _getUser(); 
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: screenWidth * 0.015,
                      ),
                      Text("EDIT",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 24, 79, 87),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Name",
                      style:
                          TextStyle(color: Color.fromARGB(255, 77, 116, 78)))),
            ),
            createBox(name, screenWidth, screenHeight),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Mobile",
                      style:
                          TextStyle(color: Color.fromARGB(255, 77, 116, 78)))),
            ),
            createBox(mobile, screenWidth, screenHeight),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Address",
                      style: TextStyle(
                          color: Color.fromARGB(255, 77, 116, 78),
                          fontSize: 16,
                          fontWeight: FontWeight.w700))),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "State",
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 116, 78),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.025, 0,
                          screenWidth * 0.005, screenHeight * 0.01),
                      decoration: mydeco,
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.07,
                      child: (state.isNotEmpty)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.07 * 0.2,
                                  horizontal: 15),
                              child: Text(
                                state,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Gayathri',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "City",
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 116, 78),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0,
                          screenWidth * 0.005, screenHeight * 0.01),
                      decoration: mydeco,
                      width: screenWidth * 0.35,
                      height: screenHeight * 0.07,
                      child: (city.isNotEmpty)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.07 * 0.2,
                                  horizontal: 15),
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Gayathri',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ZIP Code",
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 116, 78),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.025, 0,
                      screenWidth * 0.005, screenHeight * 0.01),
                  child: Container(
                    decoration: mydeco,
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.07,
                    child: (zip.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.07 * 0.2,
                                horizontal: 15),
                            child: Text(
                              zip,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gayathri',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ElevatedButton(
                onPressed: () async {
                  await _user.signout(context);
                },
                child: Text(
                  "SIGNOUT",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.065,
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
      ),
    );
  }
}

final mydeco = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    color: Color.fromARGB(255, 80, 80, 80),
    width: 1,
  ),
  color: Colors.transparent,
);
