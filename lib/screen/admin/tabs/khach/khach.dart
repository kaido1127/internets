import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/models/computer.dart';
import 'package:internet_cafes/screen/admin/tabs/khach/computer/gridViewComputer.dart';

class Khach extends StatefulWidget {
  const Khach({Key? key}) : super(key: key);

  @override
  State<Khach> createState() => _KhachState();
}

class _KhachState extends State<Khach> {

  List<Computer> _listOn = [];
  List<Computer> _listOff = [];
  List<Computer> _listRepair = [];
  int timeNow=DateTime.now().millisecondsSinceEpoch;
  void refreshWidget() {
    setState(() {
      timeNow=DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
              onPressed: () {refreshWidget();},
              child: Column(
                children: const [
                  Icon(Icons.refresh,),
                  Text(
                    'Làm mới',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            )

          ],
          centerTitle: true,
          title: const Text(
            'Quản lý khách',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: APIs.firestore
                  .collection(APIs.currentAdmin.cs.toString())
                  .doc('computer')
                  .collection('computer')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    {
                      final data = snapshot.data?.docs;
                      _listOff = data
                              ?.map((e) => Computer.fromJson(e.data()))
                              .where((computer) =>
                                  computer.timeOut! < timeNow &&
                                  computer.isActive == true)
                              .toList() ??
                          [];
                      _listOn = data
                              ?.map((e) => Computer.fromJson(e.data()))
                              .where((computer) =>
                                  computer.timeOut! >= timeNow)
                              .toList() ??
                          [];
                      /*_listOff = data
                          ?.map((e) => Computer.fromJson(e.data()))
                          .where((computer) =>
                      computer.status==false &&
                          computer.isActive == true)
                          .toList() ??
                          [];
                      _listOn = data
                          ?.map((e) => Computer.fromJson(e.data()))
                          .where((computer) =>
                      computer.status==true)
                          .toList() ??
                          [];*/
                      _listRepair = data
                              ?.map((e) => Computer.fromJson(e.data()))
                              .where((computer) => computer.isActive == false)
                              .toList() ??
                          [];
                    }
                    return SingleChildScrollView(
                      child: Wrap(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Colors.blueGrey),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Máy không hoạt động",
                                    style: TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          if (_listOff.isNotEmpty)
                            Expanded(
                              child: GridViewComputer(
                                list: _listOff,
                              ),
                            )
                          else
                            const Text("Tất cả máy đều đang hoạt động",
                                style: TextStyle(color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Colors.green),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Máy hoạt động",
                                    style: TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          if (_listOn.isNotEmpty)
                            Expanded(
                                child: GridViewComputer(
                              list: _listOn,
                            ))
                          else
                            const Center(
                              child: Text("Tất cả máy đều đang tắt",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Colors.red),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Máy hỏng",
                                    style: TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          if (_listRepair.isNotEmpty)
                            Expanded(
                                child: GridViewComputer(
                              list: _listRepair,
                            ))
                          else
                            const Center(
                                child: Text("Không có máy nào lỗi",
                                    style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    );
                }
              }),
        ));
  }
}
