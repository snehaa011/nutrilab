// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CreateAppBar extends StatefulWidget {
  final bool sidebutton;
  const CreateAppBar({Key? key, required this.sidebutton }) : super(key: key);

  @override
  State<CreateAppBar> createState() => _CreateAppBarState();
}

class _CreateAppBarState extends State<CreateAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        color: Color.fromARGB(255, 79, 162, 177),
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              // backgroundColor: Color.fromARGB(255, 79, 162, 177),
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NUTRILAB',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Genos'),
                  ),
                  Text(
                    'Find the better you',
                    style: TextStyle(
                      color: Color.fromARGB(255, 180, 223, 182),
                      fontSize: 15,
                    ),
                  ),
                ],
                
              ),
              if (widget.sidebutton){
                    AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: _folded ? 40 : 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: kElevationToShadow[3],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: _folded
                            ? null
                            : TextField(
                                decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 35, 58, 33),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none),
                              ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 400,
                      ),
                      child: InkWell(
                        child: Icon(
                          Icons.search,
                          color: const Color.fromARGB(255, 63, 109, 64),
                        ),
                        onTap: () {
                          setState(() {
                            _folded = !_folded;
                          });
                        },
                      ),
                    ) as Widget
                  ],
                ),
              ),
            ) as Widget,
                }]
              
            )),
      ),
    ],
    );
  }
}


