import 'package:custom_questionnaire/api_calls/add_or_update_form.dart';
import 'package:custom_questionnaire/model/question.dart';
import 'package:custom_questionnaire/screens/add_new_question.dart';

saveNewQuestion(widget) async {
  Map<String, dynamic> formValues = {};
  formValues['QuestionnaireID'] = widget.formName;
  formValues['QuestionnairePosition'] = widget.formPosition;
  formValues['NumberOfQuestions'] = widget.list.length + 1;
  List<Map<String , dynamic>> listToBeSent = [];
  List<QuestionModel> _list = widget.list;

  for(var q in _list){
    listToBeSent.add(toMap(q));
  }

  List<String> validAnsList = [];
  if(validAns.text != ""){
    validAnsList = validAns.text.split('\n');
  }
  QuestionModel newQues = QuestionModel(validAnsList, uuid.v4(), questionText.text, _list.length, type, required, "QID" + _list.length.toString());
  Map<String , dynamic> newQuesMap = toMap(newQues);
  listToBeSent.add(newQuesMap);
  formValues['QuestionsArray'] = listToBeSent;
  print(formValues);
  await addUpdateForm.addUpdateForm(formValues);
  questionText.text = "";
  validAns.text = "";
  type = 'Yes/No';
  required = false;
  showSave = false;
  widget.refresh!();
}


updateOldQuestion(widget) async {
  Map<String, dynamic> formValues = {};
  formValues['QuestionnaireID'] = widget.formName;
  formValues['QuestionnairePosition'] = widget.formPosition;
  formValues['NumberOfQuestions'] = widget.list.length ;
  List<Map<String , dynamic>> listToBeSent = [];
  List<QuestionModel> _list = widget.list;

  for(var q in _list){
    if(q.QuestionID == widget.qId) {
      q.Question = questionText.text;
      List<String> validAnsList = [];
      if(validAns.text != ""){
        validAnsList = validAns.text.split('\n');
      }
      q.ValidAnswers = validAnsList;
      q.IsOptional = required;
    }
    listToBeSent.add(toMap(q));
  }

  formValues['QuestionsArray'] = listToBeSent;
  print(formValues);
  await addUpdateForm.addUpdateForm(formValues);
  questionText.text = "";
  validAns.text = "";
  type = 'Yes/No';
  required = false;
  showSave = false;
  widget.refresh!();
}