import 'package:get/get.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/controller/mogak/me/joined_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/profile.dart';

class DetailMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var profileController = Get.find<ProfileController>();
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
  final Rxn<Profile> _userInfo = Rxn<Profile>();

  Rxn<DetailMogak> get detailMogak => _detailMogak;
  bool get isJoined => _isJoined.value;
  bool get isLiked => _isLiked.value;
  Rxn<Profile> get userInfo => _userInfo;

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
    _userInfo.value =
        await profileController.getUserById(_detailMogak.value!.authorId);

    _isLiked.value = controller.isUped(mogakId.value);
    await joinedController.getJoinedMogak();

    _isJoined.value =
        joinedController.joinedMogaks.any((mogak) => mogak.id == mogakId.value);

    ever(_isJoined, (_) async {
      await getDetailMogak();
      await joinedController.getJoinedMogak();
    });

    ever(_isLiked, (_) async {
      await getDetailMogak();
    });
  }
}
