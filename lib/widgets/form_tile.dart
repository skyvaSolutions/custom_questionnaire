import 'package:custom_questionnaire/api_calls/delete_form.dart';
import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/screens/form_questions.dart';
import 'package:custom_questionnaire/utils/conversions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../main.dart';

class FormTile extends StatefulWidget {
  final String name;
  final DateTime? date;
  final int? noOfQuestions;
  final Function()? onTap;
  final String? questionnairePosition;
  final Function()? refreshGrandParent;
  const FormTile({Key? key, required this.name, this.onTap ,  this.date ,   this.noOfQuestions ,  this.questionnairePosition , this.refreshGrandParent}) : super(key: key);

  @override
  _FormTileState createState() => _FormTileState();
}

void edit(BuildContext context, String title , String? formPosition) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => QuestionsList(title: title , formPosition: formPosition,)));
}

String properFormat(DateTime? date){
  int year = date!.year;
  int month = date.month;
  int day = date.day;

  int hour = date.hour;
  int min = date.minute;

  String properDate = "";

  properDate = year.toString() + "-";
  if(month.toString().length < 2){
    properDate += "0" + month.toString() + "-";
  }
  else{
    properDate +=  month.toString() + "-";
  }
  if(day.toString().length < 2){
    properDate +=  "0" + day.toString();
  }
  else{
    properDate += day.toString();
  }

  if(hour.toString().length < 2){
    properDate += " at " +  "0" + hour.toString() + ":";
  }
  else{
    properDate +=" at " + hour.toString() + ":";
  }
  if(min.toString().length < 2){
    properDate +=  "0" + min.toString();
  }
  else{
    properDate += min.toString();
  }


  return properDate;
}

class _FormTileState extends State<FormTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              title: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  if(widget.date != null)
                  Text(
                    'Last Updated on - ${properFormat(widget.date)}',
                  ),
                  if(widget.date == null)
                    const Text(
                        'No Questions Added'
                    ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  if(widget.questionnairePosition != "")
                    Text(
                      'Position - ${widget.questionnairePosition}'
                    ),
                ],
              ),
              trailing: CircleAvatar(
                radius: 15,
                backgroundColor: teal,
                child: widget.noOfQuestions != null ?Text('${widget.noOfQuestions}') : const Text('0'),
                foregroundColor: Colors.white,
              ),
              onTap: () {
                edit(context, widget.name , widget.questionnairePosition);
              },
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: purple,
                icon: Icons.edit,
                onTap: () {
                  edit(context, widget.name , widget.questionnairePosition);
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
                onTap: ()  async {
                  await deleteForm.deleteForm(widget.name);
                  widget.refreshGrandParent!();
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: teal, width: 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
