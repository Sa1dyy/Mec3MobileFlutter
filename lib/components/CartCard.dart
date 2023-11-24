import 'package:flutter/material.dart';

class cartCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onPdfPressed;
  final VoidCallback? onAddToCartPressed;
  final VoidCallback? onRemoveFromCartPressed;

  cartCard({
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
