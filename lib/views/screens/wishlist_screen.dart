import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/views/screens/shoppage_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int selectedIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  Future<void> _fetchProductsFromFirebase() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('productStar')
          .get();

      final products = snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          // 'imageUrl': List<String>.from(data['imageUrl'] ?? []),
          'imageUrl': data['imageUrl'] ?? '',
          'name': data['name'] ?? '',
          'desc': data['desc'] ?? '',
          'size': List<String>.from(data['size'] ?? []),
          'mainPrice': '\$${data['mainPrice']?.toString() ?? '0.00'}',
          'discountPrice': '\$${data['discountPrice']?.toString() ?? '0.00'}',
          'discountPercent': '\$${data['discountPercent']?.toString() ?? '0'}',
          'stars': data['stars'] ?? 0,
          'detail': data['detail'] ?? '',
        };
      }).toList();

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onProductTap(Map<String, dynamic> product) {
    // Example action: show snackbar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Clicked on ${product['name']}")));

    // You can replace this with navigation:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShoppageScreen(product: product)),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchProductsFromFirebase();
  }

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
              icon: Icon(Icons.menu),
              onPressed: () {},
              padding: EdgeInsets.all(8.0),
            ),

            // Center logo/text
            Expanded(
              child: Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/stylish.png',
                  ), // Replace with your logo asset
                  height: 70, // Adjust height as needed
                  width: 120, // Adjust width as needed
                ),
              ),
            ),

            // Profile Icon
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Handle profile tap - maybe navigate to profile screen
                },
                child: Container(
                  padding: EdgeInsets.all(2), // Border width
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200], // Border color
                  ),
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      final user = snapshot.data;
                      final photoUrl = user?.photoURL;

                      return CircleAvatar(
                        radius: 16,
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl) as ImageProvider
                            : AssetImage('assets/images/user_default.png'),
                        backgroundColor: Colors.grey[200],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          _buildSearchBar(), _buildContentText(), _buildProductGrid(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints(
          //       maxHeight:
          //           MediaQuery.of(context).size.height * 2, // adjust as needed
          //     ),
          //     child: ProductGrid(),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search any Product...",
          hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'Poppins'),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),

          filled: true,
          fillColor: Colors.white, // Optional: adds a subtle background
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffix: Icon(Icons.mic, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildContentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "52,082 + Items",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children: [
            Material(
              color:
                  Colors.transparent, // Makes ripple visible on white container
              child: InkWell(
                onTap: () {
                  // Handle the tap for the whole button
                },
                borderRadius: BorderRadius.circular(
                  8,
                ), // Match container radius
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.import_export, color: Colors.black, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8), // Space between Sort and Filter buttons
            Material(
              color:
                  Colors.transparent, // Makes ripple visible on white container
              child: InkWell(
                onTap: () {
                  // Handle the tap for the whole button
                },
                borderRadius: BorderRadius.circular(
                  8,
                ), // Match container radius
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.filter_list, color: Colors.black, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  // Widget _buildProductGrid() {
  //   if (_isLoading) {
  //     return Center(child: CircularProgressIndicator());
  //   }

  //   if (_products.isEmpty) {
  //     return Center(child: Text('No products found'));
  //   }
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(), // Let parent scroll
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 12,
  //         mainAxisSpacing: 12,
  //         childAspectRatio: 0.75, // Adjust for card height
  //       ),

  //       itemCount: _products.length,
  //       itemBuilder: (context, index) {
  //         final product = _products[index];
  //         return GestureDetector(
  //           onTap: () => (_onProductTap(product)),
  //           child: Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             elevation: 2,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(12),
  //                     child: Image.network(
  //                       product['imageUrl'] as String,
  //                       height: 120,
  //                       width: double.infinity,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text(
  //                     product['name'] as String,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: 'Poppins',
  //                       fontSize: 15,
  //                     ),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   SizedBox(height: 4),
  //                   Text(
  //                     product['desc'] as String,
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey[700],
  //                       fontFamily: 'Poppins',
  //                     ),
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   SizedBox(height: 6),
  //                   Text(
  //                     product['discountPrice'] as String,
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: 'Poppins',
  //                     ),
  //                   ),
  //                   SizedBox(height: 6),
  //                   Row(
  //                     children: [
  //                       ...List.generate(5, (i) {
  //                         double rating = product['stars'] as double;
  //                         return Icon(
  //                           i < rating ? Icons.star : Icons.star_border,
  //                           color: Colors.amber,
  //                           size: 16,
  //                         );
  //                       }),
  //                       // SizedBox(width: 4),
  //                       // Text(
  //                       //   product['reviews'] as String,
  //                       //   style: TextStyle(
  //                       //     fontSize: 11,
  //                       //     color: Colors.grey[600],
  //                       //     fontFamily: 'Poppins',
  //                       //   ),
  //                       // ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget _buildProductGrid() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_products.isEmpty) {
      return Center(child: Text('No products found'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // Let parent scroll
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75, // Adjust for card height
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];

          // Extract image URL safely
          final images = product['imageUrl'];
          String firstImageUrl = '';
          if (images is List && images.isNotEmpty) {
            firstImageUrl = images[0].toString();
          } else if (images is String) {
            firstImageUrl = images;
          }

          final name = product['name'] ?? '';
          final desc = product['desc'] ?? '';
          final discountPrice = product['discountPrice'] ?? '';
          final stars = product['stars'] ?? '';

          return GestureDetector(
            onTap: () => _onProductTap(product),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: firstImageUrl.isNotEmpty
                          ? Image.network(
                              firstImageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Icon(Icons.broken_image),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 120,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      discountPrice,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < stars ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:stylish_app/views/widgets/bottomNavbar_widget.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({super.key});

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
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
//             IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () {},
//               padding: EdgeInsets.all(8.0),
//             ),

//             // Center logo/text
//             Expanded(
//               child: Center(
//                 child: Image(
//                   image: AssetImage(
//                     'assets/images/stylish.png',
//                   ), // Replace with your logo asset
//                   height: 70, // Adjust height as needed
//                   width: 120, // Adjust width as needed
//                 ),
//               ),
//             ),

//             // Profile Icon
//             SizedBox(
//               child: GestureDetector(
//                 onTap: () {},
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.dark_mode),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       body: ListView(
//         children: [
//           _buildSearchBar(), _buildContentText(), _buildProductGrid(),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: ConstrainedBox(
//           //     constraints: BoxConstraints(
//           //       maxHeight:
//           //           MediaQuery.of(context).size.height * 2, // adjust as needed
//           //     ),
//           //     child: ProductGrid(),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search any Product...",
//           hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'Poppins'),
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),

//           filled: true,
//           fillColor: Colors.white, // Optional: adds a subtle background
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           suffix: Icon(Icons.mic, color: Colors.grey),
//         ),
//       ),
//     );
//   }

//   Widget _buildContentText() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: Text(
//             "52,082 + Items",
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         Row(
//           children: [
//             Material(
//               color:
//                   Colors.transparent, // Makes ripple visible on white container
//               child: InkWell(
//                 onTap: () {
//                   // Handle the tap for the whole button
//                 },
//                 borderRadius: BorderRadius.circular(
//                   8,
//                 ), // Match container radius
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white, width: 1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Sort",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.import_export, color: Colors.black, size: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 8), // Space between Sort and Filter buttons
//             Material(
//               color:
//                   Colors.transparent, // Makes ripple visible on white container
//               child: InkWell(
//                 onTap: () {
//                   // Handle the tap for the whole button
//                 },
//                 borderRadius: BorderRadius.circular(
//                   8,
//                 ), // Match container radius
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white, width: 1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Filter",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.filter_list, color: Colors.black, size: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 8),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildProductGrid() {
//     final products = [
//       {
//         'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
//         'name': 'Black Winter...',
//         'desc': 'Autumn And Winter Casual cotton-padded jacket...',
//         'price': '₹499',
//         'stars': 4.5,
//         'reviews': '6,890',
//       },
//       {
//         'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9',
//         'name': 'Mens Starry',
//         'desc': 'Mens Starry Sky Printed Shirt 100% Cotton Fabric',
//         'price': '₹399',
//         'stars': 4.0,
//         'reviews': '1,52,344',
//       },
//       {
//         'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
//         'name': 'Black Dress',
//         'desc': 'Solid Black Dress for Women, Sexy Chain Shorts Ladi...',
//         'price': '₹2,000',
//         'stars': 4.5,
//         'reviews': '5,23,456',
//       },
//       {
//         'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
//         'name': 'Pink Embroide...',
//         'desc': 'EARTHEN Rose Pink Embroidered Tiered Max...',
//         'price': '₹1,900',
//         'stars': 4.0,
//         'reviews': '45,678',
//       },
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(), // Let parent scroll
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.65, // Adjust for card height
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       product['image'] as String,
//                       height: 120,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     product['name'] as String,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                       fontSize: 15,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     product['desc'] as String,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[700],
//                       fontFamily: 'Poppins',
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     product['price'] as String,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Row(
//                     children: [
//                       ...List.generate(5, (i) {
//                         double rating = product['stars'] as double;
//                         return Icon(
//                           i < rating ? Icons.star : Icons.star_border,
//                           color: Colors.amber,
//                           size: 16,
//                         );
//                       }),
//                       SizedBox(width: 4),
//                       Text(
//                         product['reviews'] as String,
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey[600],
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
