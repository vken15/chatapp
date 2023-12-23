import 'package:chatapp/src/presentations/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchScreenController());
  }
}
