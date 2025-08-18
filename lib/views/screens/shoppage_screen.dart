import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish_app/views/screens/placeorder_screen.dart';
import 'package:stylish_app/views/widget_tree.dart';
import 'package:stylish_app/views/widgets/cart_provider.dart';
import 'package:badges/badges.dart' as badges;

class ShoppageScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ShoppageScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(product: product),
    );
  }
}

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductPage({Key? key, required this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController _pageController = PageController();
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  int _currentPage = 0;
  late Timer _timer;
  String? _selectedSize; // Store selected size
  List<String> _banners = [];

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (_currentPage < _products.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

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
    _startAutoScroll();
    _fetchProductsFromFirebase();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetTree()),
                );
                // Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),

              padding: EdgeInsets.all(8.0),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceorderScreen()),
                );
              },
              icon: Consumer<CartProvider>(
                builder: (context, cartProvider, _) {
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -4),
                    badgeContent: Text(
                      cartProvider.totalItems.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    child: const Icon(Icons.shopping_cart_outlined),
                  );
                },
              ),
              padding: const EdgeInsets.all(8.0),
            ),

            // Profile Icon
          ],
        ),
      ),
      body: ListView(
        children: [
          _buildProductSlide(),
          _buildProductSize(),
          _buildProductDescription(),
        ],
      ),
    );
  }

  // Widget _buildProductSlide() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 220,
  //         child: PageView.builder(
  //           controller: _pageController,
  //           itemCount: _banners.length,
  //           itemBuilder: (context, index) {
  //             return Container(
  //               margin: const EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(12),
  //                 image: DecorationImage(
  //                   image: NetworkImage(_banners[index]), // ✅ dynamic URL
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       //const SizedBox(height: 2),
  //       SmoothPageIndicator(
  //         controller: _pageController,
  //         count: _banners.length,
  //         effect: const WormEffect(
  //           dotColor: Colors.grey,
  //           activeDotColor: const Color.fromARGB(255, 242, 71, 117),
  //           dotHeight: 8,
  //           dotWidth: 8,
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildProductSlide() {
    final product = widget.product;
    final List<dynamic> imageList = product['imageUrl'] ?? [];

    if (imageList.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(child: Text('No banners available')),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              final imageUrl = imageList[index] as String;
              print("Showing image: $imageUrl"); // Debug print
              return Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _pageController,
          count: imageList.length,
          effect: const WormEffect(
            dotColor: Colors.grey,
            activeDotColor: Color.fromARGB(255, 242, 71, 117),
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  // Widget _buildProductSize() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(12),
  //         child: Text(
  //           'Size: UK',
  //           style: TextStyle(
  //             fontFamily: 'Poppins',
  //             fontWeight: FontWeight.bold,
  //             fontSize: 18,
  //           ),
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           SizedBox(width: 10),
  //           _buildProductSizeType(),
  //           SizedBox(width: 10),
  //           _buildProductSizeType(),
  //           SizedBox(width: 10),
  //           _buildProductSizeType(),
  //           SizedBox(width: 10),
  //           _buildProductSizeType(),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildProductSizeType() {
  //   return Container(
  //     width: 60,
  //     height: 40,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(5),
  //       border: Border.all(color: Colors.red, width: 2),
  //     ),

  //     child: TextButton(
  //       onPressed: () {},
  //       child: Text(
  //         '7 UK',
  //         style: TextStyle(
  //           fontFamily: 'Poppins',
  //           fontWeight: FontWeight.bold,
  //           //fontSize: 20,
  //           color: Colors.red,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildProductSize() {
    // Example: This list should ideally come from your product map in Firebase
    final List<dynamic> sizes = widget.product['size'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Size: UK',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: sizes.map((size) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _buildProductSizeType(size.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductSizeType(String size) {
    final bool isSelected = _selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        width: 60,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 250, 109, 146)
              : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 250, 109, 146)
                : const Color.fromARGB(255, 250, 109, 146),
            width: 2,
          ),
        ),
        child: Text(
          size,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Colors.white
                : const Color.fromARGB(255, 250, 109, 146),
          ),
        ),
      ),
    );
  }

  // Widget _buildProductSizeType(String size) {
  //   return Container(
  //     width: 60,
  //     height: 40,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(5),
  //       border: Border.all(
  //         color: const Color.fromARGB(255, 250, 109, 146),
  //         width: 2,
  //       ),
  //     ),
  //     child: TextButton(
  //       onPressed: () {
  //         print("Selected size: $size");
  //       },
  //       child: Text(
  //         '$size',
  //         style: TextStyle(
  //           fontFamily: 'Poppins',
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 250, 109, 146),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProductDescription() {
    final product = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, top: 20),
          child: Text(
            product['name'],
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            product['desc'],
            style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
          ),
        ),
        SizedBox(height: 10),
        _buildProductStar(),
        _buildDeliveryIn(),
        SizedBox(height: 10),
        _buildTwoComponents(),
        SizedBox(height: 10),
        _buildContentText(),
        _buildProductList(),
      ],
    );
  }

  // Widget _buildGoToCart() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: Image.asset('assets/images/gotocart.png'),
  //     ),
  //   );
  // }
  // Widget _buildGoToCart() {
  //   final product = widget.product;

  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: GestureDetector(
  //       onTap: () {
  //         if (_selectedSize == null) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Please select a size first')),
  //           );
  //           return;
  //         }

  //         Provider.of<CartProvider>(context, listen: false).addItem({
  //           'image': product['images'].isNotEmpty ? product['images'][0] : '',
  //           'size': _selectedSize,
  //           'discountPrice': product['discountPrice'],
  //           'name': product['name'],
  //         });

  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text('Product added to cart!')));
  //       },
  //       child: Image.asset('assets/images/gotocart.png'),
  //     ),
  //   );
  // }

  Widget _buildProductStar() {
    final product = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Row(
                children: List.generate(5, (i) {
                  int rating = product['stars'];
                  return Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
              SizedBox(width: 5),
              Text(
                '56,890',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Text(
                product['mainPrice'],
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              Text(
                product['discountPrice'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${product['discountPercent'].toString().replaceAll('\$', '')}% Off",

                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Text(
                product['detail'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              if (_selectedSize == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a size first')),
                );
                return;
              }

              final cartProvider = Provider.of<CartProvider>(
                context,
                listen: false,
              );

              cartProvider.addItem({
                'imageUrl': product['imageUrl'].isNotEmpty
                    ? product['imageUrl'][0]
                    : '',
                'size': _selectedSize,
                'discountPrice': product['discountPrice'],
                'name': product['name'],
                'quantity':
                    1, // starting quantity, provider will handle increment
              });

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Product added to cart!')));
            },
            child: Image.asset('assets/images/gotocart.png'),
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.only(top: 8, left: 12, right: 12),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         width: 150,
        //         height: 35,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(5),
        //           border: Border.all(color: Colors.grey, width: 2),
        //         ),

        //         child: TextButton(
        //           onPressed: () {},
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.only(left: 4),
        //                 child: Icon(Icons.map, color: Colors.grey, size: 16),
        //               ),
        //               Text(
        //                 "Nearest Store",
        //                 style: TextStyle(
        //                   color: Colors.grey,
        //                   fontSize: 12,
        //                   fontFamily: 'Poppins',
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 5),
        //       Container(
        //         width: 70,
        //         height: 35,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(5),
        //           border: Border.all(color: Colors.grey, width: 2),
        //         ),

        //         child: TextButton(
        //           onPressed: () {},
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.only(left: 4),
        //                 child: Icon(Icons.lock, color: Colors.grey, size: 16),
        //               ),
        //               Text(
        //                 "VIP",
        //                 style: TextStyle(
        //                   color: Colors.grey,
        //                   fontSize: 12,
        //                   fontFamily: 'Poppins',
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 5),
        //       Container(
        //         width: 70,
        //         height: 35,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(5),
        //           border: Border.all(color: Colors.grey, width: 2),
        //         ),

        //         child: TextButton(
        //           onPressed: () {},
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.only(left: 4),
        //                 child: Icon(
        //                   Icons.recycling,
        //                   color: Colors.grey,
        //                   size: 16,
        //                 ),
        //               ),
        //               Text(
        //                 "VIP",
        //                 style: TextStyle(
        //                   color: Colors.grey,
        //                   fontSize: 12,
        //                   fontFamily: 'Poppins',
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildDeliveryIn() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 8),
      child: Card(
        color: const Color.fromARGB(255, 255, 160, 185),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          title: Text(
            "Delivery In",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "1 Within Hour",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoComponents() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Text(
                    "Nearest Store",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.compare, color: Colors.black, size: 20),
                ),
                Text(
                  "Add To Compare",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "282+ Items",
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

  Widget _buildProductList() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_products.isEmpty) {
      return Center(child: Text('No products found'));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _products.map((product) {
            return GestureDetector(
              onTap: () => _onProductTap(product),
              child: Container(
                width: 220,
                margin: EdgeInsets.only(right: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product['imageUrl'][0],
                            width: 180,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 180,
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported),
                                ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          product['desc'],
                          style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 4),
                        Text(
                          product['discountPrice'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (i) {
                            int rating = product['stars'];
                            return Icon(
                              i < rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';

// class ShoppageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: ProductPage());
//   }
// }

// class ProductPage extends StatefulWidget {
//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   final List<String> sizes = ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];
//   int selectedSizeIndex = 1; // default: 7 UK
//   int currentImageIndex = 0;

//   final List<String> imageAssets = [
//     'assets/images/black_nike.png',
//     'assets/images/Nike_shoe.png',
//     'assets/images/nike_shoe2.png',
//   ];

//   late PageController _pageController;
//   Timer? _autoScrollTimer;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();

//     _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_pageController.hasClients) {
//         int nextPage = (_pageController.page!.round() + 1) % imageAssets.length;
//         _pageController.animateToPage(
//           nextPage,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _autoScrollTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Nike Sneakers", style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: BackButton(color: Colors.black),
//         actions: [
//           Icon(Icons.share, color: Colors.black),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 SizedBox(
//                   height: 250,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: imageAssets.length,
//                     onPageChanged: (index) {
//                       setState(() => currentImageIndex = index);
//                     },
//                     itemBuilder: (context, index) {
//                       return Image.asset(imageAssets[index], fit: BoxFit.cover);
//                     },
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: imageAssets.asMap().entries.map((entry) {
//                     return Container(
//                       width: 8,
//                       height: 8,
//                       margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: currentImageIndex == entry.key
//                             ? Colors.red
//                             : Colors.grey.shade400,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Wrap(
//                     spacing: 10,
//                     children: List.generate(sizes.length, (index) {
//                       return ChoiceChip(
//                         label: Text(sizes[index]),
//                         selected: selectedSizeIndex == index,
//                         selectedColor: Colors.red.shade100,
//                         onSelected: (_) {
//                           setState(() {
//                             selectedSizeIndex = index;
//                           });
//                         },
//                       );
//                     }),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Nike Sneakers",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Vision Alta Men’s Shoes Size (All Colours)",
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.orange, size: 18),
//                       Text(" 4.3  "),
//                       Text("(56,890)", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "₹2,999",
//                         style: TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "₹1,500",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                       Text("50% Off", style: TextStyle(color: Colors.green)),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     "Perhaps the most iconic sneaker of all time...",
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on_outlined, size: 20),
//                       SizedBox(width: 5),
//                       Text("Nearest Store"),
//                       Spacer(),
//                       Icon(Icons.cached_outlined),
//                       Text(" Return policy"),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton.icon(
//                           onPressed: () {},
//                           icon: Icon(Icons.shopping_cart),
//                           label: Text("Go to cart"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text("Buy Now"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     color: Colors.pink.shade50,
//                     child: Row(
//                       children: [
//                         Icon(Icons.access_time),
//                         SizedBox(width: 10),
//                         Text("Delivery in "),
//                         Text(
//                           "1 within Hour",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Text(
//                         "Similar To",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Spacer(),
//                       Text("282+ Items", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     height: 150,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: imageAssets.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           width: 120,
//                           margin: EdgeInsets.only(right: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 90,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[200],
//                                   image: DecorationImage(
//                                     image: AssetImage(imageAssets[index]),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Text("Nike Sneakers", maxLines: 1),
//                               Text(
//                                 "₹1,900",
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Wishlist',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
//         ],
//       ),
//     );
//   }
// }
