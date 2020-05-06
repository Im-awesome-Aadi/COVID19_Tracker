import 'package:flutter/material.dart';
import 'package:corona/deathgraph.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:flutter_spinkit/flutter_spinkit.dart';
class countrywise extends StatefulWidget {

    countrywise({this.name,this.cases,this.death,this.recovered,this.newcase,this.newdeath,this.newrecovered,this.slugName,this.date});
    final name;
    final cases;
    final death;
    final recovered;
    final newcase;
    final newdeath;
    final newrecovered;
    final slugName;
    final date;
  @override
  _countrywiseState createState() => _countrywiseState();
}

class _countrywiseState extends State<countrywise> {
  List <charts.Series<LinearSales,String>> _sampledata;
String dates;

  _generatedata(r,d,c){

    List<LinearSales>gdata=[];




    gdata.add(LinearSales('Active', double.parse(((c-d-r)*100/c).toStringAsFixed(2)), Colors.green));
    gdata.add(LinearSales('Recovered', double.parse((r*100/c).toStringAsFixed(2)), Colors.blue));
    gdata.add(LinearSales('Deaths', double.parse((d*100/c).toStringAsFixed(2)), Colors.red));


    _sampledata.add(
      charts.Series(
        data: gdata,
        id: 'Sales',
        colorFn: (LinearSales sales, _)=> charts.ColorUtil.fromDartColor(sales.c),
        labelAccessorFn: (LinearSales sales,_)=>'${sales.sales}',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      ),
    );


  }


  void initState(){
    super.initState();
    dates=widget.date;
    _sampledata= List <charts.Series<LinearSales,String>>();
    _generatedata(widget.recovered,widget.death,widget.cases);

  }

  Future<void> getSummary(BuildContext context) async{

    final response = await http.get(
        'https://api.covid19api.com/dayone/country/${widget.slugName}');
    if (response.statusCode == 200) {
      String datas = response.body;
      return datas;
    }

    else {
      print('Not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            height: 10,
            margin: EdgeInsets.all(5),
            width: double.infinity,
            child: Text('Last Updated : ${dates}',style: TextStyle(fontSize: 10,fontStyle: FontStyle.italic),textAlign: TextAlign.right,),
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:BorderRadius.all(
                        Radius.circular(5)
                      )
                    ),
                    width: double.infinity,
                   // color: Colors.black,
                      child: Center(child: Text('Total Recovered', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),))),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: converting(widget.recovered),
                      style:TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.w900),
                      children: <TextSpan>[
                        TextSpan(text: ' +${converting(widget.newrecovered)}', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15,fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
         Row(
           children: <Widget>[
             Expanded(
               flex: 1,
               child: Container(
                 height: 80,
                 width: double.infinity,
                 child: Card(
                   elevation: 10,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Container(
                           decoration: BoxDecoration(
                               color: Colors.black87,
                               borderRadius:BorderRadius.all(
                                   Radius.circular(5)
                               )
                           ),
                           width: double.infinity,
                           // color: Colors.black,
                           child: Center(child: Text('Total Deaths', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),))),
                       SizedBox(
                         height: 10,
                       ),
                       RichText(
                         text: TextSpan(
                           text: converting(widget.death),
                           style:TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.w900),
                           children: <TextSpan>[
                             TextSpan(text: ' +${converting(widget.newdeath)}', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15,fontStyle: FontStyle.italic)),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             //  SizedBox(height: 20,),
             Expanded(
               flex: 1,
               child: Container(
                 height: 80,
                 width: double.infinity,
                 child: Card(
                   elevation: 10,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Container(
                           decoration: BoxDecoration(
                               color: Colors.black87,
                               borderRadius:BorderRadius.all(
                                   Radius.circular(5)
                               )
                           ),
                           width: double.infinity,
                           // color: Colors.black,
                           child: Center(child: Text('Total Cases', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),))),
                       SizedBox(
                         height: 10,
                       ),
                       RichText(
                         text: TextSpan(
                           text: converting(widget.cases),
                           style:TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.w900),
                           children: <TextSpan>[
                             TextSpan(text: ' +${converting(widget.newcase)}', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15,fontStyle: FontStyle.italic)),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),

           ],
         ),
          Container(
            height: 250,
            child: new charts.PieChart(_sampledata,
              animate: true,


              behaviors: [
                new charts.DatumLegend(
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: new EdgeInsets.only(right: 4,bottom: 4),
                  entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                    fontFamily: 'Georgia',
                    fontSize: 15,

                  ),
                )
              ],
              defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60,
                  arcRendererDecorators: [

                    new charts.ArcLabelDecorator(

                      labelPosition: charts.ArcLabelPosition.outside,
                    )
                  ]
              ),
            ),
          ),
          FutureBuilder(
            future: getSummary(context),
            builder: (context,snapshot){
              if(snapshot.hasData){

                if(snapshot.data==[]){

                  return Container(
                    child: Center(
                      child: Card(
                        child: Text('This Country/Province does not have any data'),
                      ),
                    ),
                  );
                }
                    else
                      {
                        return deathgraph(liveData: snapshot.data,cases:widget.cases ,recover: widget.recovered,deaths: widget.death,);
                      }
              }

              else{
                return Column(
                  children: <Widget>[
                    SpinKitFadingCircle(
                      size: 50,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10,),
                    Text('Loading More Data...',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)
                  ],
                );
              }
            }
          )
        ],
      ),
    );
  }
}


class LinearSales {
  final String year;
  final double sales;
  final Color c;

  LinearSales(this.year, this.sales,this.c);
}
converting(int input){
  int a =input;
  String f='';
  int k=1;
  String ab=a.toString();
  String ac=ab.split('').reversed.join();
  ac.runes.forEach((int rune) {
    var character=new String.fromCharCode(rune);
    if(k!=4){
      f=f+character;
      k++;
    }
    else{
      f=f+','+character;
      k=2;
    }
    // print(f);
  });
  String abc=f.split('').reversed.join();
  return abc;
}