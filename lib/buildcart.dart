// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/bloc/menubloc/menu_bloc.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import 'package:nutrilab/cartitem.dart';
import 'package:nutrilab/checkout.dart';

class BuildCart extends StatefulWidget {
  const BuildCart({super.key});

  @override
  State<BuildCart> createState() => BuildCartState();
}

class BuildCartState extends State<BuildCart> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        final gstate = context.watch<GetItemsBloc>().state;
        final mstate = context.watch<MenuBloc>().state;
        if (gstate is GetItemsInitial){
          context.read<GetItemsBloc>().add(LoadItems(FirebaseAuth.instance.currentUser?.email ?? ""));
        }
        if (gstate is GetItemsLoading || mstate is MenuLoading){
          return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 24, 79, 87),
              ),
            );
        }
        if (gstate is GetItemsLoaded){
          context.read<MenuBloc>().add(LoadMenuItems(gstate.likedItems, gstate.cartItems));
        }
        if (gstate is GetItemsError || mstate is MenuError){
          return Center(child: Text("Error"));
        }
        if (mstate is MenuLoaded){
          if (mstate.cartItems.isEmpty){
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
          else{
            return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mstate.cartItems.length,
                itemBuilder: (context, index) {
                  final doc = mstate.cartItems[index];
                  return Column(children: [
                    SizedBox(height: 10),
                    CartItemWidget(
                      fm: doc,
                      name: doc.name,
                      des: doc.des,
                      img: doc.img,
                      ingr: doc.ingr,
                      type: doc.type,
                      cal: doc.cal,
                      price: doc.price,
                      itemId: doc.itemId,
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
                      'ITEMS         ${mstate.cartItems.length}',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        color: Color.fromARGB(255, 53, 53, 53),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'RS.${mstate.totalPrice}.00',
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
                      'RS. ${mstate.totalPrice+40}.00',
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
                          price: mstate.totalPrice,
                          items: mstate.cartItems.length,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 9),
                    backgroundColor: Color.fromARGB(255, 24, 79, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "CHECKOUT",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos',
                      color: Color.fromARGB(255, 225, 226, 209),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
          }
        }
        return Container();
      }
    );
  }
}
