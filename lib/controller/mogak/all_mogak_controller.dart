import 'package:get/get.dart';
import 'package:spec/controller/etc/filter_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/etc/content_search_controller.dart';
import 'package:spec/model/mogak/mogak.dart';

class AllMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var filterController = Get.find<FilterController>();
  var searchController = Get.find<ContentSearchController>();

  RxList<Mogak>? get allMogak => controller.allMogak;
  mogakState(val) => controller.getMogakState(val);
  isUped(id) => controller.isUped(id);
  toggleLike(id) => controller.toggleLike(id);
}
