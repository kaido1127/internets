import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey=GlobalKey<FormState>();

  final _nameController=TextEditingController();
  final _userNameController=TextEditingController();
  final _passController=TextEditingController();
  final _rePassController=TextEditingController();
  final _phoneController=TextEditingController();
  final _moneyController=TextEditingController();
  final _adminPassController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Thêm thành viên',style: TextStyle(color: Colors.white,fontSize: 23),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  focusColor: Colors.red,
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty)
                    return 'Vui lòng nhập họ và tên';
                  //else if(RegExp(r'^[a-z A-Z]+$').hasMatch(value))
                   // return "Tên không hợp lệ";
                  else return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Tên đăng nhập',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 15,),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty)
                    return 'Vui lòng nhập mật khẩu';
                  else if(value.length<8)
                    return 'Mật khẩu phải có độ dài từ 8 kí tự';
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _rePassController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Xác nhận mật khẩu',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty)
                    return 'Vui lòng xác nhận mật khẩu';
                  else if(value!=_passController.text)
                    return 'Mật khẩu không khớp';
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: _moneyController,
                decoration: const InputDecoration(
                  labelText: 'Nạp lần đầu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số tiền nạp lần đầu';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Số tiền không hợp lệ';
                  }
                  if (double.parse(value) < 10000) {
                    return 'Số tiền tối thiểu là 10000';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 15,),
              TextFormField(
                obscureText: true,
                controller: _adminPassController,
                decoration: const InputDecoration(
                  labelText: 'Xác thực admin',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Vui lòng nhập mã xác thực';
                  else if(value!=APIs.currentAdmin.password)
                    return 'Mã xác thực admin không hợp lệ';
                  return null;
                },

              ),
              const SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    QuerySnapshot<Map<String, dynamic>> snapshot = await APIs.firestore.collection('customers').where('username', isEqualTo: _userNameController.text).get();
                    if(snapshot.docs.isEmpty){
                      if(APIs.currentAdmin?.password==_adminPassController.text){
                        final time=DateTime.now().millisecondsSinceEpoch;
                        final customer=Customer(
                          id : time.toString(),
                          name : _nameController.text,
                          username:_userNameController.text,
                          password:_passController.text,
                          phoneNumber : _phoneController.text,
                          startTime : time,
                          totalTime : 0,
                          currentCost: int.parse(_moneyController.text),
                          totalCost : int.parse(_moneyController.text),
                          isActive : false,
                          lastOnline:0,
                          onlineComputer: "",
                          onlineInCs: "",
                        );
                        await APIs.createCustomer(customer);
                        Dialogs.showSnackBar(context, 'Tạo tài khoản thành công');
                      }else Dialogs.showSnackBar(context, 'Mã xác nhận admin không chính xác');
                    }
                    else Dialogs.showSnackBar(context, 'Tên đăng nhập đã tồn tại');
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    minimumSize:
                    Size(mq.width*0.5 , mq.height * 0.07)),
                icon: const Icon(
                  Icons.person_add_outlined,
                  size: 20,
                ),
                label: const Text(
                  'Thêm',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
