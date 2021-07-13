class QuestionModel{
  List<String> validAnswers;
  String _id;
  String Question;
  int QuestionNumber;
  String QuestionType;
  bool IsOptional;
  String QuestionID;

  QuestionModel(this.validAnswers, this._id, this.Question, this.QuestionNumber,
      this.QuestionType, this.IsOptional, this.QuestionID);
  factory QuestionModel.fromMap(Map json) {
    return QuestionModel(json['ValidAnswers'], json['_id'], json['Question'], json['QuestionNumber'] , json['QuestionType'] , json['IsOptional'] , json['QuestionID']);

  }
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(json['ValidAnswers'], json['_id'], json['Question'], json['QuestionNumber'] , json['QuestionType'] , json['IsOptional'] , json['QuestionID']);
  }

}