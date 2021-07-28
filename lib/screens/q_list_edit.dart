import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/screens/add_new_question.dart';
import 'package:custom_questionnaire/widgets/reordable_qlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class QuestionsListEdit extends StatefulWidget {
  final String title;
  final String? formPosition;
  const QuestionsListEdit({Key? key, required this.title , this.formPosition}) : super(key: key);

  @override
  _QuestionsListEditState createState() => _QuestionsListEditState();
}

List<QuestionModel> formQues = [];

Future getQuestions(String id) async {
  formQues = await getFormQuestions.findQuestions(id);
}



class _QuestionsListEditState extends State<QuestionsListEdit> {

  refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: QuestionWidget(widget.title , refresh , widget.formPosition),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext) => AddQuestion(formName: widget.title, refresh : refresh , list: formQues,)));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: teal,
      ),
    );
  }
}

Widget QuestionWidget(String id , Function() refresh , String? formPosition) {
  return FutureBuilder(
      future: getQuestions(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
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
        else if (snapshot.connectionState == ConnectionState.done) {
          return ReorderableQuestionList(formName: id , refresh : refresh , formPosition: formPosition, list: formQues ,);
        } else {
          print('else');
          return Container();
        }
      });
}
