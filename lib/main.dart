import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internet_cafes/firebase_options.dart';
import 'package:internet_cafes/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
late Size mq;
void registerIsolateName() {
  final isolatePort = ReceivePort();
  IsolateNameServer.registerPortWithName(isolatePort.sendPort, 'background_task');
  isolatePort.listen((message) {
    // Xử lý thông điệp từ Isolate nếu cần
    print('Received message from Isolate: $message');
  });
}
void main() {
  registerIsolateName();
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //Get.lazyPut(()=>DataClass)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internet',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black,size: 28),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[900],
          elevation: 1,
          centerTitle: false,
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
        ),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
