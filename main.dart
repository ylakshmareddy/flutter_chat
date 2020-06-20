import 'package:flutter/material.dart';
import 'Chat.dart';
import 'UserDetails.dart';

void main()=>runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context)=> Home(),
    '/Chat':(context)=>Chat(),
    '/UserDetails':(context)=>UserDetails()
  },
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PiperChat"),
      ),
      body:Align(
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(60),
            child: Text("Welcome to Piper Chat!", style: TextStyle(
              fontSize: 23
            ),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/UserDetails', arguments: {'operation': "Login"});
                  },
                  child: Text("Login"),
                ),
                RaisedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/UserDetails', arguments: {'operation': "Register"});
                  },
                  child: Text("Register"),
                )
              ],
            )
          ],
        ),
      )

    );
  }
}
