import 'package:chatapp/src/presentations/phonebook/controllers/phonebook_controller.dart';
import 'package:get/get.dart';

class PhoneBookBindings extends Bindings {
  @override
  void dependencies() {
    Get.put((PhoneBookController()));
  }
}
