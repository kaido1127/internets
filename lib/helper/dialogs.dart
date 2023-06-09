import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
        content: Text(
      msg,
      style: TextStyle(
        color: Colors.white,
      ),
    )));
  }
  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ));
  }
  static void showAdminAuth(BuildContext context,VoidCallback onPress){
    final _formKey=GlobalKey<FormState>();
    final _adminAuthController=TextEditingController();
    showDialog(context: context, builder: (BuildContext context){
      return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
        ),
        child: AlertDialog(
          title: const Text('Xác thực admin'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _adminAuthController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nhập mã xác thực admin',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Vui lòng nhập mã';
                else if (value!=APIs.currentAdmin.password)
                  return 'Mã xác thực không hợp lệ';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _adminAuthController.text='';
              Navigator.pop(context);
            },
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Hủy',style: TextStyle(color: Colors.blue),)),
            ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                Navigator.pop(context);
                onPress();
              }
            }, child: const Text('Xác nhận')),
          ],
        ),
      );
    });
  }
}
