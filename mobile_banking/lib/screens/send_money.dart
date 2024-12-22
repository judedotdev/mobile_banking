import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/home_screen.dart';

// Custom Reusable Button Widget
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// SendMoneyPage widget for the Send Money screen.
class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  String recipient = ''; // Store the recipient's details (name or number).
  double amount = 0.0; // Store the amount to send.
  String paymentMethod = ''; // Store the selected payment method.
  bool isFavorite = false; // Track if the transaction is marked as favorite.
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  // Function to confirm the transaction and navigate to confirmation page.
  void _confirmTransaction() {
    if (_formKey.currentState!.validate()) {
      // If all fields are filled, navigate to the confirmation page.
      if (recipient.isNotEmpty && amount > 0 && paymentMethod.isNotEmpty) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                TransactionConfirmationPage(
              recipient: recipient,
              amount: amount,
              paymentMethod: paymentMethod,
              isFavorite: isFavorite, // Pass the favorite status.
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      }
    } else {
      // Show an error if any field is empty.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the main content.
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              // Recipient input field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recipient'),
                onChanged: (value) {
                  setState(() {
                    recipient = value;
                  }); // Update recipient value when text changes.
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Recipient name must not be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Spacer between input fields.

              // Amount input field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Amount must be a positive number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Spacer between input fields.

              // Payment method dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Method'),
                value: paymentMethod.isEmpty ? null : paymentMethod,
                items: const [
                  // Dropdown items for selecting payment method.
                  DropdownMenuItem(
                    value: 'Bank Account',
                    child: Text('Bank Account'),
                  ),
                  DropdownMenuItem(
                    value: 'Mobile Wallet',
                    child: Text('Mobile Wallet'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Payment Method is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Spacer between input fields.

              // Switch for marking as favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mark as Favorite'),
                  Switch(
                    value: isFavorite,
                    onChanged: (value) {
                      setState(() {
                        isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Custom Button (Proceed button to confirm transaction)
              CustomButton(
                label: 'Proceed to Confirm',
                onPressed:
                    _confirmTransaction, // Trigger confirmation when pressed.
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TransactionConfirmationPage with animated success message
class TransactionConfirmationPage extends StatefulWidget {
  final String recipient;
  final double amount;
  final String paymentMethod;
  final bool isFavorite;

  const TransactionConfirmationPage({
    super.key,
    required this.recipient,
    required this.amount,
    required this.paymentMethod,
    required this.isFavorite,
  });

  @override
  State<TransactionConfirmationPage> createState() =>
      _TransactionConfirmationPageState();
}

class _TransactionConfirmationPageState
    extends State<TransactionConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Recipient: ${widget.recipient}'),
            Text('Amount: \$${widget.amount.toStringAsFixed(2)}'),
            Text('Payment Method: ${widget.paymentMethod}'),
            Text('Favorite: ${widget.isFavorite ? "Yes" : "No"}'),
            const SizedBox(height: 20),

            // Buttons
            CustomButton(
              label: 'Confirm and Send',
              color: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SuccessPage(
                      recipient: widget.recipient,
                      amount: widget.amount,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              label: 'Cancel',
              color: Colors.red,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// SuccessPage widget for displaying the success message
class SuccessPage extends StatelessWidget {
  final String recipient;
  final double amount;

  const SuccessPage({super.key, required this.recipient, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '\$${amount.toStringAsFixed(2)} has been sent to $recipient!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                label: 'Close',
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
