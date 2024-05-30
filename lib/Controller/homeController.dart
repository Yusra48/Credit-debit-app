import 'package:get/get.dart';

class HomeController extends GetxController {
  var transactions = <Map<String, String>>[
    {'title': 'Stripe Payment', 'amount': '+2,085.60', 'date': '06 May 2024'},
    {'title': 'PayPal Payment', 'amount': '+800.32', 'date': '10 May 2024'},
    {'title': 'JazzCash', 'amount': '-85.60', 'date': '12 May 2024'},
  ].obs;

  void addTransaction(String title, String amount, String date) {
    transactions.add({'title': title, 'amount': amount, 'date': date});
    update();
  }
}
