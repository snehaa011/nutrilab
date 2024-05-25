// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './menuitem.dart';

final Stream<QuerySnapshot> menuitems =
    FirebaseFirestore.instance.collection('menuitems').snapshots();

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: menuitems,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text('ERROR'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 24, 79, 87),
            ),
          );
        }
        final data = snapshot.requireData;
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, 
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            ),
            itemCount: data.size,
            itemBuilder: (
              context,
              index,
            ) {
              return MenuItemWidget(
                name: data.docs[index]['Name'],
                des: data.docs[index]['Description'],
                img: data.docs[index]['Image'],
                ingr: data.docs[index]['Ingr'],
                type: data.docs[index]['Type'],
                cal: data.docs[index]['Calories'],
                price: data.docs[index]['Price'],
                itemId: data.docs[index].id,
              );
            });
      },
    );
  }
}
