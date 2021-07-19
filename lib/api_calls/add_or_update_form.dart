import 'dart:convert';
import 'package:http/http.dart' as http;

AddUpdateForm addUpdateForm = new AddUpdateForm();

class AddUpdateForm{

  Future<void> addUpdateForm( Map<String , dynamic> formValues) async {
    print("AddOrUpdateQuestionnaire api called");
    final response = await http.post(
      Uri.parse("https://shoeboxtx.veloxe.com:36251/api/addOrUpdateFormQuestionnairePost"),
      headers: <String, String>{
        "content-type" : "application/json",
        "accept" : "application/json",
      },
      body: jsonEncode(formValues),
    );
    if (response.statusCode == 200) {
      print('AddOrUpdateQuestionnaire : Success');
    } else {
      print('AddOrUpdateQuestionnaire : Error');
      print(response.statusCode);
    }
  }


}

