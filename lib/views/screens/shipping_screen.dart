import 'package:flutter/material.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // prevent default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu Icon
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Placeholder()),
                // );
                Navigator.pop(context);
              },
            ),

            // Center logo/text
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
      body: Column(children: [_buildCheckout(), _buildPayment()]),
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
          //SizedBox(height: 12),
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

  Widget _buildPayment() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start
        children: [
          Text(
            'Payment',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildVisaPayment(),
          SizedBox(height: 16),
          _buildPayPalPayment(),
          SizedBox(height: 16),
          _buildMasterPayment(),
          SizedBox(height: 16),
          _buildApplePayPayment(),
          SizedBox(height: 24),
          Align(alignment: Alignment.center, child: _paymentButton()),
        ],
      ),
    );
  }

  Widget _buildVisaPayment() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Image(
              image: AssetImage('assets/images/visa.png'),
              height: 40,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 120),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '**** **** **** 1234',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 70,
                //   vertical: 10,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayPalPayment() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Image(
              image: AssetImage('assets/images/paypal.png'),
              height: 40,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 120),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '**** **** **** 1234',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 70,
                //   vertical: 10,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterPayment() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Image(
              image: AssetImage('assets/images/maestro.png'),
              height: 40,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 120),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '**** **** **** 1234',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 70,
                //   vertical: 10,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplePayPayment() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Image(
              image: AssetImage('assets/images/apple.png'),
              height: 40,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 120),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '**** **** **** 1234',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 70,
                //   vertical: 10,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentButton() {
    return Container(
      // onTap: () {},
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),

        //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),

        child:
            // mainAxisAlignment: MainAxisAlignment.center,
            TextButton(
              onPressed: () {
                _showSuccessDialog(context);
              },
              child: Text(
                'Continuo',
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
                alignment: Alignment.center, // Center the tick
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
                Navigator.of(context).pop(); // close the dialog
                // Navigate to another screen if needed
                // Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
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

// class ShippingScreen extends StatefulWidget {
//   const ShippingScreen({super.key});

//   @override
//   State<ShippingScreen> createState() => _ShippingScreenState();
// }

// class _ShippingScreenState extends State<ShippingScreen> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // prevent default back arrow
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Menu Icon
//             IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),

//             // Center logo/text
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
//       body: Column(children: [_buildCheckout(), _buildPayment()]),

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
//           onPressed: () {
//             // Handle cart tap
//           },
//         ),
//       ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // bottomNavigationBar: BottomnavbarWidget(
//       //   selectedIndex: selectedIndex,
//       //   onItemTapped: (index) {
//       //     setState(() {
//       //       selectedIndex = index;
//       //     });
//       //   },
//       // ),
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
//           //SizedBox(height: 12),
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

//   Widget _buildPayment() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start, // Align children to the start
//         children: [
//           Text(
//             'Payment',
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           _buildVisaPayment(),
//           SizedBox(height: 16),
//           _buildPayPalPayment(),
//           SizedBox(height: 16),
//           _buildMasterPayment(),
//           SizedBox(height: 16),
//           _buildApplePayPayment(),
//           SizedBox(height: 24),
//           Align(alignment: Alignment.center, child: _paymentButton()),
//         ],
//       ),
//     );
//   }

//   Widget _buildVisaPayment() {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),


//         //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 12),
//             child: Image(
//               image: AssetImage('assets/images/visa.png'),
//               height: 40,
//               width: 60,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(width: 120),
//           Expanded(
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: '**** **** **** 1234',
//                 hintStyle: TextStyle(color: Colors.grey[600]),
//                 border: InputBorder.none,
//                 // contentPadding: EdgeInsets.symmetric(
//                 //   horizontal: 70,
//                 //   vertical: 10,
//                 // ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPayPalPayment() {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),

//         //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 12),
//             child: Image(
//               image: AssetImage('assets/images/paypal.png'),
//               height: 40,
//               width: 60,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(width: 120),
//           Expanded(
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: '**** **** **** 1234',
//                 hintStyle: TextStyle(color: Colors.grey[600]),
//                 border: InputBorder.none,
//                 // contentPadding: EdgeInsets.symmetric(
//                 //   horizontal: 70,
//                 //   vertical: 10,
//                 // ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMasterPayment() {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),

//         //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 12),
//             child: Image(
//               image: AssetImage('assets/images/maestro.png'),
//               height: 40,
//               width: 60,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(width: 120),
//           Expanded(
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: '**** **** **** 1234',
//                 hintStyle: TextStyle(color: Colors.grey[600]),
//                 border: InputBorder.none,
//                 // contentPadding: EdgeInsets.symmetric(
//                 //   horizontal: 70,
//                 //   vertical: 10,
//                 // ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildApplePayPayment() {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),


//         //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 12),
//             child: Image(
//               image: AssetImage('assets/images/apple.png'),
//               height: 40,
//               width: 60,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(width: 120),
//           Expanded(
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: '**** **** **** 1234',
//                 hintStyle: TextStyle(color: Colors.grey[600]),
//                 border: InputBorder.none,
//                 // contentPadding: EdgeInsets.symmetric(
//                 //   horizontal: 70,
//                 //   vertical: 10,
//                 // ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _paymentButton() {
//     return Container(
//       // onTap: () {},
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(10),

//         //border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//       ),

//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),

//         child:
//             // mainAxisAlignment: MainAxisAlignment.center,
//             TextButton(
//               onPressed: () {
//                 _showSuccessDialog(context);
//               },
//               child: Text(
//                 'Continuo',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
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
//                 alignment: Alignment.center, // Center the tick
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
//                 Navigator.of(context).pop(); // close the dialog
//                 // Navigate to another screen if needed
//                 // Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// }