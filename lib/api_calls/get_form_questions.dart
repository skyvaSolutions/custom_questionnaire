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



  Future<void> findQuestions(String id) async {
    questionnaire = [];
    qListLength = 0;
    if(deviceID.deviceId != ""){
      print("getFormQuestionnaire api called");
      String url = "https://shoeboxtx.veloxe.com:36251/api/getFormQuestionnaire?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QuestionnaireID=$id";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('getFormQuestionnaire : Success');
        List<dynamic> myFormList = json.decode(response.body);
        print(myFormList);
        if(myFormList.isEmpty){
         print('empty');
        }
        else{
          var formModel = FormModel.fromJson(myFormList[0]);
          print(formModel.UpdatedTimeStamp);
          if(formModel.UpdatedTimeStamp != "") {
            date = formModel.UpdatedTimeStamp;
          }
          print(myFormList[0]['QuestionsArray']);
          if(myFormList[0]['QuestionsArray'] == null){
            qListLength = 0;
          }
          else {
            qListLength = myFormList[0]['QuestionsArray'].length;
          }
          print(qListLength);
          noOfQuestions = qListLength;
          print(formModel.QuestionnairePosition);
          if(formModel.QuestionnairePosition != "") {
            position = formModel.QuestionnairePosition;
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


  }

}
