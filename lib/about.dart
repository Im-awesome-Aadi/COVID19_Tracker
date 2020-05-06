import 'package:flutter/material.dart';
class abou extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABOUT THE APP'),
      ),
      body: Card(
        elevation: 5,
        child: Container(
          height: 250,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is App is aimed to provide the latest details and statistics across the Globe related to COVID-19.',style: TextStyle(letterSpacing: 1.5),),
              SizedBox(height: 20,),
              Text('There may be some bugs in this app as it is currently in Development phase. ',style: TextStyle(letterSpacing: 1.5),),
              SizedBox(height: 20,),
              Text('All the information is fetched from : ',style: TextStyle(letterSpacing: 1.5),),
              SizedBox(height: 10,),
              Text('https://api.covid19api.com ',style: TextStyle(letterSpacing: 1.5),)
            ],
          ),
        ),
      ),
    );
  }
}
