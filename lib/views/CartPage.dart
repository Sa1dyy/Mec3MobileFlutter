import 'package:flutter/material.dart';
import 'package:mec3mobileflutter/components/CartCard.dart';
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

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      AppState.cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['Name']} - přidáno do košíku!'),
      ),
    );
  }

  void removeFromCart(Map<String, dynamic> product) {
    setState(() {
      AppState.cartItems.remove(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['Name']} - odstraněno z košíku!'),
      ),
    );
  }

  void submitOrder() {
    String note = noteController.text;
    print('Order submitted with note: $note');
  }

  void clearCart() {
    setState(() {
      AppState.cartItems.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Všechny položky byly odebrány z košíku'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Váš košík'),
        actions: [
          ElevatedButton(
            onPressed: () {
              clearCart();
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

                          return cartCard(
                            product: product,
                            onPdfPressed: () {
                              showPdf(product['Documents']);
                            },
                            onAddToCartPressed: () {
                              addToCart(product);
                            },
                            onRemoveFromCartPressed: () {
                              removeFromCart(product);
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
                        submitOrder();
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
}
