import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/utils/save_functions.dart';
import 'package:custom_questionnaire/widgets/show_cancel_alertbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class AddQuestion extends StatefulWidget {
  final String? formName;
  final String? formPosition;
  final Function()? refresh;
  final List<QuestionModel> list;
  final bool updateOld;
  final String? qId;
  const AddQuestion({Key? key , this.formName , this.refresh , this.formPosition , required this.list , required this.updateOld , this.qId}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

String type = 'Yes/No';
bool required = false;

bool showSave = false;

var uuid = const Uuid();

Map<String , String> validHint = {
  'Multiple Choice' : 'Options for multiple Choice separated by new line' ,
  'Radio' :  'Options for Radio separated by new line',
  'Slider' : 'Min and max values separated by new line',
  'Drop Down' :  'Options for Drop Down separated by new line' ,
  'Chip' :  'Options for chip separated by new line',
};

List<String> questionTypes = [
  'Yes/No', 'Multiple Choice', 'Radio', 'Text' , 'Slider' , 'Drop Down' , 'Chip' , 'Switch' , 'Segment' , 'Comment(Multiline)' , 'Email' , 'Name' ,'Phone' , 'Image' , 'Pdf file' , 'Signature' , 'Header' , 'Statement'
];

List<String> noValidAns = [
  'Yes/No', 'Text' , 'Switch' , 'Segment' , 'Comment(Multiline)' , 'Email' , 'Name' , 'Phone' , 'Image' , 'Pdf file' , 'Header' , 'Statement'
];

TextEditingController questionText = TextEditingController();
TextEditingController validAns = TextEditingController();

reset(){
  questionText.text = "";
  validAns.text = "";
  type = 'Yes/No';
  required = false;
  showSave = false;
}

class _AddQuestionState extends State<AddQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (showSave) {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return const ShowCancelAlertBox(
                      reset: reset,
                    );
                  });
            }
            else {
              questionText.text = "";
              validAns.text = "";
              type = 'Yes/No';
              required = false;
              showSave = false;
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.close,
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
        actions: [
          if (showSave)
            IconButton(
              onPressed: () async {
                if(questionText.text != "" ){
                  if(widget.updateOld){
                    updateOldQuestion(widget);
                  }
                  else{
                    saveNewQuestion(widget);
                  }
                }

                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
        ],
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
              controller: questionText,
              decoration: InputDecoration(
                hintText: 'Question Text',
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: const TextStyle(
                fontSize: 15.0,
              ),
              onChanged: (String val) {
                setState(() {
                  showSave = true;
                });
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Question Type',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
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
                    items: questionTypes
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
                        showSave = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if(!noValidAns.contains(type))
            TextField(
              cursorColor: teal,
              maxLines: 10,
              controller: validAns,
              enabled: (noValidAns.contains(type)) ? false : true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                hintText: validHint[type],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: const TextStyle(
                fontSize: 15.0,
              ),
              onChanged: (String val) {
                setState(() {
                  showSave = true;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Required'),
              value: required,
              onChanged: (bool value) {
                setState(() {
                  showSave = true;
                  required = value;
                });
              },
              activeColor: teal,
            ),
          ],
        ),
      ),
    );
  }
}
