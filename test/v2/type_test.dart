import 'dart:io';

import 'package:test/test.dart';
import 'package:xml/xml.dart' as xml;

main() {
  String medatata;

  setUp(() {
    medatata = File('test/fixture/metadata.xml').readAsStringSync();
  });

  test('build Schema', () {
    xml.XmlDocument xmlDoc = xml.parse(medatata);
    xmlDoc.descendants
        .where(
            (node) => node is xml.XmlAttribute && (node.name.prefix == 'xmlns' || node.name.local == 'xmlns'))
        .forEach((node) {
      print((node as  xml.XmlAttribute).value);
       print((node as  xml.XmlAttribute).name.local);
        print((node as  xml.XmlAttribute).name.prefix);
    });
  });
}
