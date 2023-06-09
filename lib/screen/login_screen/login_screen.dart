import 'package:flutter/material.dart';
import 'package:internet_cafes/screen/login_screen/tab/admin_tab.dart';
import 'package:internet_cafes/screen/login_screen/tab/login_tab.dart';
import 'package:internet_cafes/screen/login_screen/tab/sign_up_tab.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.red[900],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, mq.height * 0.2, 0, 0),
              child: const Text(
                'Internet Cafe Login',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            //Image.asset('images/logo.jpg',scale: 0.5,),
            //SizedBox(height: mq.height*0.07,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
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
                            text: 'Thành viên',
                          ),
                          Tab(
                            text: 'Admin',
                          ),
                          Tab(
                            text: 'Đăng ký',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                LoginTab(),
                AdminTab(),
                SignUpTab(),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                  onTap: (){
                    _launchUrl('van17122003',);
                  },
                  child: Image.asset(
                    'images/facebook_logo.png',
                    width: mq.width * 0.12,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> _launchUrl(String link) async {
  Uri url = Uri.http('www.facebook.com',link);
  if (!await launchUrl(url,mode: LaunchMode.externalNonBrowserApplication)) {
    throw Exception('Could not launch $url');
  }
}
