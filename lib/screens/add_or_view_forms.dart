import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/api_calls/q_meta_data.dart';
import 'package:custom_questionnaire/api_calls/q_meta_data_post.dart';
import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/widgets/form_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class AddOrViewForms extends StatefulWidget {
  const AddOrViewForms({Key? key}) : super(key: key);

  @override
  _AddOrViewFormsState createState() => _AddOrViewFormsState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _positionController = TextEditingController();

Future getForms() async {
  await getQuestionnaire.findForms();

}

class _AddOrViewFormsState extends State<AddOrViewForms> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new Form'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Name of the form'),
                TextField(
                  cursorColor: teal,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: teal,
                      )
                    )
                  ),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Position of the form'),
                TextField(
                  cursorColor: teal,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: teal,
                          )
                      )
                  ),
                  controller: _positionController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(color: teal, fontSize: 17.0),
              ),
              onPressed: () async {
                if(_nameController.text != "" && _positionController.text != ""){
                  Map<String , dynamic> formValues = {};
                  formValues['QuestionnaireID'] = uuid.v4();
                  formValues['QuestionnairePosition'] = _positionController.text;
                  formValues['QuestionnaireName'] = _nameController.text;
                  formValues['NumberOfQuestions'] = 0;
                  formValues['QuestionsArray'] = [];
                  await addUpdateForm.addUpdateForm(formValues);
                  Map<String , dynamic> newForm = {};
                  getQuestionnaire.forms.add(_nameController.text);
                  newForm['QID'] = '46181836-EC04-469E-8B2B-1E9F9565E5D0';
                  newForm['AppointmentTypes'] = [
                    {
                      'QuestionnaireIDArray' : getQuestionnaire.forms,
                    }
                  ];
                  await addFormToQueue.addNewFormToQueue(newForm);
                  setState(() {

                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getForms(),
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null) {
        print('null');
        return Container();
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        print('loading');
        return Center(
          child: CircularProgressIndicator(
            color: teal,
          ),
        );
      } else if (snapshot.hasError) {
        print(snapshot.error);
        return Container();
      } else if (snapshot.connectionState == ConnectionState.done &&
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
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                height: MediaQuery.of(context).size.height * 0.6,
                child: const FormList(),
              ),
            ],
          ),
        );
      }
      else{
        print('else');
        return Container();
      }
    });
  }
}
