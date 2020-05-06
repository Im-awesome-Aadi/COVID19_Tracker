import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:corona/eachCountry.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:corona/mydraw.dart';
import 'package:corona/recent.dart';
import 'active.dart';
class Constants{
  static const String homes="Home";

  static const List<String> choices=<String>[
    homes
  ];
}
class Home extends StatefulWidget {
  Home({this.fullInfo,this.initList});
  String fullInfo;
  List initList;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List <charts.Series<LinearSales, String>> _sampledata;

  List countryName = [];
  List confirmed = [];
  List newconfirmed = [];
  List death = [];
  List newdeath = [];
  List recovered = [];
  List newrecovered = [];
  List sugggestion = [];
  List slug = [];

  List suggestionConfirmed = [];
  List suggestionNewConfirmed = [];
  List suggestionRecovered = [];
  List suggestionNewRecovered = [];
  List suggestionDeath = [];
  List suggestionNewDeath = [];
  List suggestedSlug = [];
  List  neww=[];
  int gnc;
  int gnd;
  int gnr;
  int gtc;
  int gtd;
  int gtr;
  String time;
  var sat = TextStyle(fontWeight: FontWeight.normal, color: Colors.blue);

  _generate(data) {
    List <LinearSales> datas = [
    ];
    gnc = jsonDecode(data)["Global"]["NewConfirmed"];
    gnd = jsonDecode(data)["Global"]["NewDeaths"];
    gnr = jsonDecode(data)["Global"]["NewRecovered"];
    gtc = jsonDecode(data)["Global"]["TotalConfirmed"];
    gtd = jsonDecode(data)["Global"]["TotalDeaths"];
    gtr = jsonDecode(data)["Global"]["TotalRecovered"];
//print(gtc);
    int abc = gtc - gtr - gtd;
    datas.add(LinearSales('Active', double.parse((abc*100/gtc).toStringAsFixed(2)), Colors.green));
    datas.add(LinearSales('Recovered',double.parse((gtr*100/gtc).toStringAsFixed(2)), Colors.blue));
    datas.add(LinearSales('Deaths', double.parse((gtd*100/gtc).toStringAsFixed(2)), Colors.red));
//datas.add(LinearSales(3, 25));

    _sampledata.add(
      charts.Series(
        data: datas,
        id: 'Sales',
        colorFn: (LinearSales sales, _) =>
            charts.ColorUtil.fromDartColor(sales.c),
        labelAccessorFn: (LinearSales sales, _) => '${sales.sales}',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      ),
    );
  }

  void initState() {
    super.initState();

    neww=widget.initList;
    print(neww);
    print(neww.runtimeType);
    _sampledata = List <charts.Series<LinearSales, String>>();
    _generate(widget.fullInfo);
    method(widget.fullInfo);




  }


  @override

  void method(data) {
    List a = jsonDecode(data)["Countries"];
    time=jsonDecode(data)["Countries"][0]["Date"];
    time=time.substring(0,10);
    String f='';
    f=f+time.substring(8,10)+'-'+time.substring(5,7)+'-'+time.substring(0,4);
    time=f;
    for (int i = 0; i < a.length; i++) {
      if (jsonDecode(data)["Countries"][i]["TotalDeaths"] != 0 &&
          jsonDecode(data)["Countries"][i]["TotalConfirmed"] != 0 &&
          jsonDecode(data)["Countries"][i]["TotalRecovered"] != 0) {
        countryName.add(jsonDecode(data)["Countries"][i]["Country"]);
        confirmed.add(jsonDecode(data)["Countries"][i]["TotalConfirmed"]);
        newconfirmed.add(jsonDecode(data)["Countries"][i]["NewConfirmed"]);
        death.add(jsonDecode(data)["Countries"][i]["TotalDeaths"]);
        newdeath.add(jsonDecode(data)["Countries"][i]["NewDeaths"]);
        recovered.add(jsonDecode(data)["Countries"][i]["TotalRecovered"]);
        newrecovered.add(jsonDecode(data)["Countries"][i]["NewRecovered"]);
        slug.add(jsonDecode(data)["Countries"][i]["Slug"]);
      }
    }
  }


  int s=0;

  @override
  Widget build(BuildContext context) {

    //  _read();

    //print(sugggestion.length);
    List tempConfirmed = [];
    List tempNewConfirmed = [];
    List tempDeath = [];
    List tempNewDeath = [];
    List tempRecovered = [];
    List tempNewRecovered = [];
    List tempSlug = [];
    Future<bool> _onBackPressed() {
      return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(

                title: Text("Do you really want to exit the App?",
                  style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),),
                actions: <Widget>[
                  FlatButton(
                      child: Text('No', style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                      onPressed: () => Navigator.pop(context, false)

                  ),
                  FlatButton(
                      child: Text('Yes', style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                      onPressed: () => Navigator.pop(context, true)

                  ),
                ],
              )
      );
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: draw(),
          appBar: AppBar(
            bottom: TabBar(

              tabs: <Widget>[
                Tab(text: 'HOME',),
                Tab(text: 'COUNTRY'),
                Tab(text: 'RECENT'),
                Tab(text:'MOST ACTIVE')

              ],
              isScrollable: true,
            ),
            title: Center(child: Text('TRACKER')),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Text('WORLD WIDE STATS', style: TextStyle(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            fontSize: 25),),
                        Container(
                          height: 10,
                          margin: EdgeInsets.all(2),
                          width: double.infinity,
                          child: Text('Last Updated : ${time}',style: TextStyle(fontSize: 8,fontStyle: FontStyle.italic),textAlign: TextAlign.right,),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 190,
                          child: new charts.PieChart(_sampledata,
                            animate: true,


                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification: charts
                                    .OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: new EdgeInsets.only(
                                    right: 4, bottom: 4),
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.black,
                                  fontFamily: 'Georgia',
                                  fontSize: 15,

                                ),
                              )
                            ],
                            defaultRenderer: new charts.ArcRendererConfig(
                                arcWidth: 60,
                                arcRendererDecorators: [

                                  new charts.ArcLabelDecorator(

                                    labelPosition: charts.ArcLabelPosition
                                        .outside,
                                  )
                                ]
                            ),
                          ),
                        ),
                        Container(
                          height: 130,
                          margin: EdgeInsets.all(8),
                          child: Wrap(
                            runSpacing: 10,
                            children: <Widget>[
                              Column(

                                children: <Widget>[
                                  Text('Total Cases', style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),),
                                  Text(converting(gtc)),
                                  Text('+ ${converting(gnc)}'),

                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                children: <Widget>[
                                  Text('Total Deaths', style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                                  Text(converting(gtd)),
                                  Text('+ ${converting(gnd)}'),

                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                children: <Widget>[
                                  Text('Total Recovered', style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                                  Text(converting(gtr)),
                                  Text('+ ${converting(gnr)}'),

                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: <Widget>[
                                  Text('Active Cases', style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                                  Text(converting(gtc - gtd - gtr))
                                ],
                              )
                            ],
                          ),
                        ),


                      ],
                    ),

                  ),
                  Card(elevation: 5,
                    child:Container(
                      height : 40,
                          color:Colors.blue,
                          child:Center(child: Text('Your BookMarked Countries',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),),)
                  )
                    ,),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 350),

                    child: Card(
                      child: Scrollbar(
                        child: ListView.builder(

                              shrinkWrap: true,
                              itemCount: neww.length,
                              itemBuilder: (context,index){
                                if(neww.isEmpty){
                                  return Container(

                                    child:Center(child: Text('Add'),)
                                  );
                                }
                                else{

                                  return
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) =>
                                                  countrywise(
                                                    slugName: slug[countryName.indexOf(neww[index])],
                                                    name: neww[index],
                                                    cases: confirmed[countryName.indexOf(neww[index])],
                                                    death: death[countryName.indexOf(neww[index])],
                                                    recovered: recovered[countryName.indexOf(neww[index])],
                                                    newcase: newconfirmed[countryName.indexOf(neww[index])],
                                                    newdeath:newdeath[countryName.indexOf(neww[index])],
                                                    newrecovered: newrecovered[countryName.indexOf(neww[index])],
                                                    date: time,
                                                  ))
                                          );
                                        },
                                        child: Card(
                                          elevation: 3,
                                            color: Colors.grey[100],
                                            child: ListTile(

                                              title: Center(
                                                child: Text(neww[index].toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: 1.5),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              subtitle:
                                              Wrap(
                                                children: <Widget>[


                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: RichText(text: TextSpan(
                                                        text: 'Total Cases : ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: converting(confirmed[countryName.indexOf(neww[index])]),
                                                              style: sat)
                                                        ]
                                                    )),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: RichText(text: TextSpan(
                                                        text: 'Total Deaths : ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: converting(death[countryName.indexOf(neww[index])]),
                                                            style: sat,),

                                                        ]
                                                    )),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: RichText(text: TextSpan(
                                                        text: 'Total Recovered : ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: converting(recovered[countryName.indexOf(neww[index])]),
                                                              style: sat)
                                                        ]
                                                    )),
                                                  )

                                                ],
                                              ),


                                            ),

                                        )
                                    );
                                }
                              },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(child: Text('Tap Bookmark icon to Add Countries',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey),)),
                  ),
                  SizedBox(height: 100,)

                ],
              ),
              Wrap(
                children: <Widget>[
                  Container(
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Search By Country Name'
                          ),
                          onChanged: (String) {
                            setState(() {
                              sugggestion = countryName.where((u) =>
                                  u.toLowerCase().startsWith(String.toLowerCase()))
                                  .toList();

                              for (int j = 0; j < sugggestion.length; j++) {
                                tempConfirmed.add(
                                    confirmed[countryName.indexOf(sugggestion[j])]);
                                tempNewConfirmed.add(newconfirmed[countryName.indexOf(
                                    sugggestion[j])]);
                                tempDeath.add(
                                    death[countryName.indexOf(sugggestion[j])]);
                                tempNewDeath.add(
                                    newdeath[countryName.indexOf(sugggestion[j])]);
                                tempRecovered.add(
                                    recovered[countryName.indexOf(sugggestion[j])]);
                                tempNewRecovered.add(newrecovered[countryName.indexOf(
                                    sugggestion[j])]);
                                tempNewRecovered.add(newrecovered[countryName.indexOf(
                                    sugggestion[j])]);
                                tempSlug.add(slug[countryName.indexOf(sugggestion[j])]);
                              }
                              suggestionConfirmed = tempConfirmed;
                              suggestionNewConfirmed = tempNewConfirmed;
                              suggestionRecovered = tempRecovered;
                              suggestionNewRecovered = tempNewRecovered;
                              suggestionDeath = tempDeath;
                              suggestionNewDeath = tempNewDeath;
                              suggestedSlug = tempSlug;
                            });
                          },

                        ),

                        Container(
                          height: 30,
                          width: double.infinity,
                          child: Center(
                            child: Card(
                              child: Text('Last Updated : ${time}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 500),
                      child: Scrollbar(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sugggestion.length == 0 ? countryName
                                .length : sugggestion.length,
                            itemBuilder: (context, index) {
                              return
                                FlatButton(

                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>
                                              countrywise(
                                                slugName: sugggestion.length == 0
                                                    ? slug[index]
                                                    : suggestedSlug[index],
                                                name: sugggestion.length == 0
                                                    ? countryName[index]
                                                    : sugggestion[index],
                                                cases: sugggestion.length == 0
                                                    ? confirmed[index]
                                                    : suggestionConfirmed[index],
                                                death: sugggestion.length == 0
                                                    ? death[index]
                                                    : suggestionDeath[index],
                                                recovered: sugggestion.length == 0
                                                    ? recovered[index]
                                                    : suggestionRecovered[index],
                                                newcase: sugggestion.length == 0
                                                    ? newconfirmed[index]
                                                    : suggestionNewConfirmed[index],
                                                newdeath: sugggestion.length == 0
                                                    ? newdeath[index]
                                                    : suggestionNewDeath[index],
                                                newrecovered: sugggestion
                                                    .length == 0
                                                    ? newrecovered[index]
                                                    : suggestionNewRecovered[index],
                                                date: time,

                                              ))
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,

                                      color: Colors.grey[100],
                                        child: ListTile(
                                          trailing: IconButton(
                                            icon:  FutureBuilder(
                                              future: _check(sugggestion.length == 0
                                                  ? slug[index]
                                                  : suggestedSlug[index]),
                                              builder: ( context,snapshot ){
                                                if(snapshot.hasData){
                                                  if(snapshot.data==true)
                                                  {
                                                    return  Icon(Icons.bookmark,color: Colors.blue,);
                                                  }
                                                  if(snapshot.data==false){
                                                    return  Icon(Icons.bookmark_border,color: Colors.blue,);
                                                  }
                                                }
                                                else{
                                                  return Icon(Icons.bookmark_border,color: Colors.blue,);
                                                }
                                              },
                                            ) ,
                                            iconSize: 32,
                                            onPressed: () {
                                              _save(sugggestion.length == 0
                                                  ? slug[index]
                                                  : suggestedSlug[index],
                                                  sugggestion.length == 0
                                                      ? countryName[index]
                                                      : sugggestion[index]);
                                            },
                                            //tooltip: 'Add to Home',


                                          ),

                                          title: Center(
                                            child: Text(sugggestion.length == 0
                                                ? countryName[index].toUpperCase()
                                                :
                                            sugggestion[index].toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          subtitle:
                                          Wrap(
                                            children: <Widget>[


                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: RichText(text: TextSpan(
                                                    text: 'Total Cases : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: converting(sugggestion
                                                              .length == 0
                                                              ? confirmed[index]
                                                              : suggestionConfirmed[index]),
                                                          style: sat)
                                                    ]
                                                )),
                                              ),

                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: RichText(text: TextSpan(
                                                    text: 'Total Deaths : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: converting(sugggestion
                                                            .length == 0
                                                            ? death[index]
                                                            : suggestionDeath[index]),
                                                        style: sat,),

                                                    ]
                                                )),
                                              ),

                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: RichText(text: TextSpan(
                                                    text: 'Total Recovered : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: converting(sugggestion
                                                              .length == 0
                                                              ? recovered[index]
                                                              : suggestionRecovered[index]),
                                                          style: sat)
                                                    ]
                                                )),
                                              )

                                            ],
                                          ),


                                        )
                                    )
                                );
                            }
                        ),
                      )

                  )
                ],
              ),
              recent(name: countryName,confirmed: confirmed,recovered: recovered,death: death, newrecovered: newrecovered,newdeath: newdeath,newconfirmed: newconfirmed,slug: slug,date: time,),
              active(name: countryName,confirmed: confirmed,recovered: recovered,death: death, newrecovered: newrecovered,newdeath: newdeath,newconfirmed: newconfirmed,slug: slug,date: time,),

            ],
          ),
        ),
      ),
    );
  }

/*_deck(x) async{
    await _check(x);
}*/


   Future<bool> _check(check) async{
    final prefs = await SharedPreferences.getInstance();
    final prefKeys = await prefs.getKeys();
    int inde=0;
    for(String i in prefKeys){
      if(i==check){
        inde=1;
      //  return Icon(Icons.bookmark_border);
        return true;
      }
    }
    if(inde==0){
     // return Icon(Icons.bookmark);
      return false;
    }
  }


  _save(k, v) async {
    final prefs = await SharedPreferences.getInstance();
    final prefKeys = prefs.getKeys();
    String i;
    int inde = 0;
    if (prefKeys.isNotEmpty) {
      for (i in prefKeys) {
        // this is another function expects to find key given as parameter
        //_drawerItem(prefKeys.elementAt(i).toString());
        if(i==k){
          inde=1;
          print("Removed");
          prefs.remove(k);
          setState(() {

          });
          _read();
          break;
        }
        // expected output should come below

      }
      if(inde==0)
      {
        print("Sdded");
        prefs.setString(k, v);
        setState(() {

        });
        _read();
      }
    }
    else{
      prefs.setString(k, v);
      setState(() {

      });
      _read();
    }

  }

  _read() async {
    print("Reading oyur file");
    final prefs = await SharedPreferences.getInstance();
    final prefKeys = await prefs.getKeys();
    print(prefKeys);

    neww=[];
    if(prefKeys.isEmpty){
      print("u r empty");
    }
    if (prefKeys.isNotEmpty){
      print("not empty");
      for(String i in prefKeys){
        final value = await prefs.getString(i);
        neww.add(value);
      }
    }


  }

}
  // print('saved $value');




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
