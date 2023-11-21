// news_detail_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsDetailPage extends StatelessWidget {
  final int newsId;

  NewsDetailPage(this.newsId);

  Future<Map<String, dynamic>> fetchNewsDetail(int newsId) async {
    final response = await http.get(Uri.parse(
        'https://mec3.cz/mec3mobile/DocumentsMobile/GetNews/$newsId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['Data'];
    } else {
      throw Exception('Failed to load news details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchNewsDetail(newsId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading news details'),
            );
          } else {
            final newsDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    newsDetails['Image'],
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsDetails['Name'],
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          newsDetails['Perex'],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          newsDetails['Content'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
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
