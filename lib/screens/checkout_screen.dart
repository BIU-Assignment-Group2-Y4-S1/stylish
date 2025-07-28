import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: CheckoutPage(), debugShowCheckedModeBanner: false),
);

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 8),
                Text(
                  'Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Address :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.edit, size: 16),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text("216 St Paul's Rd, London N1 2LL, UK"),
                        Text("Contact : +44-784232"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add, size: 24),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Shopping List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),

            // Product Card 1
            productCard(
              imagePath: 'assets/women.png',
              title: "Women’s Casual Wear",
              variations: ["Black", "Red"],
              rating: 4.8,
              price: 34.00,
              oldPrice: 64.00,
              discount: "upto 33% off",
            ),

            SizedBox(height: 10),

            // Product Card 2
            productCard(
              imagePath: 'assets/men.png',
              title: "Men’s Jacket",
              variations: ["Green", "Grey"],
              rating: 4.7,
              price: 45.00,
              oldPrice: 67.00,
              discount: "upto 28% off",
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard({
    required String imagePath,
    required String title,
    required List<String> variations,
    required double rating,
    required double price,
    required double oldPrice,
    required String discount,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Variations : ${variations.join(', ')}"),
                    Row(
                      children: [
                        Text(
                          "$rating",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "\$$oldPrice",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          discount,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Order (1) :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$$price", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
