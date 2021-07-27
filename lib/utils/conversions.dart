
Conversions conversions = Conversions();
class Conversions{
  DateTime? convertStringToDate(String? date) {
    if(date != "") {
      return DateTime.parse(date!);
    } else {
      return null;
    }
  }

}
