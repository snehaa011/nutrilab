import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // Align to the top center of the screen
      child: AlertDialog(
        // title: Text('Error'),
        content: Text(message),

        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Text('OK'),
        //   ),
        // ],
      ),
    );
  }
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ErrorDialog(message: errorMessage);
    },
  );
}