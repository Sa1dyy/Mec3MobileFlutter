import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mec3mobileflutter/config/AppState.dart';
import 'package:mec3mobileflutter/views/LandingPage.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CategoryDetailPage extends StatefulWidget {
  final int categoryId;

  CategoryDetailPage(this.categoryId);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late Future<Map<String, dynamic>> categoryDetail;
  TextEditingController filterController = TextEditingController();
  List<dynamic> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    categoryDetail = fetchCategoryDetail();
  }

  Future<Map<String, dynamic>> fetchCategoryDetail() async {
    final String apiUrl =
        'https://mec3.cz/mec3mobile/ProductMobile/GetCategoryDetail/${widget.categoryId}';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load category detail');
    }
  }

  void filterProducts(String searchText, List<dynamic> allProducts) {
    filteredProducts.clear();
    filteredProducts.addAll(allProducts.where((product) {
      return product['Name'].toLowerCase().contains(searchText.toLowerCase()) ||
          (product['Description'] != null &&
              product['Description']
                  .toLowerCase()
                  .contains(searchText.toLowerCase()));
    }));
  }

  bool isUserLogged() {
    return AppState.isLogged == true;
  }

  void showPdf(List<dynamic>? documents){
          if ( documents != null &&
                                      documents.isNotEmpty) {
                                    String pdfUrl = documents[0]['Url'];
                                    launch(pdfUrl);
                                  } else {
                                    print(
                                        'No documents available for this product.');
                                  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: categoryDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final categoryData = snapshot.data!['Data'];
            final List<dynamic> allProducts = categoryData['Products'];
            final String categoryTitle = categoryData['Name'];
            final String categoryImage = categoryData['Image'];
            final String categoryDescription = categoryData['Description'];

            filterProducts(filterController.text, allProducts);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Visibility(
                      visible: !isUserLogged(),
                      child: const Center(
                        child: Text(
                          'Nepřihlášený uživatel - nelze zobrazit specifikace produktů',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      categoryTitle,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (categoryImage != null)
                    Column(
                      children: [
                        Image.network(
                          categoryImage,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        if (categoryDescription != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              categoryDescription,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        if (allProducts.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: filterController,
                              onChanged: (value) {
                                setState(() {
                                  filterProducts(value, allProducts);
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Filtrovat produkty',
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (filteredProducts.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        final List<dynamic>? documents = product['Documents'];

                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(product['Name']),
                            subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product['Description']),
       Padding(
         padding: const EdgeInsets.only(top:8.0),
         child: Text(product['PartNumber'],
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
       ),
      ],
    ),
                            
                            trailing: Visibility(
                              visible: isUserLogged() &&
                                  documents != null &&
                                  documents.isNotEmpty,
                              child: IconButton(
                                icon: Icon(Icons.picture_as_pdf),
                                onPressed: () {
                                 showPdf(documents);
                                },
                              ),
                            ),
                           
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}


