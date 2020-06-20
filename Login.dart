import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _textEditingControllerU = new TextEditingController();
  TextEditingController _textEditingControllerP = new TextEditingController();
  void login() async
  {
    Response response = await get("http://165.22.14.77:8080/LakshmaReddy/chat/signin.jsp?UserName="+_textEditingControllerU.text+"&Password="+_textEditingControllerP.text);
    if(response.body.contains("success"))
    {
      Fluttertoast.showToast(
        msg: "Login Successful.",
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pushNamed(context, '/Chat', arguments: {'username':_textEditingControllerU.text});
    }
    else
      {
        Fluttertoast.showToast(
          msg: "Invalid Credentials.",
          toastLength: Toast.LENGTH_LONG,
        );
        Navigator.pop(context);
      }
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
                login();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
