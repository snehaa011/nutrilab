import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/models/menuitemmodel.dart';
import './snackbar.dart';
import './menudetails.dart';

class CartItemWidget extends StatelessWidget {
  MenuItemModel fm;
  final String name;
  final String des;
  final String img;
  final String ingr;
  final String type;
  final int cal;
  final int price;
  final String itemId;

  CartItemWidget({
    super.key,
    required this.fm,
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
    BlocListener<GetItemsBloc, GetItemsState>(
      listener: (context, state) {
      if (state is GetItemsLoaded){
        showNotif(context, state.message);
      }
      if (state is GetItemsError){
        showNotif(context, state.error);
      }
    },);
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
                  cal: fm.cal,
                  des: fm.des,
                  img: fm.img,
                  ingr: fm.ingr,
                  itemId: fm.itemId,
                  name: fm.name,
                  price: fm.price,
                  type: fm.type,
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
                                fm.name.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Color.fromARGB(255, 24, 79, 87),
                                  fontSize: itemWidth *0.05, // Adjust font size based on screen width
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Rs. ${fm.price}",
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
                          TextButton(onPressed: (){context.read<GetItemsBloc>().add(SavedForLater(FirebaseAuth.instance.currentUser?.email ?? "", fm));}, child: Text("Save for Later",
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 138, 207),
                            fontSize: 14,
                          ),
                          )),
                          TextButton(onPressed: (){ context.read<GetItemsBloc>().add(AllItemOfTypeRemovedFromCart(FirebaseAuth.instance.currentUser?.email ?? "", fm));
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
                                        (fm.qt > 0) ? (){ context.read<GetItemsBloc>().add(ItemRemovedFromCart(FirebaseAuth.instance.currentUser?.email ?? "", fm));} : null,
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
                                    fm.qt.toString(),
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
                                    onPressed: (){ context.read<GetItemsBloc>().add(ItemAddedToCart(FirebaseAuth.instance.currentUser?.email ?? "", fm));},
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
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 24, 79, 87),
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
                          fm.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ],),
    ),);
  
}
}
