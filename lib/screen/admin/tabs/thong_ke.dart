import 'package:flutter/material.dart';

class ThongKe extends StatefulWidget {
  const ThongKe({Key? key}) : super(key: key);

  @override
  State<ThongKe> createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Thống kê',style: TextStyle(color: Colors.white,fontSize: 23),),
      ),
    );
  }
}
