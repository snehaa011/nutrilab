// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nutrilab/loginpage.dart';
// import 'package:nutrilab/navbarwidget.dart';

// class Wrapper extends StatefulWidget {
//   const Wrapper({super.key});

//   @override
//   State<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError){
//             return Center(child: Text("Error"),);
//           } else {
//             if (snapshot.data == null){     //user not logged in
//               return GoToLoginPage();
//             }
//             else{
//               return BottomNav();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
