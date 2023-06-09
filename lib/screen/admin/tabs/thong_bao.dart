import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';

class ThongBao extends StatefulWidget {
  const ThongBao({Key? key}) : super(key: key);

  @override
  State<ThongBao> createState() => _ThongBaoState();
}

class _ThongBaoState extends State<ThongBao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Thông báo',style: TextStyle(color: Colors.white,fontSize: 23),)
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: ()async{
            await APIs.createComputer(15);
          },
        ),
      ),
    );
  }
}
