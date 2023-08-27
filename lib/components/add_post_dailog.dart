import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post.dart';

import '../services/post_service.dart';
import '../utils/logger.dart';

void showAddPostDialog(BuildContext context) {
  TextEditingController textEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('請輸入貼文內容'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: "在此輸入貼文內容...",
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              textEditingController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('送出'),
            onPressed: () async {
              // Handle the post content here.
              // Example: print the content
              logger.d(textEditingController.text); // 內文
              await PostService.addPost(Post("1", textEditingController.text,
                  FirebaseAuth.instance.currentUser!.uid));

              textEditingController.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
