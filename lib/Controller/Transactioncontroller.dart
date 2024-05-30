// transaction_controller.dart
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var transactions = <Map<String, String>>[].obs;
  var totalExpense = 0.0.obs;

  void addTransaction(String amount) {
    double parsedAmount = double.tryParse(amount) ?? 0.0;
    transactions.add({'amount': amount, 'date': DateTime.now().toString()});
    totalExpense.value += parsedAmount;
  }
}
