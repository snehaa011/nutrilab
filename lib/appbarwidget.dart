// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppW extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> widgets;

  const AppW({Key? key, this.widgets = const []}) : super(key: key);

  @override
  State<AppW> createState() => _AppWState();

  @override
  Size get preferredSize => Size.fromHeight(85.0);
}

class _AppWState extends State<AppW> {
  bool _folded = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromARGB(255, 79, 162, 177),
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 79, 162, 177),
              title: Column(
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
              ),
              actions: widget.widgets,
            )),
      ),
    );
  }
}
// PreferredSizeWidget buildappbar(BuildContext context) {
//   bool _folded = true;
//   return PreferredSize(
//     preferredSize: Size.fromHeight(85.0),
//     child: Container(
//       color: Color.fromARGB(255, 79, 162, 177),
//       padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//       child: AppBar(
//         backgroundColor: Color.fromARGB(255, 79, 162, 177),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'NUTRILAB',
//               style: TextStyle(
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   fontSize: 30,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Genos'),
//             ),
//             Text(
//               'Find the better you',
//               style: TextStyle(
//                 color: Color.fromARGB(255, 180, 223, 182),
//                 fontSize: 15,
//               ),
//             )
//           ],
//         ),
//         actions: [
//           AnimatedContainer(
//             duration: Duration(milliseconds: 400),
//             width: _folded ? 40 : 150,
//             height: 40,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//               boxShadow: kElevationToShadow[6],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 16),
//                     child: _folded
//                         ? TextField(
//                             decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 border: InputBorder.none),
//                           )
//                         : null,
//                   ),
//                 ),
//                 AnimatedContainer(
//                   duration: Duration(
//                     milliseconds: 400,
//                   ),
//                   child: InkWell(
//                     child: Icon(
//                       Icons.search,
//                       color: const Color.fromARGB(255, 63, 109, 64),
//                     ),
//                     onTap: (){
//                       S
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )
//           // IconButton(
//           //   onPressed: () {},
//           //   icon: Icon(
//           //     Icons.search,
//           //     color: Colors.white,
//           //     size:30,
//           //   ),
//           // ),
//         ],
//       ),
//     ),
//   );
// }
