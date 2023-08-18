import 'package:flutter/material.dart';

import '../components/add_post_dailog.dart';
import '../screens/post_list_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PostListScreen(),
            )
          ],
        ),
      ),
      // 用來新增貼文
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPostDialog(
            context,
            textEditingController,
          );
        },
        tooltip: '新增貼文',
        child: const Icon(Icons.add),
      ),
    );
  }
}
