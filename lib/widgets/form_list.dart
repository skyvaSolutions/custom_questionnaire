import 'package:custom_questionnaire/api_calls/q_meta_data.dart';
import 'package:custom_questionnaire/main.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/utils/conversions.dart';
import 'package:custom_questionnaire/widgets/form_tile.dart';
import 'package:flutter/material.dart';

class FormList extends StatefulWidget {
    final Function() refreshParent;
    final Map<String , List<QuestionModel>> formMap;
   const FormList({Key? key , required this.refreshParent , required this.formMap}) : super(key: key);

  @override
  _FormListState createState() => _FormListState();
}


class _FormListState extends State<FormList> {




  @override
  Widget build(BuildContext context) {
    // if(widget.formMap.isEmpty) {
    //   return Container();
    // }
    // else if(widget.formMap.isNotEmpty) {
      return ListView.builder(
      itemCount: getQuestionnaire.formListLength,
        itemBuilder: ( BuildContext context , int index){
        return FormTile(name: getQuestionnaire.forms[index] , date: conversions.convertStringToDate(getQuestionnaire.formUpdateDate[index]), noOfQuestions:  getQuestionnaire.formNoQuestions[index], questionnairePosition: getQuestionnaire.formPosition[index],refreshGrandParent: widget.refreshParent,);
        });
    // }
    // else {
    //   return Container();
    // }
  }
}
