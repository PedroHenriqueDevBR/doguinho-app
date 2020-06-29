import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Cat api = https://api.thecatapi.com/v1/images/search?size=full

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doguinho'),),
      body: Container(
        color: Colors.blueGrey[900],
        child: GridView.builder(
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6,),
          itemBuilder: (context, index) => Image.network(
            'https://images.dog.ceo//breeds//mastiff-tibetan//n02108551_4790.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
