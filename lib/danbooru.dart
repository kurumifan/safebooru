import 'dart:async';

import 'package:flutter/material.dart';

import 'search_page.dart';
import 'KesShouBann.dart';

import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

///Danbooru
final String danbooruxml = "https://danbooru.donmai.us/posts.xml";
List<String> danboorupreviw;
final String safebooruxml = "https://safebooru.donmai.us/posts.xml";
List<String> safeboorupreview;


class Danbooru extends StatefulWidget {
  @override
  _DanbooruState createState() => new _DanbooruState();
}

class _DanbooruState extends State<Danbooru> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsafebooru();
  }

  Future<String> getsafebooru() async {
    http.Response response3 = await http.get(
      Uri.encodeFull(safebooruxml),
    );
    setState(() {
      var keys3 = xml.parse(response3.body).findAllElements('preview-file-url');
      safeboorupreview = keys3.map((node) {
        return node.text;
      }).toList();
    });
    return 'Success!!';
  }

  int setcount = 3;

_launchURL() async {
  const url = 'https://safebooru.donmai.us/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: new AppBar(
          ///column按钮
          leading: IconButton(
            icon: Icon(Icons.view_column),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return new Container(
                        height: 60.0,
                        child: new Row(children: <Widget>[
                          Expanded(
                            child: new IconButton(
                              icon: Icon(Icons.view_week),
                              onPressed: () {
                                setState(() {
                                  setcount < 10 ? setcount++ : setcount;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: new IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: () {
                                setState(() {
                                  setcount > 2 ? setcount-- : setcount;
                                });
                              },
                            ),
                          ),
                        ]),
                      );
                  });
            },
          ),
          title: GestureDetector(child: new Text('safebooru.donmai.us'),onLongPress: _launchURL),
          actions: <Widget>[
            ///搜索按钮
            new IconButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SearchPage()));
              },
              icon: Icon(Icons.search),
            ),
            ///血小板 聊天按钮
            IconButton(
              onPressed: (){
                 Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new KesShouBann()));
              },
              icon: Icon(Icons.extension),
            ),
          ],
        ),
        ///GridView
        body: safeboorupreview==null?new Center(
          child: CircularProgressIndicator(),
        ):new GridView.count(
            crossAxisCount: setcount,
            children: new List<Widget>.generate(
                safeboorupreview.length,
                (a) => CachedNetworkImage(imageUrl: safeboorupreview[a],))
                  ));
  }
}
