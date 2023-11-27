import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EshopCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onPdfPressed;
  final VoidCallback? onAddToCartPressed;
  final VoidCallback? onFavoritePressed; // Přidáno

  EshopCard({
    required this.product,
    this.onPdfPressed,
    this.onAddToCartPressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? documents = product['Documents'];
    final bool hasValidPdfUrl = documents != null &&
        documents.isNotEmpty &&
        documents[0]['Url'] != 'https://mec3.cz/getmedia//Document';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (product['IsFavourite'])
                  InkWell(
                    onTap: onFavoritePressed, // Opraveno
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Icon(Icons.favorite, color: Color(0xFFA3AE03)),
                          SizedBox(height: 5),
                          Text('Oblíbené',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                if (!product['IsFavourite'])
                  InkWell(
                    onTap: onFavoritePressed, // Opraveno
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Icon(Icons.favorite_border,
                              color: Color(0xFFA3AE03)), // Přidáno
                          SizedBox(height: 5),
                          Text('Přidat k oblíbeným',
                              style: TextStyle(color: Colors.black)), // Přidáno
                        ],
                      ),
                    ),
                  ),
                SizedBox(width: 20),
                if (onAddToCartPressed != null)
                  ElevatedButton.icon(
                    onPressed: onAddToCartPressed,
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Přidat do košíku'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(product['Name'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Part Number: ${product['PartNumber']}'),
            Text('Measure Unit: ${product['MeasureUnit']}'),
            Text('Min Quantity: ${product['MinQuantity']}'),
            SizedBox(height: 8),
            Row(
              children: [
                if (onPdfPressed != null && hasValidPdfUrl)
                  IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: onPdfPressed,
                  ),
              ],
            ),
            if (!product['IsOnStock'])
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 5),
                  Text('Není skladem', style: TextStyle(color: Colors.red)),
                ],
              ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
