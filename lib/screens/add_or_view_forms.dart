import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/api_calls/q_meta_data.dart';
import 'package:custom_questionnaire/api_calls/q_meta_data_post.dart';
import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/widgets/form_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AddOrViewForms extends StatefulWidget {
  const AddOrViewForms({Key? key}) : super(key: key);

  @override
  _AddOrViewFormsState createState() => _AddOrViewFormsState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _positionController = TextEditingController();

Future getForms() async {
  await getQuestionnaire.findForms();
  print(getQuestionnaire.forms);
  print(getQuestionnaire.formUpdateDate);
}

class _AddOrViewFormsState extends State<AddOrViewForms> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new Form'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Name of the form'),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  cursorColor: teal,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: teal,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Position of the form'),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  cursorColor: teal,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: teal,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _positionController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: teal, fontSize: 17.0),
                ),
                onPressed: () async {
                  _nameController.text = "";
                  _positionController.text = "";
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(color: teal, fontSize: 17.0),
              ),
              onPressed: () async {
                if (_nameController.text != "" &&
                    _positionController.text != "") {
                  Map<String, dynamic> formValues = {};
                  formValues['QuestionnaireID'] = _nameController.text;
                  formValues['QuestionnairePosition'] =
                      _positionController.text;
                  formValues['NumberOfQuestions'] = 0;
                  formValues['QuestionsArray'] = [];
                  print(formValues);
                  await addUpdateForm.addUpdateForm(formValues);

                  Map<String, dynamic> newForm = {};
                  getQuestionnaire.forms.add(_nameController.text);
                  newForm['QID'] = '46181836-EC04-469E-8B2B-1E9F9565E5D0';
                  newForm['AppointmentTypes'] = [
                    {
                      'QuestionnaireIDArray': getQuestionnaire.forms,
                    }
                  ];
                  await addFormToQueue.addNewFormToQueue(newForm);
                  setState(() {});
                  _nameController.text = "";
                  _positionController.text = "";
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  refreshParent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getForms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == false) {
            print('null');
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading');
            return Center(
              child: CircularProgressIndicator(
                color: teal,
              ),
            );
          }
          // else if (snapshot.hasError) {
          //   print(snapshot.error);
          //   return Container();
          // }
          else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData != null) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showMyDialog();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: teal,
              ),
              body: Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: FormList(
                  refreshParent: refreshParent,
                ),
              ),
            );
          } else {
            print('else');
            return Container();
          }
        });
  }
}
