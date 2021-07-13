import 'package:custom_questionnaire/screens/form_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../main.dart';

class FormTile extends StatefulWidget {
  final String name;
  final Function()? onTap;
  const FormTile({Key? key , required this.name , this.onTap}) : super(key: key);

  @override
  _FormTileState createState() => _FormTileState();
}

void edit(BuildContext context , String title){
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> QuestionsList(title: title)));
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
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('Last Updated on : dd/mm/yyyy'),
            trailing:  CircleAvatar(
              radius: 15,
              backgroundColor: teal,
              child: const Text('5'),
              foregroundColor: Colors.white,
            ),
            onTap: (){
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
              bottom: BorderSide(color: teal,width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
