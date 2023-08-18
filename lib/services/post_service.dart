import 'package:cloud_firestore/cloud_firestore.dart';

import '../daos/post_dao.dart';
import '../models/post.dart';

class PostService {
  /// 增加一個新的 Post
  static Future<bool> addPost(Post post) async {
    return FirestorePostDao.addPost(post);
  }

  /// 根據 postId 查詢一個 Post
  static Future<Post?> getPost(String postId) async {
    return FirestorePostDao.getPost(postId);
  }

  /// 取得所有 Post 貼文
  static Future<List<Post?>> getAllPosts() async {
    return FirestorePostDao.getAllPosts();
  }

  /// 取得 post 資料集的所有資料的 snapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPostsSnapshot() {
    return FirestorePostDao.getPostsSnapshot();
  }

  /// 將 Map<String, dynamic> 轉換為 Post 物件
  static transMapToPost(Map<String, dynamic> postMap) {
    return Post.fromJson(postMap);
  }
}
