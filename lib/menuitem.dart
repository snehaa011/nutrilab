import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/buildsaved.dart';
import 'package:nutrilab/menudetails.dart';
import 'package:nutrilab/models/menuitemmodel.dart';
import './snackbar.dart';

class MenuItemWidget extends StatelessWidget {
  MenuItemModel fm;
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;
  bool isLiked;
  bool isInCart;
  int qt;

  MenuItemWidget({
    required this.fm,
    required this.name,
    required this.des,
    required this.img,
    required this.ingr,
    required this.type,
    required this.cal,
    required this.price,
    required this.itemId,
    required this.isLiked,
    required this.isInCart,
    required this.qt,
  });
  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate width for each grid item (considering cross axis count of 2)
    double itemWidth =
        (screenWidth - 26) / 2; // 30 is for padding/margin adjustment
    double itemHeight = screenHeight * 0.35; // Adjust height as necessary

    return Container(
      height: itemHeight,
      width: itemWidth,
      margin: EdgeInsets.all(2), // Add margin for spacing between items
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
                cal: cal,
                des: des,
                img: img,
                ingr: ingr,
                itemId: itemId,
                name: name,
                price: price,
                type: type,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16/11, // Adjust as necessary
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      // alignment: Alignment.center,
                      child: Column(
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
                                      color: Color.fromARGB(255, 125, 172, 106),
                                      width: 1,
                                    ),
                                  ),
                                  // alignment: Alignment.topLeft,
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 24, 79, 87),
                                      fontSize: screenWidth *
                                          0.028, // Adjust font size based on screen width
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Rs. ${price}",
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Color.fromARGB(255, 24, 79, 87),
                                  fontSize: screenWidth *
                                      0.032, // Adjust font size based on screen width
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  // overflow: TextOverflow.ellipsis,
                                  name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Lalezar',
                                    color: Color.fromARGB(255, 24, 79, 87),
                                    fontSize: itemWidth *
                                        0.075, // Adjust font size based on screen width
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color.fromARGB(255, 125, 172, 106),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: BlocConsumer<GetItemsBloc, GetItemsState>(
                          listener: (context,state){
                            if (state is GetItemsLoaded){
                              showNotif(context, state.message);
                            }
                            if (state is GetItemsError){
                              showNotif(context, state.error);
                            }
                          },
                          builder: (context,state) {
                            if (state is GetItemsLoading){
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 24, 79, 87),
                                ),
                              );
                            }
                            return Icon(
                            fm.isLiked ? Icons.favorite : Icons.favorite_border,
                            color: const Color.fromARGB(255, 127, 189, 129),
                          );
                          }
                        ),
                        onPressed: (){
                          context.read<GetItemsBloc>().add(SavedButtonToggled(FirebaseAuth.instance.currentUser?.email ?? "", fm));
                        },
                      ),
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
