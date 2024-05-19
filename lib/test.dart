// Container(
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(106, 218, 217, 217),
//                       ),
//                       width: double.infinity,
//                       padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                       child: Stack(
//                         children: [
//                           Text(
//                             widget.name.toUpperCase(),
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontFamily: 'Lalezar',
//                               foreground: Paint()
//                                 ..style = PaintingStyle.stroke
//                                 ..strokeWidth = 1.5
//                                 ..color = Color.fromARGB(255, 153, 222, 233),
//                             ),
//                           ),
//                           Text(
//                             widget.name.toUpperCase(),
//                             style: TextStyle(
//                               fontFamily: 'Lalezar',
//                               color: Color.fromARGB(255, 24, 79, 87),
//                               fontSize: 30,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),


// Container(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           alignment: Alignment.center,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: height,
//                                 width: buttonWidth,
//                                 child: ElevatedButton(
//                                   onPressed:
//                                       (quantity > 0) ? _removeFromCart : null,
//                                   child: Icon(
//                                     Icons.remove,
//                                     color: Color.fromARGB(255, 24, 79, 87),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     side: BorderSide(color: Color.fromARGB(255, 24, 79, 87),),
//                                     backgroundColor:
//                                         Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         bottomLeft: Radius.circular(10),
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.zero,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:MediaQuery.of(context).size.width * 0.005 ,
//                               ),
//                               Container(
//                                 height: height,
//                                 width: containerWidth,
//                                 color: Color.fromARGB(255, 24, 79, 87),
//                                 alignment: Alignment.center,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 5),
//                                       child: Text(
//                                         "Quantity: ",
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: 'Gayathri',
//                                           color:
//                                               Color.fromARGB(255, 225, 226, 209),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       width: 30,
//                                       height:40,
//                                       padding: EdgeInsets.all(5),
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           quantity.toString(),
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: 'Gayathri',
//                                             color:
//                                                 Color.fromARGB(255, 24, 79, 87),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:MediaQuery.of(context).size.width * 0.005 ,
//                               ),
//                               Container(
//                                 height: height,
//                                 width: buttonWidth,
//                                 child: ElevatedButton(
//                                   onPressed: _addToCart,
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Color.fromARGB(255, 24, 79, 87),
//                                   ),

//                                   style: ElevatedButton.styleFrom(
//                                     side: BorderSide(color: Color.fromARGB(255, 24, 79, 87),),
//                                     backgroundColor:
//                                         Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10),
//                                         bottomRight: Radius.circular(10),
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.zero,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),