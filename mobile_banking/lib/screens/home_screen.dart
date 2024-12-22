import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/send_money.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Good Morning, \nGega!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Image.asset(
                  'assets/multi_card.png',
                  width: 328,
                  height: 204,
                ), // Add your logo
              ),
              const SizedBox(height: 20),
              // Grid Menu Section
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  children: [
                    _buildMenuItem(Icons.account_balance_wallet,
                        'Account\nand Card', () {}),
                    _buildMenuItem(Icons.swap_horiz, 'Transfer', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SendMoneyPage(),
                        ),
                      );
                    }),
                    _buildMenuItem(Icons.attach_money, 'Withdraw', () {}),
                    _buildMenuItem(
                        Icons.phone_android, 'Mobile\nrecharge', () {}),
                    _buildMenuItem(Icons.receipt, 'Pay the bill', () {}),
                    _buildMenuItem(Icons.credit_card, 'Credit card', () {}),
                    _buildMenuItem(
                        Icons.insert_chart, 'Transaction\nreport', () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Menu Item Widget
  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
