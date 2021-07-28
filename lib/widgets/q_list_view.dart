import 'package:custom_questionnaire/model/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class QListView extends StatefulWidget {
  final List<QuestionModel> list;
  const QListView({Key? key , required this.list}) : super(key: key);

  @override
  _QListViewState createState() => _QListViewState();
}

class _QListViewState extends State<QListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
        itemBuilder: (BuildContext context , int index){
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$index. '),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.list[index].Question),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.list[index].QuestionType),
                        TextButton(
                          child:  Text('More>>' , style: TextStyle(color: teal),),
                          onPressed: (){

                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
