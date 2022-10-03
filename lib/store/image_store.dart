import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

part 'image_store.g.dart';

@collection
class Image {
  Image({required this.url, this.shorthand, this.tags = const []});

  Id id = Isar.autoIncrement;
  String url;

  String? shorthand;
  List<String> tags;

  @Index(caseSensitive: false)
  List<String> get indexing => [...tags, shorthand ?? ""];

  factory Image.fromJson(Map<String, dynamic> json) {
    var url = json['url'] as String;
    final shorthand = json['shorthand'] as String?;
    final tags =
        (json['tags'] as List<dynamic>).map((e) => e as String).toList();

    return Image(url: url, shorthand: shorthand, tags: tags);
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if (shorthand != null) 'shorthand': shorthand,
      'tags': tags
    };
  }
}

class ImagesProvider extends ChangeNotifier {
  ImagesProvider({required this.isar}) {
    isar.images.watchLazy(fireImmediately: true).listen((event) {
      notifyListeners();
    });
  }

  void addImage(Image image) async {
    await isar.writeTxn(() async {
      await isar.images.put(image);
    });
  }

  void addImages(List<Image> image) async {
    await isar.writeTxn(() async {
      await isar.images.putAll(image);
    });
  }

  Future<List<Image>> getImages() {
    return isar.images.where().findAll();
  }

  Future<List<Image>> queryImages(String query) async {
    return await isar.images
        .filter()
        .indexingElementStartsWith(query)
        .findAll();
  }

  void removeImage(Image image) async {
    await isar.writeTxn(() async {
      await isar.images.delete(image.id);
    });
  }

  late final Isar isar;
}
