import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/screen/admin/admin_home_screen.dart';

class AdminTab extends StatefulWidget {
  @override
  State<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {

  final _formKey=GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  final listAddressItem = ["Cơ sở 1", 'Cơ sở 2'];
  String? valueAddressChoose = "Cơ sở 1";
  String convertToCs(String text) {
    String numberString = text.replaceAll(RegExp('[^0-9]'), '');
    
    String csString = 'cs$numberString';

    return csString;
  }


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                DropdownButtonFormField(
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.black,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: const TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.red[900],
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  value: valueAddressChoose,
                  items: listAddressItem.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      valueAddressChoose = val as String;
                    });
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _userNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: const TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.red[900],
                    labelText: 'Tên đăng nhập',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên đăng nhập';
                    } else if (value.length < 6) {
                      return 'Tên đăng nhập phải có độ dài từ 6 kí tự';
                    } else if (RegExp(r'[đĐơƠưƯ]').hasMatch(value)) {
                      return 'Tên đăng nhập không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: const TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.red[900],
                    labelText: 'Mật khẩu',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Vui lòng nhập mật khẩu';
                    else if (value.length < 8) return 'Mật khẩu phải có độ dài từ 8 kí tự';
                    return null;
                  },
                ),
                const SizedBox(height: 25,),
                ElevatedButton.icon(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      Dialogs.showProgressBar(context);
                      if(await APIs.login(convertToCs(valueAddressChoose.toString()), _userNameController.text, _passController.text,context)) {
                        await APIs.getCurrentAdmin(convertToCs(valueAddressChoose.toString()), _userNameController.text);
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>AdminHomeScreen()));
                      }else Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[200],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      minimumSize:
                      Size(mq.width*0.5 , mq.height * 0.07)),
                  icon: const Icon(
                    Icons.login,
                    size: 20,
                  ),
                  label: const Text(
                    'Đăng nhập',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
