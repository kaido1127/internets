import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';

class LoginTab extends StatefulWidget {
  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {

  final _formKey=GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
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
                      borderSide: BorderSide(color: Colors.white),
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
                SizedBox(
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
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Vui lòng nhập mật khẩu';
                    else if (value.length < 8) return 'Mật khẩu phải có độ dài từ 8 kí tự';
                    return null;
                  },
                ),
                SizedBox(height: 25,),
                ElevatedButton.icon(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
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
