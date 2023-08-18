import 'dart:convert';
import 'package:uuid/uuid.dart';

class Post {
  String postId;
  String content;
  String authorId;

  /// 建構子
  Post(this.postId, this.content, this.authorId);

  // 我們覆蓋了 `==` 運算符以實現兩個 Post 對象的內容比較
  // 而不是基於它們在內存中的位置
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postId == postId &&
        other.content == content &&
        other.authorId == authorId;
  }

  // 我們同樣覆蓋了 hashCode 方法，以確保有相同屬性值的 Post 對象有相同的 hashCode
  @override
  int get hashCode {
    return postId.hashCode ^ content.hashCode ^ authorId.hashCode;
  }

  /// 序列化，將物件直接轉換為 json string
  String toJsonString() => jsonEncode({
        "postId": postId,
        "content": content,
        "authorId": authorId,
      });

  /// 讀取 json map 並轉換成物件的建構子
  factory Post.fromJson(Map<String, dynamic> jsonMap) {
    var uuid = const Uuid();

    // 提取內容值
    String postId = jsonMap["postId"] ?? uuid.v4();
    String content = jsonMap["content"];
    String authorId = jsonMap["authorId"];

    // 回傳物件
    return Post(postId, content, authorId);
  }
}
