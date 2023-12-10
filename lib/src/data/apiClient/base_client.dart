import 'package:chatapp/src/core/constants/app_url.dart';
import 'package:get/get.dart';

class BaseClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppEndpoint.PRODUCT_URL;
  }
}
