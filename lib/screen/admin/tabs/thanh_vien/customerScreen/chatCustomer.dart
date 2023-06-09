import 'package:flutter/material.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/models/customer.dart';

class ChatCustomer extends StatefulWidget {
  final Customer customer;
  const ChatCustomer({super .key, required this.customer});

  @override
  State<ChatCustomer> createState() => _ChatCustomerState();
}

class _ChatCustomerState extends State<ChatCustomer> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: IconButton(
        color: Colors.blue,
        icon: const Icon(Icons.add),
        onPressed: (){
          Dialogs.showAdminAuth(context,(){});
        },
      ),
    );
  }
}
