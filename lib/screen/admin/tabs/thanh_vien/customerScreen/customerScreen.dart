import 'package:flutter/material.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/customer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/customerScreen/chatCustomer.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/customerScreen/infoCustomer.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/thanh_vien.dart';

class CustomerScreen extends StatefulWidget {
  final Customer customer;
  const CustomerScreen({super.key, required this.customer});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông tin thành viên',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          // First Container
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[100],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Displaying an image using CachedNetworkImage
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * 0.1),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: mq.height * 0.1,
                          height: mq.height * 0.1,
                          imageUrl: widget.customer.imageUrl.toString(),
                          placeholder: (context, url) => const CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(Icons.person_outlined),
                          ),
                          errorWidget: (context, url, error) => const CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(Icons.person_outlined),
                          ),
                        ),
                      ),
                      //const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            // Displaying the customer name
                            Text(
                              widget.customer.name.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            const SizedBox(height: 10),
                            // Displaying the customer's phone number
                            Text("ID: ${widget.customer.id}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Second Container
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TabBar(
                  labelStyle: const TextStyle(fontSize: 15),
                  controller: tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: const [
                    Tab(text: 'Thông tin'),
                    Tab(text: 'Tin nhắn'),
                  ],
                ),
              ),
            ),
          ),

          // Expanded TabBarView
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                InfoCustomer(customer: widget.customer),
                ChatCustomer(customer: widget.customer),
              ],
            ),
          ),
        ],
      ),
    );


  }
}
