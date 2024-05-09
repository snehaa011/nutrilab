import 'package:flutter/material.dart';

class CreateAppBar extends StatefulWidget {
  final AnimatedContainer sidebutton;
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
                  )
                ],
                widget.sidebutton,
              ),]
              
            )),
      ),
    ],
    );
  }
}


