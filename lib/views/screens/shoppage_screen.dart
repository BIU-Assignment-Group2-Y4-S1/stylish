import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish_app/views/screens/home_screen.dart';
import 'package:stylish_app/views/screens/shipping_screen.dart';
import 'package:stylish_app/views/screens/wishlist_screen.dart';
import 'package:stylish_app/views/widgets/banner_section.dart';
import 'package:stylish_app/views/widgets/bottomNavbar_widget.dart';

class ShoppageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ProductPage());
  }
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _banners = [
    'assets/images/Nike_shoe.png',
    'assets/images/Nike_shoe.png',
    'assets/images/Nike_shoe.png',
  ];
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
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
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.arrow_back_ios),

              padding: EdgeInsets.all(8.0),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined),

              padding: EdgeInsets.all(8.0),
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
      // floatingActionButton: Transform.translate(
      //   offset: Offset(0, 16), // Move down by 16 pixels (adjust as needed)
      //   child: FloatingActionButton(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(30),
      //     ),
      //     backgroundColor: Colors.white,
      //     elevation: 6,
      //     child: Icon(
      //       Icons.shopping_cart_outlined,
      //       color: Colors.black,
      //       size: 28,
      //     ),
      //     onPressed: () {
      //       // Handle cart tap
      //     },
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomnavbarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildProductSlide() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(_banners[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        //const SizedBox(height: 2),
        SmoothPageIndicator(
          controller: _pageController,
          count: _banners.length,
          effect: const WormEffect(
            dotColor: Colors.grey,
            activeDotColor: const Color.fromARGB(255, 242, 71, 117),
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildProductSize() {
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
        Row(
          children: [
            SizedBox(width: 10),
            _buildProductSizeType(),
            SizedBox(width: 10),
            _buildProductSizeType(),
            SizedBox(width: 10),
            _buildProductSizeType(),
            SizedBox(width: 10),
            _buildProductSizeType(),
          ],
        ),
      ],
    );
  }

  Widget _buildProductSizeType() {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.red, width: 2),
      ),

      child: TextButton(
        onPressed: () {},
        child: Text(
          '7 UK',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            //fontSize: 20,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, top: 20),
          child: Text(
            'Nike Sneakers',
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
            'Vision Alta Men’s Shoes Size (All Colours)',
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

  Widget _buildGoToCart() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {},
        child: Image.asset('assets/images/gotocart.png'),
      ),
    );
  }

  Widget _buildProductStar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Row(
                children: List.generate(5, (i) {
                  double rating = 4.5;
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
                '2,897',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '1,500',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '50% Off',
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
                'Perhaps the most iconic sneaker of all-time, this original "Chicago"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. ',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShippingScreen()),
              );
            },
            child: Image.asset('assets/images/gotocart.png', width: 150),
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
            width: 180,
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
                      Icons.view_array,
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
          width: 185,
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
                  child: Icon(Icons.view_array, color: Colors.black, size: 20),
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
    final products = [
      {
        'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
        'name': 'Elegant Dress',
        'desc': 'Perfect for parties and events.',
        'price': '\$49.99',
        'stars': 4.5,
      },
      {
        'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9',
        'name': 'Fashion Shoes',
        'desc': 'Trendy and comfortable.',
        'price': '\$29.99',
        'stars': 4.0,
      },
      {
        'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
        'name': 'Smart Watch',
        'desc': 'Track your fitness and notifications.',
        'price': '\$99.99',
        'stars': 5.0,
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Products",
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontFamily: 'Poppins',
          //     fontSize: 18,
          //   ),
          // ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: products
                  .map(
                    (product) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WishlistScreen(),
                          ),
                        );
                      },
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
                                    product['image'] as String,
                                    width: 180,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product['name'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product['desc'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product['price'] as String,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (i) {
                                    double rating = product['stars'] as double;
                                    return Icon(
                                      i < rating
                                          ? Icons.star
                                          : Icons.star_border,
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
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
