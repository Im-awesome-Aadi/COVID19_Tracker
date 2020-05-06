import 'package:flutter/material.dart';
import 'package:corona/countryapi.dart';
import 'eachCountry.dart';
class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.slugname});
  final slugname;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method();
  }
  void method() async{
    datacountry su = datacountry(slugName: widget.slugname);
    await su.getSummary();
    print(su.abc);
    /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home(fullInfo: su.covidData,))
    );*/

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}