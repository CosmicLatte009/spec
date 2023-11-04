import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/mogak.dart';

class AllMogakController extends GetxController {
  var controller = Get.find<MogakController>();

  RxList<Mogak>? get allMogak => controller.allMogak;
  mogakState(val) => controller.getMogakState(val);
  isUped(id) => controller.isUped(id);
  toggleLike(id) => controller.toggleLike(id);
}
