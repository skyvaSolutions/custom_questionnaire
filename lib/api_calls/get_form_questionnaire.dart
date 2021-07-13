import 'dart:convert';

import 'package:custom_questionnaire/model/forms.dart';
import 'package:custom_questionnaire/utils/device_id.dart';
import 'package:http/http.dart' as http;


GetMyReservations getMyReservations = new GetMyReservations();

class GetMyReservations{
  List<FormModel> questionnaire = [] ;
  int qListLength = 0;




  Future<void> findReservations() async {
    if(deviceID.deviceId != ""){
      print("getFormQuestionnaire api called");
      String url = "https://shoeboxtx.veloxe.com:36251/api/getFormQuestionnaire?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QuestionnaireID=test123";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('getFormQuestionnaire : Success');
        List<dynamic> myQList = json.decode(response.body);
        print(myQList.length);
        if(myQList.isEmpty){
          qListLength = 0;
          print('No Questions');
        }
        else{
          qListLength = myQList.length;
          myQList.forEach((element) =>
              questionnaire.add(FormModel.fromJson(element))
          );
          print(qListLength);
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
