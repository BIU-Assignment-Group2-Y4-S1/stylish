import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: ShoppingBagScreen(), debugShowCheckedModeBanner: false),
);

class ShoppingBagScreen extends StatefulWidget {
  @override
  _ShoppingBagScreenState createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  String selectedSize = '42';
  int selectedQty = 1;

  bool isFavorite = false;

  final List<String> sizes = ['38', '40', '42', '44'];
  final List<int> quantities = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Bag', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //PRODUCT ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/women.png',
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Women’s Casual Wear',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Checked Single-Breasted Blazer'),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: selectedSize,
                              items: sizes.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text("Size $size"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => selectedSize = value!);
                              },
                            ),
                            SizedBox(width: 12),
                            DropdownButton<int>(
                              value: selectedQty,
                              items: quantities.map((qty) {
                                return DropdownMenuItem(
                                  value: qty,
                                  child: Text("Qty $qty"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => selectedQty = value!);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Delivery by 10 May 2030",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Divider(),

              // COUPON
              Row(
                children: [
                  Icon(Icons.local_offer_outlined),
                  SizedBox(width: 8),
                  Text(
                    'Apply Coupons',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('Select', style: TextStyle(color: Colors.red)),
                ],
              ),
              SizedBox(height: 16),
              Divider(),

              //PAYMENT DETAILS
              Text(
                "Order Payment Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 16),
              _row("Order Amounts", "₹ 7,000.00", bold: true),
              _row(
                "Convenience",
                "Apply Coupon",
                leftNote: "Know More",
                leftNoteColor: Colors.red,
                rightColor: Colors.red,
              ),
              _row("Delivery Fee", "Free", rightColor: Colors.green),
              Divider(height: 30),
              _row("Order Total", "₹ 7,000.00", bold: true),
              Text("EMI Available", style: TextStyle(color: Colors.red)),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // BOTTOM BAR
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹ 7,000.00",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("View Details", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Proceed to Payment",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    String title,
    String value, {
    bool bold = false,
    String? leftNote,
    Color? leftNoteColor,
    Color? rightColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftNote == null
              ? Text(title)
              : Row(
                  children: [
                    Text(title),
                    SizedBox(width: 4),
                    Text(
                      leftNote,
                      style: TextStyle(
                        fontSize: 12,
                        color: leftNoteColor ?? Colors.black,
                      ),
                    ),
                  ],
                ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: rightColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
