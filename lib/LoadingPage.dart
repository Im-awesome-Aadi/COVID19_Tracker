import 'package:flutter/material.dart';
import 'package:corona/network.dart';
import 'package:corona/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List  aneww=[];
  var sat = TextStyle(fontWeight: FontWeight.normal, color: Colors.blue);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method();
  }
  void method() async{
    summary su = summary();
    await su.getSummary();
      List a =jsonDecode(su.covidData)["Countries"];
    final prefs = await SharedPreferences.getInstance();
    final prefKeys = await prefs.getKeys();
  //  print(prefKeys);


    if(prefKeys.isEmpty){
      print("u r empty");
    }
    if (prefKeys.isNotEmpty){
      for(String i in prefKeys){
        final value = await prefs.getString(i);
          for(int j=0;j<a.length;j++){
          if(jsonDecode(su.covidData)["Countries"][j]["Country"]==value){

            aneww.add(
                value
                );

            break;

          }
        }

      }
      //print(aneww[0]);
      print(aneww.runtimeType);
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home(fullInfo: su.covidData,initList: aneww,))
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCircle(
              size: 75,
              color: Colors.blue,
            ),
            SizedBox(height: 30,),
            Text('Requires Internet Connection.'),
        SizedBox(height: 10,),
        Text('This might take some time.')

          ],
        ),
      ),
    );
  }
}
