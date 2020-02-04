import 'dart:io';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:odata_client/src/v2/client.dart';
import 'package:meta/meta.dart';

import 'common/credentials.dart';

enum ODataVerion { V2, V4 }

abstract class ODataClient {
  final Client _client;
  final Credentials _credentials;
  final Uri _serviceUrl;
  final String _metadata;
  final _log = Logger();

  ODataClient(
    Uri serviceUrl,
    Credentials credentials,
    Client client,
    String metadata,
  )   : this._serviceUrl = serviceUrl,
        this._credentials = credentials,
        this._client = client,
        this._metadata = metadata;

  static Future<ODataClient> newInstance({
    @required String serviceUrl,
    Client client,
    Credentials credentials,
    String metadata,
    String fileNameMetadata,
    ODataVerion version = ODataVerion.V2,
  }) async {
    Client _client = client ?? Client();
    Credentials _credentials = credentials ?? NoCredentials();
    Uri _serviceUrl = Uri.parse(serviceUrl);
    String _metadata = metadata ??
        await _fetchMetadataFromFile(fileNameMetadata) ??
        await _fetchMetadataFromUrl(_serviceUrl, _client, _credentials);

    switch (version) {
      case ODataVerion.V2:
        return ODataV2Client(
          _serviceUrl,
          _client,
          _credentials,
          _metadata,
        );
      default:
        throw Exception("Version $version not support");
    }
  }

  static Future<String> _fetchMetadataFromFile(
    String fileName,
  ) async {
    if (fileName == null || fileName.isEmpty) {
      return null;
    }
    return await File(fileName).readAsString();
  }

  static Future<String> _fetchMetadataFromUrl(
    Uri serviceUrl,
    Client client,
    Credentials credentials,
  ) async {
    if (serviceUrl == null) {
      return null;
    }
    Uri metadataUri = serviceUrl.replace(path: serviceUrl.path + "/\$metadata");
    Response response = await client.get(metadataUri, headers: credentials.getHeaders());
    return response.body;
  }
}
