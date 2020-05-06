import 'package:flutter/material.dart';
import 'eachCountry.dart';
class recent extends StatefulWidget {

  recent({this.name,this.confirmed,this.recovered,this.death,this.newconfirmed,this.newdeath,this.slug,this.newrecovered,this.date});
  List name;
  List confirmed;
  List recovered;
  List death;
  List newconfirmed;
  List newdeath;
  List slug;
  List newrecovered;
  var date;
  @override

  _recentState createState() => _recentState();
}

class _recentState extends State<recent> {
  List tn=[];
  List ts=[];
  List tc=[];
  List tnc=[];
  List tr=[];
  List tnr=[];
  List td=[];
  List tnd=[];

  @override
  void initState(){
    super.initState();
    method(widget.name,widget.confirmed,widget.recovered,widget.death,widget.newconfirmed,widget.newdeath,widget.newrecovered,widget.slug);
  }
void method(n,c,r,d,nc,nd,nr,slug){
  //  print(nc);
  var abc = List.generate(n.length, (i) => List(8), growable: false);
  for(int i=0;i<n.length;i++){
    abc[i][0]=n[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][1]=c[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][2]=r[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][3]=d[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][4]=nc[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][5]=nr[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][6]=nd[i];
  }
  for(int i=0;i<n.length;i++){
    abc[i][7]=slug[i];
  }
  int i;
  var fir;
  var sec;
  var thi;
  var fou;
  var fiv;
  var six;
  var sev;
  var eig;
  var j;
  for ( i = 1; i < n.length; i++) {

    fir=abc[i][0];
    sec=abc[i][1];
    thi=abc[i][2];
    fou=abc[i][3];
    fiv = abc[i][4];
    six=abc[i][5];
    sev=abc[i][6];
    eig=abc[i][7];
    j = i - 1;
    while (j >= 0 && abc[j][4] < fiv) {
      abc[j + 1][0] = abc[j][0];
      abc[j + 1][1] = abc[j][1];
      abc[j + 1][2] = abc[j][2];
      abc[j + 1][3] = abc[j][3];
      abc[j + 1][4] = abc[j][4];
      abc[j + 1][5] = abc[j][5];
      abc[j + 1][6] = abc[j][6];
      abc[j + 1][7] = abc[j][7];
      j = j - 1;
    }
    abc[j + 1][4] = fiv;
    abc[j + 1][1] = sec;
    abc[j + 1][2] = thi;
    abc[j + 1][3] = fou;
    abc[j + 1][5] = six;
    abc[j + 1][6] = sev;
    abc[j + 1][7] = eig;
    abc[j + 1][0] = fir;
  }
 for ( i=0;i<10;i++){
   tn.add(abc[i][0]);
   tc.add(abc[i][1]);
   tr.add(abc[i][2]);
   td.add(abc[i][3]);
   tnc.add(abc[i][4]);
   tnr.add(abc[i][5]);
   tnd.add(abc[i][6]);
   ts.add(abc[i][7]);
 }

}
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(

          child: Column(
            children: <Widget>[
              Card( margin:EdgeInsets.all(3) ,
                  child: Container(padding:EdgeInsets.all(5),child: Text('Top 10 countries with most corona cases in last 24 hours',style: TextStyle(color: Colors.blue,fontStyle: FontStyle.italic,letterSpacing: 1.5,fontSize: 14),),))
            ],
          ),


        ),
        Container(
          height: 30,
          width: double.infinity,
          child: Center(
            child: Card(
              child: Text('Last Updated : ${widget.date}'),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 450),
          child: Scrollbar(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: tn.length,

                itemBuilder: (context,index){
                  return FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              countrywise(
                                slugName: ts[index],
                                name: tn[index],
                                cases: tc[index],
                                death: td[index],
                                recovered: tr[index],
                                newcase: tnc[index],
                                newdeath: tnd[index],
                                newrecovered: tnr[index],
                                date: widget.date,

                              ))
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Card(
                            elevation: 5,

                            color: Colors.grey[100],
                            child: ListTile(

                              title: Center(
                                child: Text(tn[index].toUpperCase(),style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                                  overflow: TextOverflow.ellipsis,),
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
                                              text: '${tc[index]}',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.blue))
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
                                              text: '${td[index]}',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.blue)),

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
                                              text: '${tr[index]}',style: TextStyle(fontWeight: FontWeight.normal, color: Colors.blue))
                                        ]
                                    )),
                                  )

                                ],
                              ),


                            )
                        ),
                        SizedBox(height: 20,)
                      ],
                    )
                  );
                }

            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
