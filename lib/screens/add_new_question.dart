import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

String type = 'Type A';
bool required = false;

class _AddQuestionState extends State<AddQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'New Question',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              cursorColor: teal,
              decoration: InputDecoration(
                hintText: 'Question Text',
                filled: true,
                fillColor: teal.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              style: const TextStyle(
                fontSize: 17.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: teal.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Question Type' ,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: teal,
                    ),
                    items: <String>['Type A', 'Type B', 'Type C', 'Type D']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: type,
                    onChanged: (String? val) {
                      setState(() {
                        type = val!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              cursorColor: teal,
              maxLines: 10,
              decoration: InputDecoration(
                filled: true,
                fillColor: teal.withOpacity(0.1),
                hintText: 'Valid Answers',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              style: const TextStyle(
                fontSize: 17.0,
              ),
            ),
            SwitchListTile(
              title: const Text('Required'),
              value: required,
              onChanged: (bool value) {
                setState(() {
                  required = value;
                });
              },
              activeColor: teal,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){},
                    child: Text(
                      'Clear' ,
                      style: TextStyle(
                        color: teal,
                      ),
                    ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: const Text('Submit'),
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(teal),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
