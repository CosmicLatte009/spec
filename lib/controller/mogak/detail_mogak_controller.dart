import 'package:get/get.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/controller/mogak/me/joined_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/detail_mogak.dart';

class DetailMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var likeController = Get.find<LikeController>();
  var joinedController = Get.find<JoinedMogakController>();

  bool isUped(id) => controller.isUped(id);

  RxString mogakId = RxString('');
  // * 동적으로 route를 생성하기 위해 생성자 필요.
  DetailMogakController(String id) {
    mogakId.value = id;
  }

  final RxBool _isJoined = false.obs; //join 상태인지 여부
  final RxBool _isLiked = false.obs; //like 상태인지 여부
  final Rxn<DetailMogak> _detailMogak = Rxn<DetailMogak>();

  Rxn<DetailMogak> get detailMogak => _detailMogak;
  bool get isJoined => _isJoined.value;
  bool get isLiked => _isLiked.value;

  detailMogakState(val) {
    return controller.getMogakState(val);
  }

  getDetailMogak() async {
    _detailMogak(
      await controller.getMogakById(id: mogakId.value),
    );
  }

  joinMogak() async {
    await controller.joinMogak(mogakId: mogakId.value);
    _isJoined.value = true;
  }

  cancelJoin() async {
    await controller.cancelJoin(mogakId: mogakId.value);
    _isJoined.value = false;
  }

  toggleLike() {
    likeController.likeUp(
      key: LikeType.mogakId,
      id: mogakId.value,
    );
    _isLiked.toggle();
  }

  @override
  void onInit() async {
    super.onInit();
    await getDetailMogak();

    // 좋아요 상태를 초기화
    _isLiked.value = controller.isUped(mogakId.value);
    // JoinedMogakController의 getJoinedMogak 메소드가 완료되기를 기다립니다.
    await joinedController.getJoinedMogak();

    // getJoinedMogak 메소드가 완료된 후 가입된 모각코 상태를 초기화.
    _isJoined.value =
        joinedController.joinedMogaks.any((mogak) => mogak.id == mogakId.value);

    // 상태 감시를 위해 ever를 사용합니다.
    ever(_isJoined, (_) async {
      await getDetailMogak();
      await joinedController.getJoinedMogak();
    });

    ever(_isLiked, (_) async {
      await getDetailMogak();
    });
  }
}
