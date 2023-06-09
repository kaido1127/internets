import 'package:flutter/material.dart';
import 'package:internet_cafes/screen/admin/tabs/khach/khach.dart';
import 'package:internet_cafes/screen/admin/tabs/profile.dart';
import 'package:internet_cafes/screen/admin/tabs/thanh_vien/thanh_vien.dart';
import 'package:internet_cafes/screen/admin/tabs/thong_bao.dart';
import 'package:internet_cafes/screen/admin/tabs/thong_ke.dart';
import 'package:internet_cafes/screen/login_screen/login_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
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
        body: Column(children: [
      Expanded(
        child: TabBarView(controller: tabController, children: const [
          ThanhVien(),
          Khach(),
          ThongBao(),
          ThongKe(),
          Profile(),
        ]),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.red[900],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(1, 5, 1, 5),
          child: TabBar(
            labelStyle: const TextStyle(fontSize: 9),
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.white,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: const [
              Tab(
                icon: Icon(Icons.people_alt_outlined),
                text: 'Thành viên',
              ),
              Tab(
                icon: Icon(Icons.person_outline),
                text: 'Khách',
              ),
              Tab(
                icon: Icon(Icons.notifications_active_outlined),
                text: 'Thông báo',
              ),
              Tab(
                icon: Icon(Icons.graphic_eq),
                text: 'Thống kê',
              ),
              Tab(
                icon: Icon(Icons.manage_accounts_outlined),
                text: 'Profile',
              ),
            ],
          ),
        ),
      )
    ]),
    );
  }
}
