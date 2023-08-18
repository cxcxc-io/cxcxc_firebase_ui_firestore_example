import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart'; // 請確保這是正確的 Post model 路徑
import '../utils/logger.dart'; // 使用相同的 logger 工具

/// 貼文串接 Firestore 的 Dao 物件
///
/// * 物件
///   * _db - 透過 Firestore&Flutter 套件的物件, 可以使用接通資料庫的邏輯方法
/// * 方法
///   * void setFirestoreClient(FirebaseFirestore firebaseFirestore) - 設置 Firestore 客戶端,  unit 測試需要
///   * Future<bool> addPost(Post post) - 添加貼文
///   * Future<Post?> getPost(String postId) - 透過 postId 獲得貼文
///   * Future<List<Post>> getAllPosts() - 取得所有貼文資料
class FirestorePostDao {
  /// 建立客戶端物件
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  /// 重新設定 Firestore 客戶端
  static void setFirestoreClient(FirebaseFirestore firebaseFirestore) {
    _db = firebaseFirestore;
  }

  static String postsCollection =
      'posts'; // 這個是您在Firestore中存儲posts的collection名稱

  /// 增加一個新的 Post
  static Future<bool> addPost(Post post) async {
    logger.d('FirestorePostDao addPost: ${post.toJsonString()}');

    try {
      await _db.collection(postsCollection).doc(post.postId).set({
        'postId': post.postId,
        'content': post.content,
        'authorId': post.authorId,
      });
      return true;
    } catch (e) {
      logger.e("Error adding post: $e");
      throw e;
    }
  }

  /// 根據 postId 查詢一個 Post
  static Future<Post?> getPost(String postId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection(postsCollection).doc(postId).get();
      if (doc.exists) {
        return Post.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      logger.e("Error getting post: $e");
      throw e;
    }
    return null;
  }

  /// 取得所有 Post 貼文
  static Future<List<Post?>> getAllPosts() async {
    // 取得所有 Post
    // 用來放置取回的資料
    List<Post> posts = [];

    // 一一取回放進 list
    await _db.collection(postsCollection).get().then((event) {
      for (var doc in event.docs) {
        posts.add(Post.fromJson(doc.data()));
      }
    });
    return posts;
  }

  /// 取得 post 資料集的所有資料的 snapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPostsSnapshot() {
    return _db.collection('posts').snapshots();
  }
}
