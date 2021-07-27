import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/model/question.dart';
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
  const AddQuestion({Key? key , this.formName , this.refresh , this.formPosition , required this.list}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

String type = 'Yes/No';
bool required = false;

bool showSave = false;

var uuid = const Uuid();

TextEditingController questionText = TextEditingController();
TextEditingController validAns = TextEditingController();

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
                    return const ShowCancelAlertBox();
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
                  Map<String, dynamic> formValues = {};
                  formValues['QuestionnaireID'] = widget.formName;
                  formValues['QuestionnairePosition'] = widget.formPosition;
                  formValues['NumberOfQuestions'] = widget.list.length + 1;
                  List<Map<String , dynamic>> listToBeSent = [];
                  List<QuestionModel> _list = widget.list;

                  for(var q in _list){
                    listToBeSent.add(toMap(q));
                  }

                  List<String> validAnsList = [];
                  if(validAns.text != ""){
                    validAnsList = validAns.text.split('\n');
                  }
                  QuestionModel newQues = QuestionModel(validAnsList, uuid.v4(), questionText.text, _list.length, type, required, "QID" + _list.length.toString());
                  Map<String , dynamic> newQuesMap = toMap(newQues);
                  listToBeSent.add(newQuesMap);
                  formValues['QuestionsArray'] = listToBeSent;
                  print(formValues);
                  await addUpdateForm.addUpdateForm(formValues);
                  questionText.text = "";
                  validAns.text = "";
                  type = 'Yes/No';
                  required = false;
                  showSave = false;
                  Navigator.pop(context);
                  widget.refresh!();
                }
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
                borderRadius: BorderRadius.circular(30.0),
                color: teal.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Question Type',
                    style: TextStyle(
                      fontSize: 17.0,
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
                    items: <String>['Yes/No', 'Multiple Choice', 'Radio', 'Text' , 'Slider' , 'Drop Down' , 'Chip' , 'Switch' , 'Segment' , 'Comment(Multiline)' , 'Email' , 'Name' ,'Phone' , 'Image' , 'Pdf file' , 'Signature' , 'Header' , 'Statement']
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
            TextField(
              cursorColor: teal,
              maxLines: 10,
              controller: validAns,
              enabled: (type == "Header" || type == "Statement") ? false : true,
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
