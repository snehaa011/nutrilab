// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrilab/deco.dart';
import 'package:nutrilab/profile.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String mobile;
  final String email;
  final String state;
  final String city;
  final String zip;

  const EditProfilePage({
    required this.name,
    required this.mobile,
    required this.email,
    required this.state,
    required this.city,
    required this.zip,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _name, _mobile, _state, _city, _zip;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.name);
    _mobile = TextEditingController(text: widget.mobile);
    _state = TextEditingController(text: widget.state);
    _city = TextEditingController(text: widget.city);
    _zip = TextEditingController(text: widget.zip);
  }

  Widget createBox(TextEditingController _text, String label,
      double screenWidth, double screenHeight) {
    final double baseFontSize = screenWidth * 0.05;
    final double mediumFontSize = baseFontSize * 0.7;

    return TextFormField(
      cursorColor: Color.fromARGB(255, 37, 37, 37),
      controller: _text,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Gayathri',
        fontWeight: FontWeight.w700,
        fontSize: mediumFontSize,
      ),
      decoration: myDecorationField.copyWith(
        hintText: "",
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.08 * 0.2, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 37, 37, 37),
            width: 1.25,
          ),
        ),
      ),
    );
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
              "Edit Details",
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
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name",
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 116, 78)))),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0,
                      screenWidth * 0.005, screenHeight * 0.01),
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.1,
                  child: createBox(_name, "Name", screenWidth, screenHeight),
                ),
                // SizedBox(
                //   height: screenHeight * 0.0001,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Mobile",
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 116, 78)))),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0,
                      screenWidth * 0.005, screenHeight * 0.01),
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.1,
                  child:
                      createBox(_mobile, "Mobile", screenWidth, screenHeight),
                ),
              
                SizedBox(
                  height: screenHeight * 0.000001,
                ),
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
                          width: screenWidth * 0.45,
                          height: screenHeight * 0.07,
                          margin: EdgeInsets.fromLTRB(screenWidth * 0.025, 0,
                              screenWidth * 0.005, screenHeight * 0.01),
                          child: createBox(
                              _state, "State", screenWidth, screenHeight),
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
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.07,
                          margin: EdgeInsets.fromLTRB(screenWidth * 0.025, 0,
                              screenWidth * 0.005, screenHeight * 0.01),
                          child: createBox(
                              _city, "City", screenWidth, screenHeight),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   height:screenHeight * 0.0001,
                // ),
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
                Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0,
                      screenWidth * 0.005, screenHeight * 0.01),
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.07,
                  child: createBox(_zip, "ZIP Code", screenWidth, screenHeight),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Navigate to edit profile page
                      final updatedData = {
                        'name': _name.text,
                        'mobile': (_mobile.text.isNotEmpty)
                            ? int.parse(_mobile.text)
                            : null,
                        'address': {
                          'state': _state.text,
                          'city': _city.text,
                          'zip': (_zip.text.isNotEmpty)
                              ? int.tryParse(_zip.text)
                              : null,
                        },
                      };
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget
                                .email) // Assuming widget.email is used as the document ID
                            .update(updatedData);
                        context.findAncestorStateOfType<GoToProfileState>()?.rebuild();
                        Navigator.pop(context);
                      } catch (e) {
                        print("Failed to update user: $e");
                      }
                    },
                    child: Text("Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Genos'
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 24, 79, 87),
                    ),
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
