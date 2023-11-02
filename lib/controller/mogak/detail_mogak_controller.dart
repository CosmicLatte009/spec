import 'package:get/get.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/detail_mogak.dart';

class DetailMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var likeController = Get.find<LikeController>();

  RxString mogakId = RxString('');
  final RxBool _isJoined = false.obs; //join 상태인지 여부
  final RxBool _isLiked = false.obs; //like 상태인지 여부
  final Rxn<DetailMogak> _detailMogak = Rxn<DetailMogak>();

  Rxn<DetailMogak> get detailMogak => _detailMogak;
  RxBool get isJoined => _isJoined;
  RxBool get isLiked => _isLiked;

  // @todo _detailMogak.appliedProfiles에 내 id가 있는지 여부 판별

  // * 동적으로 route를 생성하기 위해 생성자가 필요함.
  DetailMogakController(String id) {
    mogakId.value = id;
  }

  getDetailMogak() async {
    _detailMogak(
      await controller.getMogakById(id: mogakId.value),
    );
  }

  joinMogak() {
    controller.joinMogak(mogakId: mogakId.value);
  }

  cancelJoin() {
    controller.cancelJoin(mogakId: mogakId.value);
  }

  like() {
    likeController.likeUp(
      key: LikeType.mogakId,
      id: mogakId.value,
    );
    _isLiked(!_isLiked.value);
  }

  @override
  void onInit() {
    super.onInit();
    getDetailMogak();
  }
}
