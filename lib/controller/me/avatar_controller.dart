import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/etc/upload_controller.dart';
import 'package:spec/util/avatar_color.dart';
import 'package:spec/view/widget/card/avatar_card.dart';

class AvatarController extends GetxController {
  Dio dio = Dio();
  var authController = Get.find<AuthController>();
  var uploadController = Get.find<UploadController>();
  ScreenshotController screenshotController = ScreenshotController();
  RxString imageUrl = ''.obs;
  Rx<Uint8List>? capturedImg;

  RxMap<String, String?> selectedItems = {
    'face': 'assets/avatar/Face/on_face_1.svg',
    'emotion': 'assets/avatar/Emotion/off_emotion_1.svg',
    'hair': 'assets/avatar/Hair/off_hair_1.svg',
    'item': null,
  }.obs;
  Rx<Color> hairColor = AvatarColor.color1.obs;

  void selectColor(Color color) {
    hairColor.value = color;
    hairColor.refresh();
  }

  void selectItems(AvatarAssetType type, String? imagePath) {
    selectedItems[type.name] = imagePath;
    selectedItems.refresh();
    print(selectedItems);
  }

  bool getIsSelected(String? imagePath) {
    return selectedItems.containsValue(imagePath);
  }

  // create
  void uploadAvatar() async {
    if (capturedImg?.value != null) {
      //@todo 서버에 업로드하기
      // uploadController.uploadAsset(capturedImg);
    }
  }

  // put
  // get
  // reset
  resetAvatar() {
    // @todo selectedItems를 순회하며 null이 되도록 하는 게 좋을 것 같음.
    selectedItems.value = {
      'face': 'assets/avatar/Face/on_face_1.svg',
      'emotion': 'assets/avatar/Emotion/off_emotion_1.svg',
      'hair': 'assets/avatar/Hair/off_hair_1.svg',
      'hairColor': null,
      'item': null,
    };
  }

  @override
  void onInit() async {
    super.onInit();
    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;
    String? authToken = await authController.getToken();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
  }
}
