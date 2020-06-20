import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Map data = {};
  Timer timer1, timer2;
  TextEditingController _textEditingController = new TextEditingController();
  String _activeUsers = "";
  String _messages = "";
  void _sendMessage() async
  {
        await get("http://165.22.14.77:8080/LakshmaReddy/chat/SendMessage.jsp?UserName="+data['username']+"&Message="+_textEditingController.text);
        _textEditingController.clear();
  }
  void _signout() async
  {
    await get("http://165.22.14.77:8080/LakshmaReddy/chat/SignOut.jsp?UserName="+data['username']);
    Fluttertoast.showToast(
      msg: "Logged out Successfully.",
      toastLength: Toast.LENGTH_LONG,
    );
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
  void _getActiveUsers() async
  {
    Response response = await get("http://165.22.14.77:8080/LakshmaReddy/chat/ActiveUsers.jsp?UserName="+data['username']);
    print(response.body);
    if(this.mounted)
      {
        setState(() {
          _activeUsers = response.body.replaceAll("<br>", "");
        });
      }
  }
  void _getMessages() async
  {
    Response response = await get("http://165.22.14.77:8080/LakshmaReddy/chat/ShowMessages.jsp?UserName="+data['username']);
    print(response.body);
    if(this.mounted){
      setState(() {
        _messages = response.body;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    timer1 = Timer.periodic(Duration(seconds: 4), (Timer t) => _getMessages());
    timer2 = Timer.periodic(Duration(seconds: 4), (Timer t) => _getActiveUsers());
  }
   @override
  void dispose() {
    timer1?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      data = ModalRoute.of(context).settings.arguments;
      print("In build method...");
    return Scaffold(
      appBar: AppBar(
        title: Text("PiperChat"),
      ),
      body: SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Text("Active Users",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 300,
                height: 150,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(_activeUsers))),
            Text("Messages",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 200,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(_messages))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Message Here',
                    ),
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: RaisedButton(
                    onPressed: (){
                      _sendMessage();
                    },
                    child: Text("Send"),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: (){
                _signout();
              },
              child: Text("SignOut"),
            )
          ],
        ),
      ),
    ));
  }
}
