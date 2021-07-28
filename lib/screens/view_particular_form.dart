import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/widgets/q_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ViewForm extends StatefulWidget {
  final String title;
  const ViewForm({Key? key , required this.title}) : super(key: key);

  @override
  _ViewFormState createState() => _ViewFormState();
}


List<QuestionModel> listOfQuestions = [];

Future getList(String title) async {
  listOfQuestions =  await getFormQuestions.findQuestions(title);

}

class _ViewFormState extends State<ViewForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title , style: const TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
        foregroundColor: teal,
      ),
      body: FutureBuilder(
          future: getList(widget.title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == false) {
              print('null');
              return Container();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print('loading');
              return Center(
                child: CircularProgressIndicator(
                  color: teal,
                ),
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Container();
            }
            else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData != null) {
              return  QListView(list: listOfQuestions,);
            } else {
              return Container();
            }
          }),
    );
  }
}
