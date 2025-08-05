import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedIndex = 0;
  String _selectedPaymentMethod = 'Visa';

  final List<Map<String, String>> _paymentMethods = [
    {'name': 'Visa', 'image': 'assets/images/visa.png'},
    {'name': 'PayPal', 'image': 'assets/images/paypal.png'},
    {'name': 'MasterCard', 'image': 'assets/images/maestro.png'},
    {'name': 'Apple Pay', 'image': 'assets/images/apple.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [_buildCheckout(), _buildPaymentOptions()]),
    );
  }

  Widget _buildCheckout() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 20),
      child: Column(
        children: [
          _buildPriceRow('Order', '7,000'),
          SizedBox(height: 12),
          _buildPriceRow('Shipping', '1,000'),
          SizedBox(height: 16),
          _buildPriceRow('Total', '8,000', isTotal: true),
          Divider(thickness: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isTotal ? Colors.black : Colors.grey[600],
            fontSize: 18,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isTotal ? Colors.black : Colors.grey[800],
            fontSize: 18,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: _paymentMethods.map((method) {
              bool isSelected = _selectedPaymentMethod == method['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = method['name']!;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.grey[200] : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? Color(0xFFF83758)
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        method['image']!,
                        height: 40,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 16),
                      Text(
                        method['name']!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      Spacer(),
                      if (isSelected)
                        Icon(Icons.check_circle, color: Color(0xFFF83758)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24),
          Align(alignment: Alignment.center, child: _paymentButton()),
        ],
      ),
    );
  }

  Widget _paymentButton() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF83758),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: TextButton(
          onPressed: () {
            _showSuccessDialog(context);
          },
          child: Text(
            'Payment',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/star.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.check, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ],
          ),
          content: Text(
            'Your payment was successful!',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
