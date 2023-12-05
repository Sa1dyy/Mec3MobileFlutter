import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mec3mobileflutter/components/EshopCard.dart';
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/views/CartPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class EshopPage extends StatefulWidget {
  final bool isSubcategory;

  EshopPage(this.isSubcategory);

  @override
  _EshopPageState createState() => _EshopPageState();
}

class _EshopPageState extends State<EshopPage> {
  List<Map<String, dynamic>> products = [];
  List<String> searchHistory = [];
  TextEditingController filterController = TextEditingController();
  bool showInStockOnly = false;
  String selectedSortCriteria = 'Název';
  bool isLoading = true;
  List<Map<String, dynamic>> categories = [];
  Map<String, dynamic> selectedCategory = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final uri = widget.isSubcategory
          ? Uri.parse(
              'https://mec3.cz/mec3mobile/ProductMobile/GetEshopSubcategoryProducts')
          : Uri.parse(
              'https://mec3.cz/mec3mobile/ProductMobile/GetFavoritesForUser/' +
                  AppState.user.id.toString());

      final response = widget.isSubcategory
          ? await http.post(
              uri,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'articleID': 201,
                'customerID': AppState.user.id,
              }),
            )
          : await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['Data'];
        setState(() {
          products = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }

    if (!widget.isSubcategory) {
      try {
        final response = await http.get(Uri.parse(
            'https://mec3.cz/mec3mobile/ProductMobile/GetCategoriesForUser/' +
                AppState.user.id.toString()));

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['Data'];
          setState(() {
            categories = List<Map<String, dynamic>>.from(data);
          });
        } else {
          throw Exception('Failed to load categories');
        }
      } catch (error) {
        print('Error fetching categories: $error');
      }
    }
  }

  Future<void> _setFavoriteArticle(product) async {
    final url =
        'https://mec3.cz/mec3mobile/ProductMobile/SetFavouriteArticleMobile';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'articleID': product["ID"],
        'customerID': AppState.user.id,
      }),
    );

    if (response.statusCode == 200) {
      if (product["IsFavourite"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['Name']} - odebráno z oblíbených'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['Name']} - přidáno do oblíbených'),
          ),
        );
      }
      final responseData = json.decode(response.body);
      print('Set favorite success: $responseData');
      fetchData();
    } else {
      print('Failed to set favorite');
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

  List<Map<String, dynamic>> sortProducts(
      List<Map<String, dynamic>> productList, String criteria) {
    productList.sort((a, b) {
      if (criteria == 'Název') {
        return a['Name'].compareTo(b['Name']);
      } else if (criteria == 'Kód') {
        return a['PartNumber'].compareTo(b['PartNumber']);
      }
      return 0;
    });
    return productList;
  }

  void _showFilterSortPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterPanel(categories);
      },
    ).then((value) {
      setState(() {});
    });
  }

  Widget FilterPanel(List<Map<String, dynamic>> categories) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              onSubmitted: (value) {
                if (!searchHistory.contains(value)) {
                  setState(() {
                    searchHistory.add(value);
                  });
                }
                fetchData();
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                labelText: 'Hledat podle názvu',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchHistory[index]),
                  onTap: () {
                    selectHistoryItem(searchHistory[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> categoriesPopupMenuItems(
      List<Map<String, dynamic>> categories) {
    List<PopupMenuItem<String>> menuItems = [];

    for (var category in categories) {
      if (category['ParentID'] == null) {
        menuItems.add(
          PopupMenuItem<String>(
            value: category['Name'],
            child: Text(
              category['Name'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA3AE03),
              ),
            ),
          ),
        );

        if (category.containsKey('EshopSubCategories')) {
          for (var subcategory in category['EshopSubCategories']) {
            menuItems.add(
              PopupMenuItem<String>(
                value: subcategory['Name'],
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_forward),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          subcategory['Name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return menuItems;
  }

  void selectCategory(dynamic category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EshopPage(true)),
    );
  }

  void selectHistoryItem(String historyItem) {
    filterController.text = historyItem;
    fetchData();
    Navigator.pop(context);
  }

  Widget inStockSwitch() {
    return Row(
      children: [
        Text('Pouze skladem'),
        Switch(
          value: showInStockOnly,
          onChanged: (value) {
            setState(() {
              showInStockOnly = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seřadit podle:'),
            SizedBox(width: 10),
            DropdownButton<String>(
              value: selectedSortCriteria,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSortCriteria = newValue!;
                });
              },
              items: <String>['Název', 'Kód']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'Název' ? 'Název' : 'Kód'),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  void addToCart(Map<String, dynamic> product) {
    AppState.cartItems.add(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['Name']} - přidáno do košíku!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eshop'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showFilterSortPanel(context);
            },
          ),
          if (!widget.isSubcategory)
            PopupMenuButton<String>(
              onSelected: (value) {
                selectCategory(value);
              },
              itemBuilder: (BuildContext context) {
                return categoriesPopupMenuItems(categories);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: inStockSwitch(),
          ),
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

                        return EshopCard(
                          product: product,
                          onPdfPressed: () {
                            showPdf(product['Documents']);
                          },
                          onAddToCartPressed: () {
                            addToCart(product);
                          },
                          onFavoritePressed: () {
                            _setFavoriteArticle(product);
                          },
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
