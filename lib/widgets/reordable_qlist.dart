import 'package:custom_questionnaire/api_calls/get_form_questions.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/screens/add_new_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ReorderableQuestionList extends StatefulWidget {
  const ReorderableQuestionList({Key? key}) : super(key: key);

  @override
  _ReorderableQuestionListState createState() =>
      _ReorderableQuestionListState();
}

List<QuestionModel> _list = getFormQuestions.questionnaire;

class _ReorderableQuestionListState extends State<ReorderableQuestionList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: _list
          .map(
            (item) => ListTile(
                key: Key(item.QuestionID),
                leading: Icon(Icons.reorder , color: teal,),
                title: Text("${item.Question}" ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                isThreeLine: true,
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${item.QuestionType}"),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.circle,
                      color: teal,
                      size: 7.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text("${item.validAnswers.length} valid answers"),
                    const SizedBox(
                      width: 5.0,
                    ),

                  ],
                ),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => const AddQuestion()));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: teal,
                  ),
                )),
          )
          .toList(),
      onReorder: (int start, int current) {
        // dragging from top to bottom
        if (start < current) {
          int end = current - 1;
          QuestionModel startItem = _list[start];
          int i = 0;
          int local = start;
          do {
            _list[local] = _list[++local];
            i++;
          } while (i < end - start);
          _list[end] = startItem;
        }
        // dragging from bottom to top
        else if (start > current) {
          QuestionModel startItem = _list[start];
          for (int i = start; i > current; i--) {
            _list[i] = _list[i - 1];
          }
          _list[current] = startItem;
        }
        setState(() {});
      },
    );
  }
}
