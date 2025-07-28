import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(NikeSneakersApp());

class NikeSneakersApp extends StatelessWidget {
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
  final List<String> sizes = ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];
  int selectedSizeIndex = 1; // default: 7 UK
  int currentImageIndex = 0;

  final List<String> imageAssets = [
    'assets/black_nike.png',
    'assets/Nike_shoe.png',
    'assets/nike_shoe2.png',
  ];

  late PageController _pageController;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.round() + 1) % imageAssets.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nike Sneakers", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          Icon(Icons.share, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageAssets.length,
                    onPageChanged: (index) {
                      setState(() => currentImageIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(imageAssets[index], fit: BoxFit.cover);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageAssets.asMap().entries.map((entry) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentImageIndex == entry.key
                            ? Colors.red
                            : Colors.grey.shade400,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    children: List.generate(sizes.length, (index) {
                      return ChoiceChip(
                        label: Text(sizes[index]),
                        selected: selectedSizeIndex == index,
                        selectedColor: Colors.red.shade100,
                        onSelected: (_) {
                          setState(() {
                            selectedSizeIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Nike Sneakers",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Vision Alta Men’s Shoes Size (All Colours)",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Text(" 4.3  "),
                      Text("(56,890)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "₹2,999",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "₹1,500",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("50% Off", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Perhaps the most iconic sneaker of all time...",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 20),
                      SizedBox(width: 5),
                      Text("Nearest Store"),
                      Spacer(),
                      Icon(Icons.cached_outlined),
                      Text(" Return policy"),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Go to cart"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Buy Now"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.pink.shade50,
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 10),
                        Text("Delivery in "),
                        Text(
                          "1 within Hour",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Similar To",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text("282+ Items", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageAssets.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 120,
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                    image: AssetImage(imageAssets[index]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("Nike Sneakers", maxLines: 1),
                              Text(
                                "₹1,900",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
