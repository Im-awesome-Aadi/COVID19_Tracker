import 'package:flutter/material.dart';

class dev extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DEVELOPER'),
      ),
      body: Card(
        elevation: 5,
        child: Container(
          height: 250,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello to All Users. This is Aditya Maheshwari,a prefinal year student of Computer Science Engineering and sole developer of this App',style: TextStyle(letterSpacing: 1.5),),
              SizedBox(height: 20,),
              Text('I had made this App to pratice my App Development Skills',style: TextStyle(letterSpacing: 1.5),),
              SizedBox(height: 20,),
              Text('Stay Safe, Stay Isolated',style: TextStyle(letterSpacing: 1.5),),

            ],
          ),
        ),
      ),
    );
  }
}
