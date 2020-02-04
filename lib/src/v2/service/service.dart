import 'dart:io';
import 'package:odata_client/src/model/schema.dart';

class Service {
   final Schema schema;
   final HttpClient client;

  Service(this.schema, this.client);

}


class EntityContainer {
  final Service _service;
  final Map<String, String> _entitySets;

  EntityContainer(this._service, this._entitySets);

  String operator [](String entityName){
    return _entitySets[entityName];
  }
}


class EntitySetProxy {

}