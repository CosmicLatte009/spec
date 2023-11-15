import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart' as dioPackage;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/etc/upload_controller.dart';
import 'package:spec/util/avatar_color.dart';
import 'package:spec/view/widget/alert/360_width_avatar/avatar_with_one_button.dart';
import 'package:spec/view/widget/card/avatar_card.dart';

class AvatarController extends GetxController {
  var authController = Get.find<AuthController>();
  var uploadController = Get.find<UploadController>();
  ScreenshotController screenshotController = ScreenshotController();

  String get imageUrl => uploadController.imageUrl.value;

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
  }

  bool getIsSelected(String? imagePath) {
    return selectedItems.containsValue(imagePath);
  }

  // create
  void captureAndUpload() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/${DateTime.now()}.png').create();
        await imagePath.writeAsBytes(image);

        if (await imagePath.exists()) {
          final dioPackage.MultipartFile multipartFile =
              await dioPackage.MultipartFile.fromFile(imagePath.path,
                  filename: '${DateTime.now()}.png');

          dioPackage.FormData formData = dioPackage.FormData.fromMap({
            'file': multipartFile,
          });

          try {
            await uploadController.uploadAsset(formData);
            Get.dialog(
              const AvatarWithOneButton(
                //@todo 생성된 아바타 띄우기
                mainMessage: '아바타 수정이 완료되었습니다.',
                buttonTitle: '확인하기',
              ),
            ).then((_) => Get.back());
          } catch (e) {
            print('capture and upload: $e');
          }
        }
      }
    });
    // final capturedImage = await screenshotController.capture();

    // if (capturedImage != null) {
    // 캡쳐는 제대로 되고있음.
    // Get.dialog(Container(
    //   child: Image.memory(capturedImage),
    // ));
    // 1. MultipartFile로 변환
    // dioPackage.MultipartFile multipartFile =
    //     dioPackage.MultipartFile.fromBytes(
    //   capturedImage,
    //   filename: 'screenshot.png',
    // );
    // 2. formdata를 생성
    // dioPackage.FormData formData = dioPackage.FormData.fromMap({
    //   'file': multipartFile,
    // });
    // try {
    //   var res = await uploadController.uploadAsset(formData);
    //   print('성공: ${res.data}');
    // } catch (e) {
    //   print(
    //       '업로드 실패: $e'); //NoSuchMethodError: The getter 'data' was called on null.
    // }
    // }
    // print('캡쳐끝');
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
      'item': null,
    };
    hairColor.value = AvatarColor.color1;
  }

  @override
  void onInit() async {
    super.onInit();
    var dio = dioPackage.Dio();

    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;

    String? authToken = await authController.getToken();

    dio.interceptors.add(dioPackage.LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
  }
}
