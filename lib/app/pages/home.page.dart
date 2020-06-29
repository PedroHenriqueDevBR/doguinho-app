import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doguinho/app/models/dog.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _images = [];
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  bool _loading = false;

  _changeLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void getImages() {
    String json =
        '{"message": ["https://images.dog.ceo/breeds/schnauzer-miniature/n02097047_728.jpg", "https://images.dog.ceo/breeds/shiba/shiba-10.jpg", "https://images.dog.ceo/breeds/retriever-golden/n02099601_78.jpg"], "status": "success"}';
    final jsonMap = convert.jsonDecode(json);
    DogModel dogs = DogModel.fromJson(jsonMap);
    setState(() {
      _images = dogs.message;
    });
  }

  _getApiImages() async {
    _changeLoading();
    String url = 'https://dog.ceo/api/breeds/image/random/8';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      DogModel dogs = DogModel.fromJson(jsonResponse);
      setState(() {
        _images.addAll(dogs.message);
      });
    } else {
      _showMessage('Erro status: ${response.statusCode.toString()}');
    }
    _changeLoading();
  }

  _showMessage(String msg) {
    _globalKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    super.initState();
    _getApiImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Doguinho'),
        actions: appbarOptions(),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey[900],
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(6),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) => Image.network(
                    _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  child: Text('Mais imagens'),
                  onPressed: () {
                    _getApiImages();
                  },
                ),
              )
            ],
          )),
    );
  }

  List<Widget> appbarOptions() {
    return <Widget>[
          _loading == true
              ? ButtonBar(
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ],
                )
              : Container(),
        ];
  }
}
