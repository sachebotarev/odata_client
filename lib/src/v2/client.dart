import 'package:http/src/client.dart';
import '../client.dart';
import '../common/credentials.dart';

class ODataV2Client extends ODataClient {
  ODataV2Client(
    Uri serviceUrl,
    Client httpClient,
    Credentials credentials,
    String metadata,
  ) : super(
          serviceUrl,
          credentials,
          httpClient,
          metadata,
        );
}
