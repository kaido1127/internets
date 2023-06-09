import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/models/customer.dart';
import 'package:internet_cafes/screen/widget/member_card.dart';

class SearchCustomerScreen extends StatefulWidget {
  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  List<Customer> _allCustomer = [];
  List<Customer> _searchList = [];
  bool _isSearching=false;
  final _seachController=TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllCustomers();
  }

  void getAllCustomers() {
    APIs.firestore.collection('customers').snapshots().listen((snapshot) {
      _allCustomer = snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: TextField(
          controller:_seachController ,
          onChanged: (val) {
            if(val.length>=1) setState(() {_isSearching=true;});
           setState(() {_searchList = [];});
            if (_allCustomer.isNotEmpty && _allCustomer != null) {
              for (Customer customer in _allCustomer) {
                if (customer.name != null &&
                    customer.username != null &&
                    (customer.name!.toLowerCase().contains(val.toLowerCase()) ||
                        customer.username!.toLowerCase().contains(val.toLowerCase()) ||
                        customer.phoneNumber!.toLowerCase().contains(val.toLowerCase()))) {
                 setState(() {_searchList.add(customer);});
                }
              }
            }
          },
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white70),
            hintText: 'Tên, Tên đăng nhập, Số điện thoại',
            border: InputBorder.none,
          ),
        ),
        actions: [
          if(_isSearching) IconButton(onPressed: (){
            setState(() {_isSearching=false;});
            _seachController.text="";
          }, icon: Icon(Icons.clear_outlined)),
          const SizedBox(width: 10,),
        ],
      ),
      body: _isSearching?ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _searchList.length,
        itemBuilder: (context,index){
          return MemberCard(customer: _searchList[index]);
        }
      ):const SizedBox(),
    );
  }
}
