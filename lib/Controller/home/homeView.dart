import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/home/Expensepage.dart';
import 'package:flutter_application_1/Controller/home/Mycards.dart';
import 'package:flutter_application_1/Controller/homeController.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  int _selectedIndex = 0;

  List<Map<String, String>> cards = [
    {'title': 'Balance', 'amount': '\$800.65', 'change': '+\$20.50'},
    {'title': 'Income', 'amount': '\$400.35', 'change': '-\$70.50'},
    {'title': 'Expense', 'amount': '\$950.05', 'change': '+\$50'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Get.to(() => const ExpenseView());
        break;
      case 2:
        Get.to(() => const MyCardsPage());
        break;
      case 3:
        _showAddTransactionDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF527A8D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade500,
          child: const Icon(
            Icons.auto_awesome,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade500,
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2021/06/14/15/19/kid-6336155_1280.jpg'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Alfanzo Corisano',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 9),
              Row(
                children: cards.take(2).map((card) {
                  return _buildCard(
                      card['title']!, card['amount']!, card['change']!);
                }).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ...cards.skip(2).map((card) {
                    return _buildCard(
                        card['title']!, card['amount']!, card['change']!);
                  }).toList(),
                  _buildAddWidgetCard(context),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Column(
                        children: controller.transactions.map((transaction) {
                          return _buildTransaction(
                            transaction['title']!,
                            transaction['amount']!,
                            transaction['date']!,
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1D1C1C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0
                      ? const Color(0xFF36738F)
                      : Colors.grey),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.bar_chart,
                  color: _selectedIndex == 1
                      ? const Color(0xFF36738F)
                      : Colors.grey),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.credit_card,
                  color: _selectedIndex == 2
                      ? const Color(0xFF36738F)
                      : Colors.grey),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.add,
                  color: _selectedIndex == 3
                      ? const Color(0xFF36738F)
                      : Colors.grey),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String amount, String change) {
    bool isPositiveChange = change.startsWith('+');
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            Text(amount,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 5),
            Text(
              change,
              style: TextStyle(
                color: isPositiveChange ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddWidgetCard(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _showAddWidgetDialog(context),
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.add, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildTransaction(String title, String amount, String date) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[700],
        child: Icon(_getIconForTitle(title), color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(date, style: const TextStyle(color: Colors.white70)),
      trailing: Text(amount, style: const TextStyle(color: Colors.white)),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Stripe Payment':
        return Icons.credit_card;
      case 'PayPal Payment':
        return Icons.paypal;
      case 'JazzCash':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }

  void _showAddTransactionDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Transaction',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Date'),
          ),
        ],
      ),
      textCancel: 'Cancel',
      textConfirm: 'Add',
      onCancel: () {},
      onConfirm: () {
        if (titleController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            dateController.text.isNotEmpty) {
          controller.addTransaction(
            titleController.text,
            amountController.text,
            dateController.text,
          );
          Get.back();
        }
      },
    );
  }

  void _showAddWidgetDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final changeController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Widget',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            controller: changeController,
            decoration: const InputDecoration(labelText: 'Change'),
          ),
        ],
      ),
      textCancel: 'Cancel',
      textConfirm: 'Add',
      onCancel: () {},
      onConfirm: () {
        if (titleController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            changeController.text.isNotEmpty) {
          final newCard = {
            'title': titleController.text,
            'amount': amountController.text,
            'change': changeController.text,
          };
          setState(() {
            cards.add(newCard);
          });
          Get.back();
        }
      },
    );
  }
}
