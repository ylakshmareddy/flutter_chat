import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _textEditingControllerU = new TextEditingController();
  TextEditingController _textEditingControllerP = new TextEditingController();
  String message;
  void register() async
  {
    Response response = await get(
        "http://165.22.14.77:8080/LakshmaReddy/chat/signup.jsp?UserName=" +
            _textEditingControllerU.text + "&Password=" +
            _textEditingControllerP.text);
    if(response.body.contains("success"))
    {
      setState(() {
        message = "Registration Successful.";
      });
    }
    else
    {
      setState(() {
        message = "Username Already exists.";
      });
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PiperChat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingControllerU,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter User Name Here',
                ),
                autofocus: true,
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingControllerP,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password Here',
                ),
                autofocus: true,
              ),
            ),
            RaisedButton(
              onPressed: () {
                register();
              },
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
