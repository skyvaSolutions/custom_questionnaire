import 'dart:convert';
import 'package:custom_questionnaire/api_calls/q_meta_data.dart';
import 'package:custom_questionnaire/api_calls/q_meta_data_post.dart';
import 'package:http/http.dart' as http;

import 'get_form_questions.dart';


DeleteForm deleteForm = DeleteForm();

class DeleteForm{




  Future<void> deleteForm(String id) async {
    print("Delete Form api called");
    String url = "https://shoeboxtx.veloxe.com:36251/api/deleteFormQuestionnaire?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QuestionnaireID=$id";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Delete Form : Success');
      Map<String , dynamic> newForm = {};
      getQuestionnaire.forms.remove(id);
      newForm['QID'] = '46181836-EC04-469E-8B2B-1E9F9565E5D0';
      newForm['AppointmentTypes'] = [
        {
          'QuestionnaireIDArray' : getQuestionnaire.forms,
        }
      ];
      await addFormToQueue.addNewFormToQueue(newForm);

    }
    else{
      print('Delete Form : Error');
    }


  }

}
