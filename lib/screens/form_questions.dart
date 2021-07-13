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


class _QuestionsListState extends State<QuestionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: const ReorderableQuestionList(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => AddQuestion()));
                } ,
                  child: const Icon(Icons.add , color: Colors.white,) , backgroundColor: teal,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
