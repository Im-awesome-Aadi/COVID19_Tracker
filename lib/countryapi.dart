import 'package:http/http.dart' as http;

class datacountry{
  String slugName;
  datacountry({this.slugName});
  String abc;
  Future<void> getSummary() async{
    print("Tapped slugname is : ${slugName}");

    final response = await http.get(
        'https://api.covid19api.com/dayone/country/${slugName}');
    if (response.statusCode == 200) {
      String datas = response.body;
      abc=datas;
      print(datas);
      return datas;
    }

    else {
      print('Not found');
    }
  }
}