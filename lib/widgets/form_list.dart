import 'package:custom_questionnaire/api_calls/q_meta_data.dart';
import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/widgets/form_tile.dart';
import 'package:flutter/material.dart';

class FormList extends StatefulWidget {
   const FormList({Key? key}) : super(key: key);

  @override
  _FormListState createState() => _FormListState();
}


class _FormListState extends State<FormList> {


Future getDateAndQuestions() async {

}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: getQuestionnaire.formListLength,
        itemBuilder: ( BuildContext context , int index){
        return FormTile(name: getQuestionnaire.forms[index] , date: getQuestionnaire.formUpdateDate[index], noOfQuestions:  getQuestionnaire.formNoQuestions[index], questionnairePosition: getQuestionnaire.formPosition[index],);
        });
  }
}
