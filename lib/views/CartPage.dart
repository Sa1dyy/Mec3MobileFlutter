import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> products = [];
  List<String> searchHistory = [];
  TextEditingController filterController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool showInStockOnly = false;
  String selectedSortCriteria = 'Name';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      isLoading = true;
      products = AppState.cartItems;
      isLoading = false;
    });
  }

  void showPdf(List<dynamic>? documents) {
    if (documents != null && documents.isNotEmpty) {
      String pdfUrl = documents[0]['Url'];
      launch(pdfUrl);
    } else {
      print('No documents available for this product.');
    }
  }

  List<Map<String, dynamic>> filterProducts(String searchText) {
    return products.where((product) {
      final productName = product['Name'].toLowerCase();
      return productName.contains(searchText.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> sortProducts(
      List<Map<String, dynamic>> productList, String criteria) {
    productList.sort((a, b) {
      if (criteria == 'Name') {
        return a['Name'].compareTo(b['Name']);
      } else if (criteria == 'Part Number') {
        return a['PartNumber'].compareTo(b['PartNumber']);
      }
      return 0;
    });
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Váš košík'),
        actions: [
          ElevatedButton(
            onPressed: () {
              _clearCart();
            },
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('Odstranit vše z košíku'),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 400),
                      child: ListView.builder(
                        itemCount: sortProducts(
                                filterProducts(filterController.text),
                                selectedSortCriteria)
                            .length,
                        itemBuilder: (context, index) {
                          final product = sortProducts(
                              filterProducts(filterController.text),
                              selectedSortCriteria)[index];

                          if (showInStockOnly && !product['IsOnStock']) {
                            return Container();
                          }

                          return WhiteCartCard(
                            product: product,
                            onPdfPressed: () {
                              showPdf(product['Documents']);
                            },
                            onAddToCartPressed: () {
                              _addToCart(product);
                            },
                            onRemoveFromCartPressed: () {
                              _removeFromCart(product);
                            },
                          );
                        },
                      ),
                    ),
                  ),
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Vaše poznámka k objednávce',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitOrder();
                      },
                      child: Text('Odeslat objednávku'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      AppState.cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['Name']} - přidáno do košíku!'),
      ),
    );
  }

  void _removeFromCart(Map<String, dynamic> product) {
    setState(() {
      AppState.cartItems.remove(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['Name']} - odstraněno z košíku!'),
      ),
    );
  }

  void _submitOrder() {
    String note = noteController.text;
    print('Order submitted with note: $note');
  }

  void _clearCart() {
    setState(() {
      AppState.cartItems.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Všechny položky byly odebrány z košíku'),
      ),
    );
  }
}

class WhiteCartCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onPdfPressed;
  final VoidCallback? onAddToCartPressed;
  final VoidCallback? onRemoveFromCartPressed;

  WhiteCartCard({
    required this.product,
    this.onPdfPressed,
    this.onAddToCartPressed,
    this.onRemoveFromCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? documents = product['Documents'];
    final bool hasValidPdfUrl = documents != null &&
        documents.isNotEmpty &&
        documents[0]['Url'] != 'https://mec3.cz/getmedia//Document';

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              product['Name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Part Number: ${product['PartNumber']}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Measure Unit: ${product['MeasureUnit']}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Min Quantity: ${product['MinQuantity']}',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 8),
            if (!product['IsOnStock'])
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 5),
                  Text('Není skladem', style: TextStyle(color: Colors.red)),
                ],
              ),
            ElevatedButton(
              onPressed: onRemoveFromCartPressed,
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Odebrat z košíku'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
