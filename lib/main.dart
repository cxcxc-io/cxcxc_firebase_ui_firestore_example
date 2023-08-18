import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './controllers/controller.dart';
import './firebase_options.dart';
import './utils/config.dart';
import './utils/logger.dart';

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

  runApp(const Controller());
}
