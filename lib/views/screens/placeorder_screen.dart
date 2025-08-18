import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_app/views/screens/checkout_screen.dart';
import 'package:stylish_app/views/widgets/cart_provider.dart';

class PlaceorderScreen extends StatefulWidget {
  const PlaceorderScreen({super.key});

  @override
  State<PlaceorderScreen> createState() => _PlaceorderScreenState();
}

class _PlaceorderScreenState extends State<PlaceorderScreen> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: ListView(
  //                 children: [
  //                   _cartItem(
  //                     imageUrl:
  //                         'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
  //                     name: 'Regular Fit',
  //                     size: 'L',
  //                     price: 1190,
  //                     quantity: 2,
  //                   ),
  //                   _cartItem(
  //                     imageUrl:
  //                         'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
  //                     name: 'Regular Fit',
  //                     size: 'M',
  //                     price: 1100,
  //                     quantity: 1,
  //                   ),
  //                   _cartItem(
  //                     imageUrl:
  //                         'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
  //                     name: 'Regular Fit ',
  //                     size: 'L',
  //                     price: 1290,
  //                     quantity: 1,
  //                   ),
  //                   _cartItem(
  //                     imageUrl:
  //                         'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
  //                     name: 'Regular Fit',
  //                     size: 'L',
  //                     price: 1190,
  //                     quantity: 2,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //             _summaryRow('Sub-total', 5870),
  //             _summaryRow('VAT (%)', 0),
  //             _summaryRow('Shipping fee', 0),
  //             const Divider(height: 32, thickness: 1),
  //             _summaryRow('Total', 5950, isTotal: true),
  //             const SizedBox(height: 16),
  //             SizedBox(
  //               width: double.infinity,
  //               height: 50,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pushNamed(AppRoute.checkoutScreen);
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Color(0xFFF83758),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //                 child: const Text(
  //                   'Go To Checkout',
  //                   style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              final cartItems = cartProvider.items;

              // Calculate subtotal dynamically with decimals
              double subtotal = 0;
              for (var item in cartItems) {
                final priceString = item['discountPrice'] as String? ?? '0';
                final price =
                    double.tryParse(
                      priceString.replaceAll(RegExp(r'[^0-9.]'), ''),
                    ) ??
                    0.0;
                final quantity = item['quantity'] ?? 1;
                subtotal += price * quantity;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: cartItems.isEmpty
                        ? Center(child: Text('Your cart is empty'))
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _cartItem(
                                imageUrl: item['imageUrl'] ?? '',
                                name: item['name'] ?? '',
                                size: item['size'] ?? '',
                                price:
                                    double.tryParse(
                                      (item['discountPrice'] as String)
                                          .replaceAll(RegExp(r'[^0-9.]'), ''),
                                    ) ??
                                    0.0,
                                quantity: item['quantity'] ?? 1,
                                onQuantityChanged: (newQuantity) {
                                  cartProvider.updateQuantity(
                                    index,
                                    newQuantity,
                                  );
                                },
                                deleteAction: () {
                                  cartProvider.removeItem(index);
                                },
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  _summaryRow('Sub-total', subtotal),
                  _summaryRow('VAT (%)', 0),
                  _summaryRow('Shipping fee', 0),
                  const Divider(height: 32, thickness: 1),
                  _summaryRow('Total', subtotal, isTotal: true),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(
                        //   context,
                        // ).pushNamed(AppRoute.checkoutScreen);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              orderItems: cartProvider.items, // List<OrderItem>
                              totalAmount: cartProvider.totalAmount,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF83758),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Go To Checkout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _cartItem({
    required String imageUrl,
    required String name,
    required String size,
    required double price,
    required int quantity,
    required void Function(int) onQuantityChanged,
    required VoidCallback deleteAction,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Size: $size - \$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
                // Text(
                //   '\$${price.toStringAsFixed(2)}',
                //   style: const TextStyle(
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: quantity > 1
                    ? () => onQuantityChanged(quantity - 1)
                    : null,
                icon: const Icon(Icons.remove, size: 20),
              ),
              Text('$quantity'),
              IconButton(
                onPressed: () => onQuantityChanged(quantity + 1),
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          IconButton(
            onPressed: deleteAction,
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:stylish_app/routes/app_routes.dart';

// class PlaceorderScreen extends StatefulWidget {
//   const PlaceorderScreen({super.key});

//   @override
//   State<PlaceorderScreen> createState() => _PlaceorderScreenState();
// }

// class _PlaceorderScreenState extends State<PlaceorderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     _cartItem(
//                       imageUrl:
//                           'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
//                       name: 'Regular Fit',
//                       size: 'L',
//                       price: 1190,
//                       quantity: 2,
//                     ),
//                     _cartItem(
//                       imageUrl:
//                           'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
//                       name: 'Regular Fit',
//                       size: 'M',
//                       price: 1100,
//                       quantity: 1,
//                     ),
//                     _cartItem(
//                       imageUrl:
//                           'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
//                       name: 'Regular Fit ',
//                       size: 'L',
//                       price: 1290,
//                       quantity: 1,
//                     ),
//                     _cartItem(
//                       imageUrl:
//                           'https://nobero.com/cdn/shop/files/222C021C-8EFF-4A86-A782-A25876663738.jpg?v=1732879745',
//                       name: 'Regular Fit',
//                       size: 'L',
//                       price: 1190,
//                       quantity: 2,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _summaryRow('Sub-total', 5870),
//               _summaryRow('VAT (%)', 0),
//               _summaryRow('Shipping fee', 0),
//               const Divider(height: 32, thickness: 1),
//               _summaryRow('Total', 5950, isTotal: true),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pushNamed(AppRoute.checkoutScreen);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFF83758),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Go To Checkout',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _cartItem({
//     required String imageUrl,
//     required String name,
//     required String size,
//     required int price,
//     required int quantity,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               imageUrl,
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text('Size $size'),
//                 const SizedBox(height: 8),
//                 Text(
//                   '\$ $price',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.remove, size: 20),
//               ),
//               Text('$quantity'),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.add, size: 20),
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.delete, color: Colors.redAccent),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryRow(String label, int amount, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             '\$ ${amount.toString()}',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
