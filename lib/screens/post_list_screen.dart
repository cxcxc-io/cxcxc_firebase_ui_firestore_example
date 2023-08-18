import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/post_card_row.dart';
import '../models/author.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../services/author_service.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: PostService.getPostsSnapshot(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var postDoc = snapshot.data!.docs[index];
              Map<String, dynamic> postData =
                  postDoc.data() as Map<String, dynamic>;
              Post post = PostService.transMapToPost(postData);

              return FutureBuilder<Author?>(
                future: AuthorService.getAuthorByAuthorId(post.authorId),
                builder: (context, authorSnapshot) {
                  if (!authorSnapshot.hasData) {
                    return const CircularProgressIndicator(); // 或其他提示用戶正在加載的小部件
                  }
                  return PostCard(post: post, author: authorSnapshot.data!);
                },
              );
            },
          );
        },
      ),
    );
  }
}
