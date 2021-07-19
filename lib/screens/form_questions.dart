import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/screens/add_new_question.dart';
import 'package:custom_questionnaire/widgets/reordable_qlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class QuestionsList extends StatefulWidget {
  final String title;
  const QuestionsList({Key? key, required this.title}) : super(key: key);

  @override
  _QuestionsListState createState() => _QuestionsListState();
}

Future getQuestions(String id) async {
  await getFormQuestions.findQuestions(id);
}

class _QuestionsListState extends State<QuestionsList> {
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
      body: QuestionWidget(widget.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext) => AddQuestion()));
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

Widget QuestionWidget(String id) {
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
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const ReorderableQuestionList();
        } else {
          print('else');
          return Container();
        }
      });
}
