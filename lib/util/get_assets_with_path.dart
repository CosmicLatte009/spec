import 'dart:convert';

import 'package:flutter/material.dart';

Future<List<String>> getAssetsWithPath(context, String path) async {
  final manifestContent =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  final assetList =
      manifestMap.keys.where((String key) => key.startsWith(path)).toList();
  return assetList;
}
