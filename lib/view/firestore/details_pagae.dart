import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.url, required this.name});
  final String url, name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('details page'.toUpperCase()),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 34),
          Text('Name :' + name)
        ],
      ),
    );
  }
}
