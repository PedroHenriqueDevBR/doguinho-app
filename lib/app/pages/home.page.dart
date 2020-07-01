import 'dart:convert' as convert;
import 'package:doguinho/app/pages/favorites.page.dart';
import 'package:doguinho/app/pages/imageview.page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doguinho/app/models/dog.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  ScrollController _controller;
  List<String> _images = [];
  bool _loading = false;

  _changeLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _getApiImages();
    }
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
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
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
                controller: _controller,
                padding: EdgeInsets.all(6),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageViewPage(
                            imageUrl: _images[index],
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      _images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          );
        },
      ),
    ];
  }
}
