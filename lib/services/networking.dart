import 'package:http/http.dart';
import 'dart:convert';

class networking {
  networking(this.url);
  String url;



  Future GetData() async{
    Response response = await get(url);
    if(response.statusCode == 200){
      var jBody = response.body;
      var decode = jsonDecode(jBody);
      return decode;
    }
    else{
      print(response.statusCode);
    }
  }

}