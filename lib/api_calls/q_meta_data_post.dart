import 'dart:convert';
import 'package:http/http.dart' as http;

AddFormToQueue addFormToQueue = new AddFormToQueue();

class AddFormToQueue{

  Future<void> addNewFormToQueue( Map<String , dynamic> formValues) async {
    print("QMetaDataPost api called");
    final response = await http.post(
      Uri.parse("https://shoeboxtx.veloxe.com:36251/api/QMetadataPost"),
      headers: <String, String>{
        "content-type" : "application/json",
        "accept" : "application/json",
      },
      body: jsonEncode(formValues),
    );
    if (response.statusCode == 200) {
      print('QMetaDataPost : Success');
    } else {
      print('QMetaDataPost : Error');
      print(response.statusCode);
    }
  }



}

