import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/screens/form_questions.dart';
import 'package:custom_questionnaire/utils/conversions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../main.dart';

class FormTile extends StatefulWidget {
  final String name;
  final String? date;
  final int? noOfQuestions;
  final Function()? onTap;
  final String? questionnairePosition;
  const FormTile({Key? key, required this.name, this.onTap ,  this.date ,  this.noOfQuestions ,  this.questionnairePosition}) : super(key: key);

  @override
  _FormTileState createState() => _FormTileState();
}

void edit(BuildContext context, String title) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => QuestionsList(title: title)));
}

class _FormTileState extends State<FormTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          actionPane: const SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                if(widget.date != "")
                Text(
                  'Last Updated on - ${widget.date}',
                ),
                const SizedBox(
                  height: 5.0,
                ),
                if(widget.questionnairePosition != "")
                Text(
                  'Position - ${widget.questionnairePosition}'
                )
              ],
            ),
            trailing: CircleAvatar(
              radius: 15,
              backgroundColor: teal,
              child: widget.noOfQuestions != null ?Text('${widget.noOfQuestions}') : const Text('0'),
              foregroundColor: Colors.white,
            ),
            onTap: () {
              edit(context, widget.name);
            },
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: purple,
              icon: Icons.edit,
              onTap: () {
                edit(context, widget.name);
              },
            ),
            IconSlideAction(
              foregroundColor: Colors.white,
              caption: 'View',
              color: teal,
              icon: Icons.remove_red_eye,
              onTap: () => {},
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => {},
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: teal, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
