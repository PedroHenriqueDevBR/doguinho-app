import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewPage extends StatefulWidget {
  String imageUrl;
  ImageViewPage({this.imageUrl});
  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  bool favorite = false;

  _changeFavorite() {
    setState(() {
      favorite = !favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        bottomOpacity: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[900],
        child: Column(
          children: <Widget>[
            Expanded(
              child: PhotoView(
                backgroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0Xff141E30),
                      Color(0Xff243B55),
                    ],
                    ),
                  color: Colors.red,
                ),
                  imageProvider: NetworkImage(
                    widget.imageUrl,
                  ),
                ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blueGrey[800],
              child: Column(
                children: <Widget>[
                  Text(
                    'Link da imagem abaixo:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'https://images.dog.ceo/breeds/shiba/shiba-10.jpg',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            favorite == false ? Icons.favorite_border : Icons.favorite,
                            size: 30,
                            color: favorite == false ? Colors.white : Colors.red,
                          ),
                          onPressed: _changeFavorite),
                      IconButton(
                          icon: Icon(
                            Icons.file_download,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
