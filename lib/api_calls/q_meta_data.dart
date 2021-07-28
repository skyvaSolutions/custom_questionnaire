import 'dart:convert';
import 'package:http/http.dart' as http;

import 'get_form_questions.dart';


GetQuestionnaire getQuestionnaire = GetQuestionnaire();

class GetQuestionnaire{
  List<dynamic> forms = [] ;
  int formListLength = 0;
  List<String> formUpdateDate = [];
  List<int>  formNoQuestions = [];
  List<String> formPosition = [];


  Future<void> findForms() async {
    formUpdateDate =[];
    formNoQuestions = [];
    formPosition = [];
    forms = [];
    formListLength = 0;
      print("getQMetaData api called");
      String url = "https://shoeboxtx.veloxe.com:36251/api/GetQMetadata?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QID=46181836-EC04-469E-8B2B-1E9F9565E5D0";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('getQMetaData : Success');
        Map<String , dynamic> qMetaData = json.decode(response.body);
        print(qMetaData);
        formListLength = qMetaData['AppointmentTypes'][0]['QuestionnaireIDArray'].length;
        forms = qMetaData['AppointmentTypes'][0]['QuestionnaireIDArray'];
        print(forms.length);
        int index = 0;
        for(var form in forms){
          await getFormQuestions.findQuestions(form);
          formUpdateDate.add(getFormQuestions.date);
          formNoQuestions.add(getFormQuestions.noOfQuestions);
          formPosition.add(getFormQuestions.position);
        }
        print(forms);
        print(formPosition);
        print(formNoQuestions);
        print(formUpdateDate);
      }
      else{
        print('getQMetaData : Error');
      }


  }

}
