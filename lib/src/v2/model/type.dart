import 'package:odata_client/src/v2/model/schema.dart';
import 'package:xml/xml.dart' as xml;

enum Kind { PRIMITIVE, COMPLEX }

class Identifier {}

class TraitsType {
  String toLiteral(dynamic value) => '$value';
  String toJson(dynamic value) => '$value';
  dynamic fromLiteral(String value) => value;
  dynamic fromJson(String value) => value;
}

class EdmPrefixedTypeTraits extends TraitsType {
  final String prefix;
  EdmPrefixedTypeTraits(this.prefix);

  @override
  String toLiteral(dynamic value) {
    return '$prefix\'${super.toLiteral(value)}\'';
  }

  @override
  dynamic fromLiteral(String value) {
    RegExp exp = new RegExp('\^$prefix\'(.*)\'\$');
    var match = exp.firstMatch('$value');
    if (match == null) {
      throw Exception(
          'Malformed value $value for primitive Edm type. Expected format is $prefix\'value\'');
    }
    return match.group(0);
  }
}

class EdmDateTimeTypeTraits extends EdmPrefixedTypeTraits {
  EdmDateTimeTypeTraits() : super('datetime');

  @override
  String toLiteral(dynamic value) {
    if (value is DateTime)
      return super.toLiteral(value.toIso8601String());
    else
      throw Exception(
          'Cannot convert value of type ${value.runtimeType} to literal. DateTime format is required.');
  }

  @override
  dynamic fromLiteral(String value) {
    return DateTime.parse(super.fromLiteral(value));
  }

  @override
  String toJson(dynamic value) {
    if (value is DateTime)
      return '/Date(${value.millisecondsSinceEpoch})/';
    else
      throw Exception(
          'Cannot convert value of type ${value.runtimeType} to literal. DateTime format is required.');
  }

  @override
  dynamic fromJson(String value) {
    final RegExp dateRegExp = RegExp(r"\/Date\((\d*)\)\/");
    final dateMills = dateRegExp.firstMatch(value)?.group(1);
    if (dateMills != null)
      return DateTime.fromMillisecondsSinceEpoch(int.parse((dateMills)));
  }
}

class EdmStringTypeTraits extends TraitsType {
  @override
  String toLiteral(value) {
    return '\'$value\'';
  }

  @override
  fromLiteral(String value) {
    return value.trim().replaceAll(RegExp('\^\'\|\'\$'), '');
  }

  @override
  fromJson(String value) {
    return value.trim().replaceAll(RegExp('\^\'\|\'\$'), '');
  }
}

class EdmBoolianTypeTraits extends TraitsType {
  @override
  String toLiteral(value) {
    return value ? 'true' : 'false';
  }

  @override
  fromLiteral(String value) {
    return 'true' == value;
  }

  @override
  fromJson(String value) {
    return value.trim().replaceAll(RegExp('\^\'\|\'\$'), '');
  }
}


class EdmIntTypeTraits extends TraitsType {
  @override
  String toLiteral(value) {
    return value ? 'true' : 'false';
  }

  @override
  fromLiteral(String value) {
    return 'true' == value;
  }

  @override
  fromJson(String value) {
    return value.trim().replaceAll(RegExp('\^\'\|\'\$'), '');
  }
}


class EdmLongTypeTraits extends TraitsType {
  @override
  String toLiteral(value) {
    return value ? 'true' : 'false';
  }

  @override
  fromLiteral(String value) {
    return 'true' == value;
  }

  @override
  fromJson(String value) {
    return value.trim().replaceAll(RegExp('\^\'\|\'\$'), '');
  }
}

class Type {
  Kind kind;
  bool isCollection;
  String initialValue;
  TraitsType traitsType;
}

class Collection extends Type {}

class StructType extends Type {}

class TypeInfo {
  final String namespace;
  final String name;
  final String isCollection;

  TypeInfo(this.namespace, this.name, this.isCollection);
}

class IdentifierInfo {
  final String namespace;
  final String name;

  IdentifierInfo(this.namespace, this.name);
}


class MetadataBuilder{
    final List<String> EDMX_WHITELIST = [
        'http://schemas.microsoft.com/ado/2007/06/edmx',
        'http://docs.oasis-open.org/odata/ns/edmx',
    ];

    final List<String> EDM_WHITELIST = [
        'http://schemas.microsoft.com/ado/2006/04/edm',
        'http://schemas.microsoft.com/ado/2007/05/edm',
        'http://schemas.microsoft.com/ado/2008/09/edm',
        'http://schemas.microsoft.com/ado/2009/11/edm',
        'http://docs.oasis-open.org/odata/ns/edm'
    ];

    final String metadata;

  MetadataBuilder(this.metadata);

  Schema build(){
    xml.XmlDocument xmlDoc  = xml.parse(this.metadata);
    var dataservices  = xmlDoc.descendants.where((node) => node is xml.XmlElement && node.name.local == 'DataServices');
    var schema  = xmlDoc.descendants.where((node) => node is xml.XmlElement && node.name.local == 'Schema');
  }
}