import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/widgets/form_list.dart';
import 'package:flutter/material.dart';



class AddOrViewForms extends StatefulWidget {
  const AddOrViewForms({Key? key}) : super(key: key);

  @override
  _AddOrViewFormsState createState() => _AddOrViewFormsState();
}


class _AddOrViewFormsState extends State<AddOrViewForms> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          height: MediaQuery.of(context).size.height*0.6,
            child: const FormList(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(onPressed: (){} , child: const Icon(Icons.add , color: Colors.white,) , backgroundColor: teal,),
            ],
          ),
        ),
      ],
    );
  }
}
