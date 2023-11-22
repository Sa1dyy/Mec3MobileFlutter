import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EshopCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onPdfPressed;

  const EshopCard(this.product, {Key? key, this.onPdfPressed}) : super(key: key);

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
            if (product['IsFavourite'])
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('Oblíbené', style: TextStyle(color: Colors.blue)),
                ],
              ),
            SizedBox(height: 8), // Mezera mezi ikonami a nadpisem
            Text(product['Name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8), // Mezera mezi nadpisem a dalšími texty
            Text('Part Number: ${product['PartNumber']}'),
            Text('Measure Unit: ${product['MeasureUnit']}'),
            Text('Min Quantity: ${product['MinQuantity']}'),
            SizedBox(height: 8), // Mezera před informací o skladovosti
            if (!product['IsOnStock'])
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 5),
                  Text('Není skladem', style: TextStyle(color: Colors.red)),
                ],
              ),
            if (onPdfPressed != null && hasValidPdfUrl)
              IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: onPdfPressed,
              ),
          ],
        ),
      ),
    );
  }
}
