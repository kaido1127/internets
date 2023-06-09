import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/screen/login_screen/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'+APIs.currentAdmin!.userName.toString(),style: TextStyle(color: Colors.white,fontSize: 23),),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blueAccent,
          onPressed: (){
            APIs.currentAdmin==null;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
          },
          child: const Icon(Icons.logout,color: Colors.white,),
        ),
      ),
    );
  }
}
