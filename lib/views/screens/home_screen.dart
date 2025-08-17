import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stylish_app/views/screens/shoppage_screen.dart';
import 'package:stylish_app/views/screens/wishlist_screen.dart';
import 'package:stylish_app/views/widgets/banner_section.dart';
import 'package:stylish_app/views/widgets/bottomNavbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // final List<Widget> _screens = [
  //   WishlistScreen(),
  //   Container(), // Placeholder for FAB/cart
  // ];
  @override
  static const categories = [
    'Dress',
    'Fashion',
    'Shoes',
    'Electronics',
    'More',
  ];

  static const productImages = [
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f', // Dress
    'https://images.unsplash.com/photo-1517841905240-472988babdf9', // Fashion
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308', // Shoes
    'https://images.unsplash.com/photo-1517336714731-489689fd1ca8', // Electronics
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb', // More
  ];

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
            SizedBox(
              child: GestureDetector(
                onTap: () { },
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.dark_mode),
                ),
              ),
            ),
          ],
        ),
        // actions: [
        //     IconButton(
        //       onPressed: () {
        //         isDarkModeNotifier.value = !isDarkModeNotifier.value;
        //       },
        //       icon: ValueListenableBuilder(
        //         valueListenable: isDarkModeNotifier,
        //         builder: (context, isDarkMode, child) {
        //           return Icon(
        //             isDarkMode ? Icons.dark_mode : Icons.light_mode,
        //           );
        //         },
        //       ),
        //     ),
        //     IconButton(onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context){
        //             return SettingPage(
        //               title: "Setting page",
        //             );
        //         },
        //       ),
        //       );
        //     },
        //   ],
      ),

      body: ListView(
        children: [
          _buildSearchBar(),
          _buildContentText(),
          _buildAllFeatures(),
          BannerSection(),
          _buildDealOfTheDay(),
          _buildProductListOne(),
          _buildSpecialOffers(),
          _buildBannerTwoSection(),
          _buildTrendingProducts(),
          _buildProductListTwo(),
          _buildNewArrivals(),
          _buildSponsored(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search any Product...",
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
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
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: Icon(Icons.mic, color: Colors.grey),
              ),
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
            "All Features",
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

  Widget _buildAllFeatures() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 0, bottom: 0, top: 8),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the left
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Container(
              height: 120, // Adjust height as needed
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _HomeScreenState.productImages.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                _HomeScreenState.productImages[index],
                              ),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(height: 6),
                            Text(
                              _HomeScreenState.categories[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      margin: EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(
            'assets/images/banner.png',
          ), // Replace with your banner image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDealOfDaySection(BuildContext context) {
    return ListTile(
      title: Text("Deal of the Day"),
      trailing: TextButton(
        onPressed: () => Navigator.pushNamed(context, '/products'),
        child: Text("View All"),
      ),
    );
  }

  Widget _buildBannerTwoSection() {
    return Container(
      margin: EdgeInsets.all(12),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(
            'assets/images/mac.png',
          ), // Replace with your banner image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDealOfTheDay() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 8),
      child: Card(
        color: const Color.fromARGB(255, 15, 137, 224),
        child: ListTile(
          title: Text(
            "Deal of the Day",
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
          subtitle: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(Icons.alarm, size: 18, color: Colors.white),
              ),
              SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "22h 55mn 50s remaining",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: () {
              print("deal of the day");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 137, 224),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductListOne() {
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

  Widget _buildSpecialOffers() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        color: Colors.white,
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/images/offer.png'),
            height: 80,
            width: 100,
          ),

          title: Row(
            children: [
              Text(
                "Special Offers",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Image(image: AssetImage('assets/images/icon.png')),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "We make sure you get the offer you need at best prices",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingProducts() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 0),
      child: Card(
        color: const Color.fromARGB(255, 255, 160, 185),
        child: ListTile(
          title: Text(
            "Trending Products",
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
          subtitle: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Last Date 17/03/2025",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: () {
              print("treding produts");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 160, 185),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductListTwo() {
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
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 0),
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
                    (product) => Container(
                      width: 170,
                      margin: EdgeInsets.only(right: 12),
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
                                  width: 140,
                                  height: 100,
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
                              // SizedBox(height: 4),
                              // Row(
                              //   children: List.generate(5, (i) {
                              //     double rating = product['stars'] as double;
                              //     return Icon(
                              //       i < rating ? Icons.star : Icons.star_border,
                              //       color: Colors.amber,
                              //       size: 16,
                              //     );
                              //   }),
                              // ),
                            ],
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

  // Widget _buildNewArrivals() {
  //   return ListTile(
  //     title: Text("New Arrivals"),
  //     trailing: TextButton(onPressed: () {}, child: Text("View All")),
  //   );
  // }

  Widget _buildNewArrivals() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            child: Image(
              image: AssetImage('assets/images/summer.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 160,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: ListTile(
            title: Text(
              "New Arrivals",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Summer 25 collections",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.grey[600]),
            ),
            trailing: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 58, 107),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        //SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSponsored() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Text(
            "Sponsered",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 0, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(0),
            ),
            child: Image(
              image: AssetImage('assets/images/sponser.png'),
              fit: BoxFit.cover,
              width: 380,
              height: 300,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "up to 50% off",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
