import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


String _xuexiaoban; //血小板的话

class KesShouBann extends StatefulWidget {
  @override
  _KesShouBannState createState() => new _KesShouBannState();
}

class _KesShouBannState extends State<KesShouBann> {

 Future<http.Response> tulingbot(String inputstr) async {
    var url = "http://www.tuling123.com/openapi/api";
    var body = {"key": "3b0c6a53ff5a4bea8af677d22faa64f9", "info": "$inputstr"};

    
    var response = await http.post(Uri.encodeFull(url),
        body: body, headers: {'Accept': 'application/json'});

    var responseJson = json.decode(response.body);

    setState(() {
      _xuexiaoban = responseJson['text'];
      _abc.insert(0, _xuexiaoban);
      aa.insert(
        0,
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Container(
                  height: 50.0,
                  width: 50.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                      'img/xx.jpg')),
              Expanded(
                child: Text(
                  _abc[0],
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      );
     
    });
    return response;
  }

  var _textController = TextEditingController();

  String _xxb = 'img/UDLR.gif';

  List<String> _abc = [''];
  List<String> _cba = [''];

  List<Widget> aa = [
    Text(''),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: GestureDetector(child: Text('血小板'),
        onTap: (){
          showDialog(context: context,builder: (BuildContext context)=> Center(child: Image.asset('img/kesshoubann.jpg',fit: BoxFit.fitHeight,)));
        },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.healing),
            onPressed: (){
              showDialog(context: context,builder: (BuildContext context)=>Center(child: GestureDetector(
                child: Image.asset(_xxb,fit:BoxFit.fitHeight,),
                onLongPress: (){
                 _xxb = 'img/UDUD.gif';
                },
                onDoubleTap: (){
                   _xxb = 'img/UDLR.gif';                   
                },
              ),));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => aa[index],
              itemCount: aa.length,
            )),
            Divider(height: 3.0),
            Container(
              decoration: BoxDecoration(),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _textController,
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        setState(() {
                          _cba.insert(0, _textController.text);
                          
                          aa.insert(
                            0,
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _cba[0],
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Container(
                                      height: 50.0,
                                      width: 50.0,
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Image.asset('img/ghost.png'))
                                ],
                              ),
                            ),
                          );
                        });
                        tulingbot(_textController.text);
                        _textController.clear();
                      },
                    ),
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