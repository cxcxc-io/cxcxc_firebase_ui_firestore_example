import 'dart:convert';
import 'package:uuid/uuid.dart';

class Author {
  String authorId;
  String authorName;

  /// 建構子
  Author(this.authorId, this.authorName);

  // 我們覆蓋了 `==` 運算符以實現兩個 Author 對象的內容比較
  // 而不是基於它們在內存中的位置
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Author &&
        other.authorId == authorId &&
        other.authorName == authorName;
  }

  // 我們同樣覆蓋了 hashCode 方法，以確保有相同屬性值的 Author 對象有相同的 hashCode
  @override
  int get hashCode {
    return authorId.hashCode ^ authorName.hashCode;
  }

  /// 序列化，將物件直接轉換為 json string
  String toJsonString() => jsonEncode({
        "authorId": authorId,
        "authorName": authorName,
      });

  /// 讀取 json map 並轉換成物件的建構子
  factory Author.fromJson(Map<String, dynamic> jsonMap) {
    var uuid = const Uuid();

    // 提取內容值
    String authorId = jsonMap["authorId"] ?? uuid.v4();
    String authorName = jsonMap["authorName"];

    // 回傳物件
    return Author(authorId, authorName);
  }
}
