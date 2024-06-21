import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/authbloc/auth_state.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/bloc/menubloc/menu_bloc.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import './menuitem.dart';

class BuildSaved extends StatelessWidget {
  BuildSaved({super.key});
  final user= FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return BlocListener<GetItemsBloc, GetItemsState>(listener: (context, state) {
      if (state is GetItemsInitial){
        context.read<GetItemsBloc>().add(LoadItems(user?.email ?? ""));
      }},
      child: BlocBuilder<MenuBloc, MenuState> (
          builder: (context, state) {
          if (state is MenuInitial){
            context.read<MenuBloc>().add(LoadMenuItems(likedItems, cartItems));
          }
        }
        ,) 
    );
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
  }
}



