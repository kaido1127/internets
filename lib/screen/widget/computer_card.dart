import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/computer.dart';
import 'package:internet_cafes/screen/admin/tabs/khach/computer/computerInfo.dart';

class ComputerCard extends StatefulWidget {
  final Computer computer;
  const ComputerCard({required this.computer,super.key});
  @override
  State<ComputerCard> createState() => _ComputerCardState();
}

class _ComputerCardState extends State<ComputerCard> {
  Future<void> updateStatus(bool newStatus) async {
    setState(() {
      widget.computer.status = newStatus;
    });
    await APIs.shutdownComputer(widget.computer.id.toString());
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>ComputerInfoPage(computer: widget.computer,)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red[100],
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: mq.width * 0.023),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.computer,color: Colors.red,),
              ),
              const SizedBox(height: 3,),
              Text(widget.computer.name.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
