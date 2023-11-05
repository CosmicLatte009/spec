import 'package:get/get.dart';

enum OrderByStatus { desc, asc }

class FilterController extends GetxController {
  final RxBool _isDesc = false.obs; //isDesc ? asc : desc

  String get orderBy =>
      _isDesc.value == true ? OrderByStatus.asc.name : OrderByStatus.desc.name;

  /// 날짜순
  Rx<bool> toggleOrderBy() {
    return _isDesc.toggle();
  }
}
