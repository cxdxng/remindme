import 'package:remindme/DatabaseHelper.dart';

class BackgroundWorker {
  List<String> getDataFromPerson(String nameFromPerson) {
    DatabaseHelper().getInfo();
    List<String> test = ["test", "test"];
    return test;
  }
}
