import 'dart:convert';

import 'package:doguinho/app/models/dog.model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _images = [];

  void getImages() {
    String json = '{"message": ["https://images.dog.ceo/breeds/schnauzer-miniature/n02097047_728.jpg", "https://images.dog.ceo/breeds/shiba/shiba-10.jpg", "https://images.dog.ceo/breeds/retriever-golden/n02099601_78.jpg"], "status": "success"}';
    final jsonMap = jsonDecode(json);
    DogModel dogs = DogModel.fromJson(jsonMap);
    setState(() {
      _images = dogs.message;
    });
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doguinho'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[900],
        child: GridView.builder(
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6,),
          itemBuilder: (context, index) => Image.network(
            _images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
