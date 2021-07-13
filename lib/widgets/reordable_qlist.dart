import 'package:custom_questionnaire/screens/add_new_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ReorderableQuestionList extends StatefulWidget {
  const ReorderableQuestionList({Key? key}) : super(key: key);

  @override
  _ReorderableQuestionListState createState() =>
      _ReorderableQuestionListState();
}

List<String> _list = [
  "Question 1",
  "Question 2",
  "Question 3",
  "Question 4",
  "Question 5"
];

class _ReorderableQuestionListState extends State<ReorderableQuestionList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: _list
          .map(
            (item) => ListTile(
                key: Key(item),
                leading: Icon(Icons.reorder , color: teal,),
                title: Text("$item" ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Type A'),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.circle,
                      size: 7.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('5 valid answers'),

                  ],
                ),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => AddQuestion()));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: teal,
                  ),
                )),
          )
          .toList(),
      onReorder: (int start, int current) {
        // dragging from top to bottom
        if (start < current) {
          int end = current - 1;
          String startItem = _list[start];
          int i = 0;
          int local = start;
          do {
            _list[local] = _list[++local];
            i++;
          } while (i < end - start);
          _list[end] = startItem;
        }
        // dragging from bottom to top
        else if (start > current) {
          String startItem = _list[start];
          for (int i = start; i > current; i--) {
            _list[i] = _list[i - 1];
          }
          _list[current] = startItem;
        }
        setState(() {});
      },
    );
  }
}
