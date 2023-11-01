import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/detail_mogak.dart';

class DetailMogakController extends GetxController {
  var controller = Get.find<MogakController>();

  RxString mogakId = RxString('');
  final Rxn<DetailMogak> _detailMogak = Rxn();

  Rxn<DetailMogak>? get detailMogak => _detailMogak;

  // 동적으로 route를 생성하기 위해 생성자가 필요함.
  DetailMogakController(String id) {
    mogakId.value = id;
  }

  getDetailMogak() async {
    _detailMogak.value = await controller.getMogakById(id: mogakId.value);
  }

  @override
  void onInit() {
    super.onInit();
    getDetailMogak();
  }
}
