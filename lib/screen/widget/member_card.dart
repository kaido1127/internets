import 'package:flutter/material.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/customer.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/customerScreen/customerScreen.dart';

class MemberCard extends StatefulWidget {
  final Customer customer;

  const MemberCard({super.key, required this.customer});
  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomerScreen(customer: widget.customer)));},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: mq.width * 0.04),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.red[100],
        child:  ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.perm_identity_outlined),
          ),
          title: Text(widget.customer.name.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
          subtitle:Text('UserName: ${widget.customer.username.toString()}',) ,
          trailing:(widget.customer.lastOnline!=0)?const Text('New'):Text('3 ngày') ,
        ),
      ),
    );
  }
}
