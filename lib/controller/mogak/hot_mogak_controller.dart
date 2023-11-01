import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/mogak.dart';

class HotMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  RxList<Mogak>? get hotMogak => controller.hotMogak;
}
