import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_app/views/widget_tree.dart';
import 'package:stylish_app/views/widgets/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;
  final double totalAmount;

  const CheckoutScreen({
    Key? key,
    required this.orderItems,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedIndex = 0;
  String _selectedPaymentMethod = 'Visa';

  final user = FirebaseAuth.instance.currentUser;

  final List<Map<String, String>> _paymentMethods = [
    {'name': 'Visa', 'image': 'assets/images/visa.png'},
    {'name': 'PayPal', 'image': 'assets/images/paypal.png'},
    {'name': 'MasterCard', 'image': 'assets/images/mastercard.png'},
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
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetTree()),
                );
              },
            ),
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
      body: Column(
        children: [
          _buildCheckout(widget.orderItems),
          _buildPaymentOptions(),
          _paymentButton(context, user),
        ],
      ),
    );
  }

  Widget _buildCheckout(
    List<Map<String, dynamic>> cartItems, {
    double shippingFee = 0,
  }) {
    // Calculate subtotal
    double subtotal = 0;
    for (var item in cartItems) {
      final price =
          double.tryParse(
            item['discountPrice']?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0',
          ) ??
          0;
      final quantity = item['quantity'] ?? 1;
      subtotal += price * quantity;
    }

    final total = subtotal + shippingFee;

    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 20),
      child: Column(
        children: [
          _buildPriceRow('Order', subtotal.toStringAsFixed(2)),
          SizedBox(height: 12),
          _buildPriceRow('Shipping', shippingFee.toStringAsFixed(2)),
          SizedBox(height: 16),
          _buildPriceRow('Total', total.toStringAsFixed(2), isTotal: true),
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
          // Align(
          //   alignment: Alignment.center,
          //   child: _paymentButton(context, user),
          // ),
        ],
      ),
    );
  }

  // Widget _paymentButton() {
  //   return Container(
  //     height: 60,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Color(0xFFF83758),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       child: TextButton(
  //         onPressed: () {
  //           _showSuccessDialog(context);
  //         },
  //         child: Text(
  //           'Payment',
  //           style: TextStyle(
  //             fontFamily: 'Poppins',
  //             fontWeight: FontWeight.bold,
  //             fontSize: 20,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _paymentButton(BuildContext context, User? user) {
    // final bool isUserLoggedIn = FirebaseAuth.instance.currentUser != null;
    // return Container(
    //   // ... your styling ...
    //   child: TextButton(
    //     onPressed: () async {
    //       if (user == null) return;

    //       final orderData = {
    //         'userId': user.uid,
    //         'email': user.email,
    //         'items': widget.orderItems.map((product) {
    //           return {
    //             'name': product['name'],
    //             'quantity': product['quantity'],
    //             'unitPrice': product['unitPrice'],
    //             'totalPrice': product['unitPrice'] * product['quantity'],
    //           };
    //         }).toList(),
    //         'grandTotal': widget.totalAmount,
    //         'createdAt': FieldValue.serverTimestamp(),
    //       };

    //       try {
    //         await FirebaseFirestore.instance
    //             .collection('orders')
    //             .add(orderData);
    //         print('Order added');
    //         _showSuccessDialog(context);
    //       } catch (e) {
    //         print('Failed to add order: $e');
    //       }
    //     },
    //     child: Text(
    //       'Payment',
    //       style: TextStyle(
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
    final bool isUserLoggedIn = FirebaseAuth.instance.currentUser != null;

    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUserLoggedIn
            ? Color(0xFFF83758)
            : Colors.grey, // grey if disabled
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: isUserLoggedIn
            ? () async {
                final currentUser = FirebaseAuth.instance.currentUser!;
                // Firestore submit logic here
                final orderData = {
                  'userId': currentUser.uid,
                  'email': currentUser.email,
                  'items': widget.orderItems.map((product) {
                    final unitPrice =
                        double.tryParse(
                          (product['discountPrice'] as String).replaceAll(
                            RegExp(r'[^0-9.]'),
                            '',
                          ),
                        ) ??
                        0;
                    final quantity = product['quantity']?.toInt() ?? 0;

                    return {
                      'name': product['name'],
                      'quantity': quantity,
                      'unitPrice': unitPrice,
                      'totalPrice': unitPrice * quantity,
                    };
                  }).toList(),
                  //'grandTotal': widget.totalAmount,
                  'createdAt': FieldValue.serverTimestamp(),
                };

                try {
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .add(orderData);
                  print('Order added');
                  // Clear the cart provider
                  Provider.of<CartProvider>(context, listen: false).clearCart();
                  _showSuccessDialog(context);
                } catch (e) {
                  print('Failed to add order: $e');
                }
              }
            : null, // disable button if user not logged in
        child: Text(
          'Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => WidgetTree()),
                  (route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   int selectedIndex = 0;
//   String _selectedPaymentMethod = 'Visa';

//   final List<Map<String, String>> _paymentMethods = [
//     {'name': 'Visa', 'image': 'assets/images/visa.png'},
//     {'name': 'PayPal', 'image': 'assets/images/paypal.png'},
//     {'name': 'MasterCard', 'image': 'assets/images/maestro.png'},
//     {'name': 'Apple Pay', 'image': 'assets/images/apple.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 90),
//                 child: Text(
//                   'Checkout',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(children: [_buildCheckout(), _buildPaymentOptions()]),
//       floatingActionButton: Transform.translate(
//         offset: Offset(0, 16),
//         child: FloatingActionButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 6,
//           child: Icon(
//             Icons.shopping_cart_outlined,
//             color: Colors.black,
//             size: 28,
//           ),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckout() {
//     return Container(
//       padding: EdgeInsets.only(left: 24, right: 24, top: 20),
//       child: Column(
//         children: [
//           _buildPriceRow('Order', '7,000'),
//           SizedBox(height: 12),
//           _buildPriceRow('Shipping', '1,000'),
//           SizedBox(height: 16),
//           _buildPriceRow('Total', '8,000', isTotal: true),
//           Divider(thickness: 1, color: Colors.grey[300]),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: isTotal ? Colors.black : Colors.grey[600],
//             fontSize: 18,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             color: isTotal ? Colors.black : Colors.grey[800],
//             fontSize: 18,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentOptions() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Select Payment Method',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16),
//           Column(
//             children: _paymentMethods.map((method) {
//               bool isSelected = _selectedPaymentMethod == method['name'];
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedPaymentMethod = method['name']!;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(bottom: 12),
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.grey[200] : Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: isSelected
//                           ? Color(0xFFF83758)
//                           : Colors.grey.shade300,
//                       width: 1.5,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         method['image']!,
//                         height: 40,
//                         width: 60,
//                         fit: BoxFit.contain,
//                       ),
//                       SizedBox(width: 16),
//                       Text(
//                         method['name']!,
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 16,
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                       ),
//                       Spacer(),
//                       if (isSelected)
//                         Icon(Icons.check_circle, color: Color(0xFFF83758)),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 24),
//           Align(alignment: Alignment.center, child: _paymentButton()),
//         ],
//       ),
//     );
//   }

//   Widget _paymentButton() {
//     return Container(
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Color(0xFFF83758),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: TextButton(
//           onPressed: () {
//             _showSuccessDialog(context);
//           },
//           child: Text(
//             'Payment',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/star.png',
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     child: Icon(Icons.check, color: Colors.white, size: 40),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           content: Text(
//             'Your payment was successful!',
//             style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
