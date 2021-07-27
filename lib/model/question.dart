class QuestionModel{
  List<dynamic> ValidAnswers;
  String _id;
  String Question;
  int QuestionNumber;
  String QuestionType;
  bool IsOptional;
  String QuestionID;

  QuestionModel(this.ValidAnswers, this._id, this.Question, this.QuestionNumber,
      this.QuestionType, this.IsOptional, this.QuestionID);
  factory QuestionModel.fromMap(Map json) {
    return QuestionModel(json['ValidAnswers'], json['_id'], json['Question'], json['QuestionNumber'] , json['QuestionType'] , json['IsOptional'] , json['QuestionID']);

  }
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(json['ValidAnswers'], json['_id'], json['Question'], json['QuestionNumber'] , json['QuestionType'] , json['IsOptional'] , json['QuestionID']);
  }


}


Map<String, dynamic> toMap(QuestionModel questionModel) {
  return {
    'QuestionID' : questionModel.QuestionID,
    'QuestionNumber' : questionModel.QuestionNumber,
    'IsOptional' : questionModel.IsOptional,
    'Question' : questionModel.Question,
    'QuestionType' : questionModel.QuestionType,
    'ValidAnswers': questionModel.ValidAnswers
  };
}