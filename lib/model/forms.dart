import 'package:custom_questionnaire/model/question.dart';

class FormModel{
  String QuestionnaireID;
  String NumberOfQuestions;
  String QuestionnairePosition;
  List<QuestionModel> QuestionsArray;
  String UpdatedTimeStamp;

  FormModel(this.QuestionnaireID, this.NumberOfQuestions, this.QuestionnairePosition,
      this.QuestionsArray, this.UpdatedTimeStamp);

  factory FormModel.fromMap(Map json) {
    return FormModel(json['QuestionnaireID'], json['NumberOfQuestions'], json['QuestionnairePosition'], json['QuestionsArray'] , json['UpdatedTimeStamp']);

  }
  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(json['QuestionnaireID'], json['NumberOfQuestions'], json['QuestionnairePosition'], json['QuestionsArray'] , json['UpdatedTimeStamp']);
  }

}