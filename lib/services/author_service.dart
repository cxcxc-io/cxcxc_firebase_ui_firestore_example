import '../daos/author_dao.dart';
import '../models/author.dart';

class AuthorService {
  /// 增加一個新的 Author
  static Future<bool> addAuthor(Author author) async {
    return FirestoreAuthorDao.addAuthor(author);
  }

  /// 根據 authorId 查詢一個 Author
  static Future<Author?> getAuthorByAuthorId(String authorId) async {
    return FirestoreAuthorDao.getAuthorByAuthorId(authorId);
  }
}
