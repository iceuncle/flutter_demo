import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';

///图片控件开发
class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片控件开发'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.network(
                'http://www.devio.org/img/avatar.png',
              ),
              Image(
                height: 26,
                width: 26,
                image: AssetImage('images/avatar.png'),
              ),
              Image.asset(
                'images/avatar.png',
                width: 26,
                height: 26,
              ),
              FutureBuilder(
                  //加载相对路径的本地图片
                  future: _getLocalFile("Download/Stack.png"),
                  builder:
                      (BuildContext context, AsyncSnapshot<File> snapshot) {
                    return snapshot.data != null
                        ? Image.file(snapshot.data)
                        : Image.asset('images/avatar.png');
                  }),
              Stack(
                // 借助FadeInImage，它能够从内存，本地资源中加载placeholder
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: 'http://www.devio.org/img/avatar.png',
                    ),
                  ),
                ],
              ),
              FadeInImage.assetNetwork(
                //加载本地资源图片作为placeholder
                placeholder: 'assets/loading.gif',
                image: 'http://www.devio.org/img/avatar.png',
              ),
              Center(
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  imageUrl: 'https://picsum.photos/250?image=9',
                ),
              ),
              new Icon(Icons.android, size: 100.0),
              new Icon(
                new IconData(0xf5566, fontFamily: 'devio'),
                size: 100.0,
                color: Colors.blueAccent,
              )
            ],
          )
        ],
      ),
    );
  }

  //获取SDCard的路径：
  Future<File> _getLocalFile(String filename) async {
    String dir = (await getExternalStorageDirectory()).path;
    File f = new File('$dir/$filename');
    return f;
  }
}
