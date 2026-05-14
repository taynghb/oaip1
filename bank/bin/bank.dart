import 'package:bank/bank_system.dart';

void main(List<String> arguments) {
  final db = BankDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}
