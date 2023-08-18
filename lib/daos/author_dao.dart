import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/author.dart';
import '../utils/logger.dart';

/// 貼文作者與 Firestore 溝通的物件
///
/// * 物件
///   * _db - 透過 Firestore&Flutter 套件的物件, 可以使用接通資料庫的邏輯方法
///   * String authorsCollection - 溝通的資料集
/// * 方法
///   * void setFirestoreClient(FirebaseFirestore firebaseFirestore) - 設置 Firestore 客戶端,  unit 測試需要
///   * Future<bool> addAuthor(Author author) - 添加用戶
///   * Future<Author?> getAuthor(String authorId) - 取得用戶資料
class FirestoreAuthorDao {
  /// 建立客戶端物件
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  // final _db = FirebaseFirestore.instance;

  /// 重新設定 Firestore 客戶端
  static void setFirestoreClient(FirebaseFirestore firebaseFirestore) {
    _db = firebaseFirestore;
  }

  static String authorsCollection =
      'authors'; // 這個是您在Firestore中存儲authors的collection名稱

  /// 增加一個新的 Author
  static Future<bool> addAuthor(Author author) async {
    logger.d('FirestoreAuthorDao addAuthor: ${author.toJsonString()}');

    try {
      await _db.collection(authorsCollection).doc(author.authorId).set({
        'authorId': author.authorId,
        'authorName': author.authorName,
      });
      return true;
    } catch (e) {
      logger.e("Error adding author: $e");
      throw e;
    }
  }

  /// 根據 authorId 查詢一個 Author
  static Future<Author?> getAuthorByAuthorId(String authorId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection(authorsCollection).doc(authorId).get();
      if (doc.exists) {
        return Author.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      logger.e("Error getting author: $e");
      throw e;
    }
    return null;
  }
}
