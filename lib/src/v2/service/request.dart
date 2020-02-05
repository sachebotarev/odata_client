import 'package:odata_client/src/service/service.dart';

enum HttpRequestType {
  GET,
  POST,
  PUT,
  DELETE
}

class  ODataHttpRequest {


  String getPath(){

  }

  Map<String, String> getHeaders(){

  }

  String getMethod(){

  }

  Map<String, String> getQueryParams(){

  }

  String getBody(){

  }

  execute() {

  }
}

class EntityGetRequest extends ODataHttpRequest{
   
}