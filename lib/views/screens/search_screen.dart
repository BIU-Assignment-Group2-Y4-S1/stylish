import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stylish_app/views/screens/shoppage_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // Debounced onChanged caller
  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchProducts(value);
    });
    setState(() => searchQuery = value);
  }

  Future<void> _searchProducts(String query) async {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      setState(() {
        searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      searchResults = [];
    });

    try {
      // IMPORTANT: this requires you to have a 'name_lower' field in each product doc.
      // final snapshot = await FirebaseFirestore.instance
      //     .collection('productStar')
      //     .orderBy('name')
      //     .startAt([q])
      //     .endAt([q + '\uf8ff'])
      //     .get();
      final snapshot = await FirebaseFirestore.instance
          .collection('productStar')
          .where('name', isEqualTo: query) // Exact match only
          .get();

      final results = snapshot.docs.map((d) {
        final data = Map<String, dynamic>.from(d.data() as Map);
        data['id'] = d.id;
        return data;
      }).toList();

      setState(() {
        searchResults = results;
      });
    } catch (e, st) {
      print('Search error: $e\n$st');
      // Fallback: you can optionally fetch a small set and filter locally,
      // but it's not recommended for large collections.
      setState(() {
        searchResults = [];
      });
    } finally {
      setState(() => _isLoading = false);
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

  String _getFirstImageUrl(dynamic imageField) {
    if (imageField == null) return '';
    if (imageField is List && imageField.isNotEmpty)
      return imageField[0].toString();
    if (imageField is String) return imageField;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search any Product...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          if (_isLoading) const LinearProgressIndicator(),

          Expanded(
            child: searchResults.isEmpty
                ? Center(
                    child: Text(
                      searchQuery.isEmpty
                          ? 'Search for a product'
                          : 'No products found',
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,

                    itemBuilder: (context, index) {
                      final product = searchResults[index];
                      final imageUrl = _getFirstImageUrl(product['imageUrl']);
                      return ListTile(
                        leading: imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, st) => Container(
                                    width: 56,
                                    height: 56,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image),
                                  ),
                                ),
                              )
                            : const Icon(Icons.image),
                        title: Text(
                          product['name'] ?? '',
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          '\$${product['discountPrice'] ?? ''}',
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                        onTap: () => _onProductTap(product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Search screen"));
//   }
// }
