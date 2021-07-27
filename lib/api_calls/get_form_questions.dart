import 'dart:convert';
import 'package:custom_questionnaire/model/forms.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/utils/device_id.dart';
import 'package:http/http.dart' as http;


GetFormQuestions getFormQuestions = new GetFormQuestions();

class GetFormQuestions{
  List<QuestionModel> questionnaire = [] ;
  int qListLength = 0;
  String date = "";
  int noOfQuestions = 0;
  String position = "";



  Future<List<QuestionModel>> findQuestions(String id) async {
    questionnaire = [];
    qListLength = 0;
    if(deviceID.deviceId != ""){
      print("$id getFormQuestionnaire api called");
      String url = "https://shoeboxtx.veloxe.com:36251/api/getFormQuestionnaire?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QuestionnaireID=$id";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('getFormQuestionnaire : Success');
        List<dynamic> myFormList = json.decode(response.body);
        print(myFormList);
        if(myFormList.isEmpty){
           print('empty');
           date = "";
           qListLength = 0;
           noOfQuestions = 0;
           position = "";
        }
        else{
          print("form list : $myFormList[0]");
          var formModel = myFormList[0];
          print(formModel);
          if(myFormList[0]['UpdatedTimeStamp'] != "") {
            date = myFormList[0]['UpdatedTimeStamp'];
          }
          print(myFormList[0]['QuestionsArray']);
          if(myFormList[0]['QuestionsArray'] == null){
            qListLength = 0;
          }
          else {
            qListLength = myFormList[0]['QuestionsArray'].length;
          }
          print('hii');
          print(qListLength);
          noOfQuestions = qListLength;
          if(formModel['QuestionnairePosition'] != "" && formModel['QuestionnairePosition'] != null ) {
            position = formModel['QuestionnairePosition'];
          }
          for(int i =0;i<qListLength ;i++){
            questionnaire.add(QuestionModel.fromJson(myFormList[0]['QuestionsArray'][i]));
          }
          print(questionnaire.length);
        }
      }
      else{
        print('getFormQuestionnaire : Error');
      }
    }
    else{
      print('device Id null');
    }
    return questionnaire;

  }

}
