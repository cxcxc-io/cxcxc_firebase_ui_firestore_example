import 'package:flutter/material.dart';

import '../utils/logger.dart';

void showAddPostDialog(
    BuildContext context, TextEditingController textEditingController) {
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
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('送出'),
            onPressed: () {
              // Handle the post content here.
              // Example: print the content
              logger.d(textEditingController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
