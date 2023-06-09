import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/customer.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/option/add.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/option/searchCustomerScreen.dart';
import 'package:internet_cafes/screen/widget/member_card.dart';
class ThanhVien extends StatefulWidget {
  const ThanhVien({Key? key}) : super(key: key);

  @override
  State<ThanhVien> createState() => _ThanhVienState();
}

class _ThanhVienState extends State<ThanhVien> {
  List<Customer> _list=[];
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quản lý thành viên',style: TextStyle(color: Colors.white,fontSize: 23),),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Add()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      //backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      minimumSize:
                      Size(mq.width , mq.height * 0.07)),
                  icon: const Icon(
                    Icons.person_add_alt,
                    size: 20,
                  ),
                  label: const Text(
                    'Thêm thành viên',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchCustomerScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: mq.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(25),
              ),
              child:Row(
                children:const [
                  Icon(Icons.search,size: 20,),
                  SizedBox(width: 10,),
                  Text('Tìm kiếm thành viên',style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ),
          const Divider(height: 1,),
          //const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(
              stream: APIs.firestore.collection('customers').snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    {
                      final data=snapshot.data?.docs;
                      _list=data?.map((e) =>Customer.fromJson(e.data())).toList()??[];
                    }
                    if(_list.isNotEmpty){
                      return ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context,index){
                          return MemberCard(customer: _list[index],);
                        },
                      );
                    }else {
                      return const Center(child: Text("Chưa có thành viên nào",style: TextStyle(color: Colors.black),));
                    }
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
