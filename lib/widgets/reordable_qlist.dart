import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/screens/add_new_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ReorderableQuestionList extends StatefulWidget {
  final String? formName;
  final Function()? refresh;
  final String? formPosition;
  final List<QuestionModel> list;
  const ReorderableQuestionList({Key? key , this.formName , this.refresh , this.formPosition , required this.list}) : super(key: key);

  @override
  _ReorderableQuestionListState createState() =>
      _ReorderableQuestionListState();
}

//List<QuestionModel> _list = getFormQuestions.questionnaire;

class _ReorderableQuestionListState extends State<ReorderableQuestionList> {
  @override
  Widget build(BuildContext context) {
    print(widget.list);
    return ReorderableListView(
      children: widget.list
          .map(
            (item) => ListTile(
                key: Key(item.QuestionID),
                leading: Icon(Icons.reorder , color: teal,),
                title: Text(item.Question ,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                isThreeLine: true,
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.QuestionType),
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
                    Text("${item.ValidAnswers.length} valid answers"),
                    const SizedBox(
                      width: 5.0,
                    ),

                  ],
                ),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) =>  AddQuestion(formName: widget.formName, refresh: widget.refresh, formPosition: widget.formPosition, list: widget.list,)));
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
          QuestionModel startItem = widget.list[start];
          int i = 0;
          int local = start;
          do {
            widget.list[local] = widget.list[++local];
            i++;
          } while (i < end - start);
          widget.list[end] = startItem;
        }
        // dragging from bottom to top
        else if (start > current) {
          QuestionModel startItem = widget.list[start];
          for (int i = start; i > current; i--) {
            widget.list[i] = widget.list[i - 1];
          }
          widget.list[current] = startItem;
        }
        setState(() {});
        updateList(widget.list , widget.formName , widget.formPosition);
        widget.refresh!();
      },
    );
  }
}

updateList(List<QuestionModel> list , String? formName , String? formPosition) async {
  Map<String, dynamic> formValues = {};
  formValues['QuestionnaireID'] = formName;
  formValues['QuestionnairePosition'] = formPosition;
  formValues['NumberOfQuestions'] = list.length;
  List<Map<String , dynamic>> listToBeSent = [];

  for(var q in list){
    listToBeSent.add(toMap(q));
  }
  formValues['QuestionsArray'] = listToBeSent;
  print(formValues);
  await addUpdateForm.addUpdateForm(formValues);

}



