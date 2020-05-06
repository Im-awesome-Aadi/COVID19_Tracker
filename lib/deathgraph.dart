import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'time.dart';

class deathgraph extends StatefulWidget {
  deathgraph({this.liveData,this.cases,this.deaths,this.recover});
  final liveData;
  final cases;
  final deaths;
  final recover;
  @override
  _deathgraphState createState() => _deathgraphState();
}

class _deathgraphState extends State<deathgraph> {
  var a1;
  var a2;
  var a3;
  List <charts.Series<TimeSeriesSales,DateTime>> _seriesdata;
  List <charts.Series<TimeSeriesSales,DateTime>> _confirmeddata;
  List <charts.Series<TimeSeriesSales,DateTime>> _deathdata;
 List abbb;
  static String pointerValue;
 int active;
  int deathss;
  int re;
 var fy;
 var fm;
 var fd;

  _generatedata(){
    List<TimeSeriesSales> datas = [];
    List<TimeSeriesSales> cdatas = [];
    List<TimeSeriesSales> ddatas = [];


    int n=0;
    abbb=jsonDecode(widget.liveData);
     active= abbb[abbb.length-1]["Active"];


    timestamp as = timestamp(inout: abbb[0]["Date"]);
     as.convert();
     fy=int.parse(as.y);
    fm=int.parse(as.m);
    fd=int.parse(as.d);
    a1= abbb[0]["Confirmed"];
    a2=abbb[0]["Recovered"];
    a3=abbb[0]["Deaths"];
    active=widget.cases-widget.deaths-widget.recover;
    for(int j=0;j<abbb.length-1;j++){

      timestamp t =timestamp(inout: abbb[j]["Date"]);
      t.convert();
      n++;
      var y1 =int.parse(t.y);
      var m1 =int.parse(t.m);
      var d1 =int.parse(t.d);
      if(j==abbb.length-2){
        datas.add( TimeSeriesSales( DateTime(y1, m1, d1), a1),);
        cdatas.add( TimeSeriesSales( DateTime(y1, m1, d1), a2),);
        ddatas.add( TimeSeriesSales( DateTime(y1, m1, d1), a3),);
        break;
      }
      if(abbb[j]["Date"]==abbb[j+1]["Date"]){
          a1=a1+abbb[j+1]["Confirmed"];
          a2=a2+abbb[j+1]["Recovered"];
          a3=a3+abbb[j+1]["Deaths"];

      }
      else{
        datas.add( TimeSeriesSales( DateTime(y1, m1, d1), a1),);
        cdatas.add( TimeSeriesSales( DateTime(y1, m1, d1), a2),);
        ddatas.add( TimeSeriesSales( DateTime(y1, m1, d1), a3),);
        a1=abbb[j+1]["Confirmed"];
        a2=abbb[j+1]["Recovered"];
        a3=abbb[j+1]["Deaths"];

      }

    }

    _seriesdata.add(
      charts.Series(
        data: datas,
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
      ),
    );

    _confirmeddata.add(
      charts.Series(
        data: cdatas,
        id: 'ales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
      ),
    );
    _deathdata.add(
      charts.Series(
        data: ddatas,
        id: 'ales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
      ),
    );

  }
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesdata= List <charts.Series<TimeSeriesSales,DateTime>>();
    _confirmeddata= List <charts.Series<TimeSeriesSales,DateTime>>();
    _deathdata= List <charts.Series<TimeSeriesSales,DateTime>>();
    _generatedata();

  }
  DateTime _time;
  Map<String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }


  DateTime _ctime;
  Map<String, num> _cmeasures;
  _onSelectionConfirmed(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _ctime = time;
      _cmeasures = measures;
    });
  }


  DateTime _detime;
  Map<String, num> _demeasures;
  _onSelectionDeath(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _detime = time;
      _demeasures = measures;
    });
  }



  @override
  Widget build(BuildContext context) {
    print(a1);
    print(a2);
    print(a3);
 final conf=<Widget>[
   a1!=0?Container(
     height: 400,
     child: charts.TimeSeriesChart(
       _seriesdata,
       animate: true,
       animationDuration: Duration( milliseconds: 500),
       behaviors: [
         new charts.ChartTitle('Time',
           behaviorPosition: charts.BehaviorPosition.bottom,
         ),
         new charts.ChartTitle('Total Confirmed Cases',
           behaviorPosition: charts.BehaviorPosition.start,
         )
       ],
       selectionModels: [
         new charts.SelectionModelConfig(
           type: charts.SelectionModelType.info,

           changedListener: _onSelectionChanged,
         )
       ],
     ),
   ):Container(height: 400,width:double.infinity,child: Center(child: Card(child: Text('No Data Available'),)),),
 ];
 final recd=<Widget>[
   a2!=0?Container(
     height: 400,
     child:charts.TimeSeriesChart(
       _confirmeddata,
       animate: true,
       animationDuration: Duration( milliseconds: 500),


       behaviors: [


         new charts.ChartTitle('Time',
           behaviorPosition: charts.BehaviorPosition.bottom,
         ),
         new charts.ChartTitle('Total Recovered Cases',
           behaviorPosition: charts.BehaviorPosition.start,
         )
       ],
       selectionModels: [
         new charts.SelectionModelConfig(
           type: charts.SelectionModelType.info,

           changedListener: _onSelectionConfirmed,
         )
       ],
     ),
   ):Container(height: 400,width:double.infinity,child: Center(child: Card(child: Text('No Data Available'),)),),
 ];
 final deat=<Widget>[
   a3!=0?Container(
     height: 400,
     child:charts.TimeSeriesChart(
       _deathdata,
       animate: true,
       animationDuration: Duration( milliseconds: 500),


       behaviors: [


         new charts.ChartTitle('Time',
           behaviorPosition: charts.BehaviorPosition.bottom,
         ),
         new charts.ChartTitle('Total Deaths',
           behaviorPosition: charts.BehaviorPosition.start,
         )
       ],
       selectionModels: [
         new charts.SelectionModelConfig(
           type: charts.SelectionModelType.info,

           changedListener: _onSelectionDeath,
         )
       ],
     ),
   ):Container(height: 400,width:double.infinity,child: Center(child: Card(child: Text('No Data Available'),)),),
 ];
    final children=<Widget>[
     Column(
       children: <Widget>[
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
    child: Center(child: Text('Total Active', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),))),
    SizedBox(
    height: 10,
    ),
    RichText(
    text: TextSpan(
    text: converting(active ),
    style:TextStyle(fontSize: 24,color: Colors.blue,fontWeight: FontWeight.w900),

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
    child: Center(child: Text('First Case', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),))),
    SizedBox(
    height: 10,
    ),
    RichText(
    text: TextSpan(
    text: '${fd}-${fm}-${fy} ',
    style:TextStyle(fontSize: 24,color: Colors.blue,fontWeight: FontWeight.w900),

    ),
    ),
    ],
    ),
    ),
    ),
    ),

    ],
    ),

       ],
     ),
      SizedBox(height: 30,),

    Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: conf
      ),
    ),
      SizedBox(height: 30,),

      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(

          children: recd,
        ),
      ),
      SizedBox(height: 30,),

      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(

          children: deat,
        ),
      ),
      SizedBox(height: 100,)


    ];

    if (_time != null) {
      var t = _time.toString();
      t = t.substring(0, 10);
      String f = '';
      f = f + t.substring(8, 10) + '-' + t.substring(5, 7) + '-' +
          t.substring(0, 4);

      conf.insert(0, new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text('Date : ${f}',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16))));
    }
      _measures?.forEach((String series, num value) {
        conf.insert(0, Container(child: new Text('Case: ${value}',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),)));
      });


    if (_ctime != null) {
      var t=_ctime.toString();
      t=t.substring(0,10);
      String f='';
      f=f+t.substring(8,10)+'-'+t.substring(5,7)+'-'+t.substring(0,4);

      recd.insert(0,new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text('Date : ${f}',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16))));
    }
    _cmeasures?.forEach((String series, num value) {
      recd.insert(0, new Text('Recovered : ${value}',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 14),));
    });

 if (_detime != null) {
   var t=_detime.toString();
   t=t.substring(0,10);
   String f='';
   f=f+t.substring(8,10)+'-'+t.substring(5,7)+'-'+t.substring(0,4);

   deat.insert(0,new Padding(
       padding: new EdgeInsets.only(top: 5.0),
       child: new Text('Date : ${f}',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16))));
 }
 _demeasures?.forEach((String series, num value) {
   deat.insert(0, new Text('Deaths: ${value}',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 14),));
 });

    return new Column(children: children);



  }
}


class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
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