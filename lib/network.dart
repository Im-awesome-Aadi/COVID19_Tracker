import 'package:http/http.dart' as http;

class summary{
  String covidData;
  Future<void> getSummary() async{
    final response = await http.get(
        'https://api.covid19api.com/summary');
    if (response.statusCode == 200) {
      String datas = response.body;
      covidData=datas;
    }

    else {
      print('Not found');
    }
  }
}