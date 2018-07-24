import 'package:flutter/material.dart';
import 'tag_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _textController = TextEditingController();
  List<String> testlist=['abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见','abc','cba','123','321','你好','再见',];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ///搜索框
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Card(
                      child: TextField(
                        // focusNode: FocusNode(),
                        controller: _textController,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _textController.clear();
                    },
                  ),
                ],
              ),
            ),
            ///预设tags
            Flexible(
              child: ListView.builder(
              itemCount: testlist.length,
              itemBuilder: (BuildContext context,int index)=> Center(
                              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(testlist[index],style: TextStyle(fontSize: 25.0),),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
