import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/screen/admin/admin_home_screen.dart';
import 'package:internet_cafes/screen/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //if(APIs.auth.currentUser!=null) APIs.getMyInfo();

    Future.delayed(const Duration(milliseconds: 3000), ()  {
      setState(() async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    });
      /*setState(() async {
        //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
        if(APIs.auth.currentUser!=null) {
          await APIs.getMyInfo();
          log('\nUser:${APIs.auth.currentUser}');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen(user: APIs.me,)));
        }
        else Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
      });
    });*/
  }

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Text('Internet Cafe',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: Stack(
                children: [
                  //Center(child:Image.asset('images/logo.jpg') ,),
                  Positioned(
                      top: mq.height * 0.20,
                      //right: mq.width * 0.15,
                      width: mq.width * 1,
                      child: Image.asset('images/logo.jpg')),
                  Positioned(
                      bottom: mq.height * 0.15,
                      width: mq.width,
                      child: const Text(
                        'NguyenTheVan 2023 💚',
                        style: TextStyle(color: Colors.black, fontSize: 16,letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
