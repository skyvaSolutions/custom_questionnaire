import 'package:custom_questionnaire/model/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../main.dart';
import 'form_field.dart';


class QListView extends StatefulWidget {
  final List<QuestionModel> list;
  const QListView({Key? key , required this.list}) : super(key: key);

  @override
  _QListViewState createState() => _QListViewState();
}

Widget Header(List<QuestionModel> list , BuildContext buildContext){
  for(var q in list){
    if(q.QuestionType.toLowerCase() == "Header"){
      return Container(
            width: MediaQuery.of(buildContext).size.width,
            padding: const EdgeInsets.all(10.0),
            color: teal.withOpacity(0.2),
            child: Text(
              q.Question,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300
              ),
            ),
        );
    }
  }
  return Container();
}

class _QListViewState extends State<QListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
        itemBuilder: (BuildContext context , int index){
          return Container(
            margin: const EdgeInsets.all(10.0),
            child: FormBuilder(
                child: Column(
                  children: [
                    Header(widget.list , context),
                    CustomFormField(
                      title: widget.list[index].QuestionID,
                      labelText: widget.list[index].Question,
                      type: widget.list[index].QuestionType,
                      multipleChoices: widget.list[index].ValidAnswers,
                      radioChoices: widget.list[index].ValidAnswers,
                      sliderChoices: widget.list[index].ValidAnswers,
                      chipChoices: widget.list[index].ValidAnswers,
                      dropDownChoices: widget.list[index].ValidAnswers,
                      isOptional: widget.list[index].IsOptional,
                    ),
                  ],
                ),
            ),
          );
        });
  }
}
