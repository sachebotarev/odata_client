import '../lib/src/common/credentials.dart';
import '../lib/odata_client.dart';

main() async {
  ODataClient clinet = await ODataClient.newInstance(
    serviceUrl:
        'http://srvsap83.rainvest.local:8000/sap/opu/odata/sap/ZMOB004_CPI_SRV/',
    credentials: HTTPBasicCredentials(
      'SCHEBOTAREV',
      '2wsx@WSX',
    ),
  );
}
