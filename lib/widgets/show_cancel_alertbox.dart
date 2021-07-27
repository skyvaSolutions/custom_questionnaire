
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ShowCancelAlertBox extends StatefulWidget {
  const ShowCancelAlertBox({Key? key}) : super(key: key);

  @override
  _ShowCancelAlertBoxState createState() => _ShowCancelAlertBoxState();
}

class _ShowCancelAlertBoxState extends State<ShowCancelAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 50.0,
              color: teal,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Changes will be lost',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Press back to return and save changes, Press Okay to Cancel Changes',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      titlePadding: const EdgeInsets.symmetric(
          horizontal: 10.0, vertical: 20.0),
      contentPadding: EdgeInsets.all(10.0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Okay' , style: TextStyle(color: Colors.grey[800]),),
        ),
        ElevatedButton(
          onPressed: ()  {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(teal),
          ),
        )
      ],
    );
  }
}
