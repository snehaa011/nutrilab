import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './menuitem.dart';

class BuildSaved extends StatefulWidget {
  const BuildSaved({super.key});

  @override
  State<BuildSaved> createState() => BuildSavedState();
}

class BuildSavedState extends State<BuildSaved> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List liked = [];
  List<DocumentSnapshot> documents = [];
  @override
  void initState() {
    super.initState();
    _initializeLikedItems();
  }

  void rebuild(){
    if (mounted){
      setState(() {
        liked=[];
        documents=[];
      });
      _initializeLikedItems();
    }
  }
  Future<void> _initializeLikedItems() async {
    await _checkLiked();
    await fetchDocuments(liked);
    if (mounted) {
      setState(
          () {}); // Triggers a rebuild to update the UI with fetched documents
    }
  }

  Future<void> _checkLiked() async {
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
      if (mounted){
        setState(() {
        liked = userDoc['liked'] ?? [];
      });
      }
      
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> fetchDocuments(List<dynamic> docIds) async {
    for (String docId in docIds) {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('menuitems')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        if (mounted){
          setState(() {
          documents.add(docSnapshot);
        });
        }
      }
    }
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
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty || documents.isEmpty){
          return Center(
            child: Text(
              'No items saved.',
              style: TextStyle(
                fontFamily: 'Lalezar',
                color: Color.fromARGB(255, 83, 83, 83),
                fontSize: 25,
              ),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final doc = documents[index];
            final data = doc.data() as Map<String, dynamic>;

            return MenuItemWidget(
              name: data['Name'],
              des: data['Description'],
              img: data['Image'],
              ingr: data['Ingr'],
              type: data['Type'],
              cal: data['Calories'],
              price: data['Price'],
              itemId: doc.id,
            );
          },
        );
      },
    );
  }
}


