import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/widgets/form_tile.dart';
import 'package:flutter/material.dart';

class FormList extends StatefulWidget {
   const FormList({Key? key}) : super(key: key);

  @override
  _FormListState createState() => _FormListState();
}


class _FormListState extends State<FormList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
         FormTile(
          name: 'Qualification Form',
        ),
         FormTile(
           name: 'Health Questionnaire',
         ),
         FormTile(
           name: 'How was your visit',
         ),
      ],
    );
  }
}
