import 'package:get/get.dart';
import '../../model/talk.dart';
import 'all_talk_controller.dart';
import 'hot_talk_controller.dart';

class MainTalkController extends GetxController {
  final AllTalkController _allTalkController = Get.find<AllTalkController>();
  final HotTalkController _hotTalkController = Get.find<HotTalkController>();

  final RxBool mainTalksLoading = true.obs;

  RxList<Talk> get allTalks => _allTalkController.allTalks;
  RxList<Talk> get hotTalks => _hotTalkController.hotTalks;

  RxBool get allTalksLoading => _allTalkController.isLoading;
  RxBool get hotTalksLoading => _hotTalkController.isLoading;

  void getAllTalks() => _allTalkController.getAllTalks();
  void getHotTalks() => _hotTalkController.getHotTalks();

  void _updateLoadingState() {
    mainTalksLoading.value = allTalksLoading.value || hotTalksLoading.value;
  }

  void onInit() {
    super.onInit();

    ever(allTalksLoading, (_) => _updateLoadingState());
    ever(hotTalksLoading, (_) => _updateLoadingState());
  }
}
