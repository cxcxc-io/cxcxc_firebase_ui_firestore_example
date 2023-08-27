import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/author.dart';
import 'package:flutter_application_1/services/post_service.dart';

import './controllers/controller.dart';
import './firebase_options.dart';
import './utils/config.dart';
import './utils/logger.dart';
import 'services/author_service.dart';

void main() async {
  logger.i("程式的入口");
  WidgetsFlutterBinding.ensureInitialized();
  logger.i("啟動 Firebase, 並套用 Firebase 專案設定檔");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 若使用, emulator 需額外啟用並定向 IP
  if (USE_EMULATOR) {
    logger.i("開發中, 啟用 Auth Emulator");
    // 驗證系統
    await FirebaseAuth.instance.useAuthEmulator(IP, 9099);
    // Firestore
    logger.i("開發中, 啟用 Firestore");
    FirebaseFirestore.instance.useFirestoreEmulator(IP, 8080);
    FirebaseFirestore.instance.enableNetwork();
  }

  // 用戶1
  String userEmail1 = "abc123@gmail.com";
  String password1 = "password1";
  // 用戶1
  String userEmail2 = "cba567@gmail.com";
  String password2 = "password2";

  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail2, password: password2);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      logger.e('No user found for that email.');
      // Firebase 會員註冊
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail2,
          password: password2,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          logger.w('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          logger.w('The account already exists for that email.');
        }
      } catch (e) {
        logger.e(e);
      }
    } else if (e.code == 'wrong-password') {
      logger.e('Wrong password provided for that user.');
    }
  }

  await AuthorService.addAuthor(Author(FirebaseAuth.instance.currentUser!.uid,
      FirebaseAuth.instance.currentUser!.email!));

  // logger.wtf((await PostService.getPost("1"))!.toJsonString());
  runApp(const Controller());
}
