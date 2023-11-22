import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/components/EshopCard.dart';

class EshopPage extends StatefulWidget {
  @override
  _EshopPageState createState() => _EshopPageState();
}

class _EshopPageState extends State<EshopPage> {
  List<Map<String, dynamic>> products = [];
  bool showInStockOnly = false;
  TextEditingController filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://mec3.cz/mec3mobile/ProductMobile/GetFavoritesForUser/' + AppState.user.id.toString()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      setState(() {
        products = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eshop'),
      ),
      body: Container(
        color: Colors.grey[200], // Barva pozadí
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Zobrazit pouze položky skladem'),
                  Switch(
                    value: showInStockOnly,
                    onChanged: (value) {
                      setState(() {
                        showInStockOnly = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: filterController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Filtrovat podle názvu',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  itemCount: filterProducts(filterController.text).length,
                  itemBuilder: (context, index) {
                    final product = filterProducts(filterController.text)[index];

                    if (showInStockOnly && !product['IsOnStock']) {
                      return Container(); // Skryje produkt, pokud má být zobrazen pouze skladem
                    }

                    return EshopCard(product, onPdfPressed: () {
                      showPdf(product['Documents']);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

