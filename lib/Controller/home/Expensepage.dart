import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/Transactioncontroller.dart';
import 'package:get/get.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController());

    return Scaffold(
      backgroundColor: Color(0xFF527A8D),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBarChartCard(),
            SizedBox(height: 16.0),
            Obx(() => _buildExpenseCard(
                context, transactionController.totalExpense.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartCard() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 350,
      width: 600,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar(Colors.black, 'Jan', height: 250, width: 20),
                  _buildBar(Colors.black, 'Feb', height: 220, width: 20),
                  _buildBar(Colors.black, 'Mar', height: 200, width: 20),
                  _buildBar(Colors.black, 'Apr', height: 180, width: 20),
                  _buildBar(Colors.black, 'May', height: 230, width: 20),
                  _buildBar(Colors.black, 'Jun', height: 250, width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(Color color, String label,
      {required double height, required double width}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: width,
          height: height,
          color: color.withOpacity(0.8),
        ),
        SizedBox(height: 4.0),
        Text(label),
      ],
    );
  }

  Widget _buildExpenseCard(BuildContext context, double totalExpense) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.money, color: Colors.grey),
              SizedBox(width: 8.0),
              Text(
                'Expense',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.filter_list, color: Colors.grey),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            '\$${totalExpense.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF527A8D),
              child: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                _showAddTransactionSheet(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAddTransactionSheet(BuildContext context) {
    final TransactionController transactionController =
        Get.find<TransactionController>();
    final amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final amount = amountController.text;
                  if (amount.isNotEmpty) {
                    transactionController.addTransaction(amount);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}
