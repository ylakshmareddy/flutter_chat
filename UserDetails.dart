import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Map data = {};
  TextEditingController _textEditingControllerU = new TextEditingController();
  TextEditingController _textEditingControllerP = new TextEditingController();
  String message;
  void login() async
  {
    Response response = await get("http://165.22.14.77:8080/LakshmaReddy/chat/signin.jsp?UserName="+_textEditingControllerU.text+"&Password="+_textEditingControllerP.text);
    if(response.body.contains("success"))
    {
    setState(() {
      message = "Login Successful.";
    });
      Navigator.pushNamed(context, '/Chat', arguments: {'username':_textEditingControllerU.text});
    }
    else
    {
      setState(() {
        message = "Invalid Credentials";
      });
      Navigator.pop(context);
    }
    showToast();
  }
  void showToast()
  {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
  void register() async
  {
    print(_textEditingControllerU.text);
    print(_textEditingControllerP.text);
    Response response = await get(
        "http://165.22.14.77:8080/LakshmaReddy/chat/signup.jsp?UserName=" +
            _textEditingControllerU.text + "&Password=" +
            _textEditingControllerP.text);
    print(response.body);
    if(response.body.contains("Success"))
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
    showToast();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data['operation']);
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
                if(data['operation'] == "Login")
                  {
                    login();
                  }
                else
                  {
                    register();
                  }
              },
              child: Text(data['operation']),
            )
          ],
        ),
      ),
    );
  }
}
