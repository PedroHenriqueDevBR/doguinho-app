import 'package:flutter/material.dart';
import 'package:doguinho/app/pages/imageview.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> _images = [];
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  bool _loading = false;

  _changeLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void _getImages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> images = await prefs.getStringList('favorites');
    setState(() {
      _images = images;
    });
  }

  _showMessage(String msg) {
    _globalKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Favoritas'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[900],
        child: _images.length > 0
            ? Column(
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
                            ).then((value) {
                              _getImages();
                            });
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
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.favorite_border,
                      size: 50,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nenhuma imagem salva como favorita.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
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
          onPressed: null),
      IconButton(
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          onPressed: null),
    ];
  }
}
