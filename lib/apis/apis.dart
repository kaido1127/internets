import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/models/admin.dart';
import 'package:internet_cafes/models/computer.dart';
import 'package:internet_cafes/models/customer.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<Admin>> getAllAdmins(String cs) async {
    final snapshot = await firestore.collection(cs).doc('admin').get();
    if (!snapshot.exists) {
      return [];
    }
    final adminMap = snapshot.data() as Map<String, dynamic>;
    final adminList =
        adminMap.values.map((e) => Admin.fromJson(e as Map<String, dynamic>)).toList();
    return adminList;
  }

  static Future<bool> login(
      String cs, String username, String password, BuildContext context) async {
    final snapshot = await firestore.collection(cs).doc('admin').collection(username).get();
    if (snapshot.docs.isEmpty) {
      Dialogs.showSnackBar(context, 'Tài khoản không tồn tại');
      return false;
    }
    ;
    final adminList = snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList();
    final matchingAdmin = adminList
        .where((admin) => admin.userName == username && admin.password == password)
        .toList();
    log(matchingAdmin.length.toString());
    if (matchingAdmin.isEmpty)
      Dialogs.showSnackBar(context, 'Vui lòng kiểm tra lại tên đăng nhập và mật khẩu');
    return matchingAdmin.isNotEmpty;
  }

  static Future<void> createCustomer(Customer customer) async {
    return await firestore.collection('customers').doc(customer.id).set(customer.toJson());
  }

  static Admin currentAdmin = Admin();

  static Future<void> getCurrentAdmin(String cs, String username) async {
    final adminSnapshot =
        await firestore.collection(cs).doc('admin').collection(username).doc(username).get();

    if (adminSnapshot.exists) {
      currentAdmin = Admin.fromJson(adminSnapshot.data() ?? {});
      //log('admin hien tai la ${currentAdmin?.fullName}');
    } else {
      log('Admin with username $username does not exist');
    }
  }

  static Future<void> updateCustomerPassword(String customerID, String newPassword) async {
    firestore.collection('customers').doc(customerID).update({'password': newPassword});
  }

  static Future<void> deleteCustomer(String customerID) async {
    firestore.collection('customers').doc(customerID).delete();
  }

  static Future<void> recharegeCustomer(String customerID, String money) async {
    int intMoney = int.parse(money);
    //firestore.collection('customers').doc(customerID).update({'totalCost':totalCost+money,'currentCost':currentCost+monney});
    var customerSnapshot = await firestore.collection('customers').doc(customerID).get();
    int totalCost = customerSnapshot.data()?['totalCost'];
    int currentCost = customerSnapshot.data()?['currentCost'];
    firestore
        .collection('customers')
        .doc(customerID)
        .update({'totalCost': totalCost + intMoney, 'currentCost': currentCost + intMoney});
  }

  //computer
  static Future<void> createComputer(int id) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final Computer computer = Computer(
      id: id,
      status: false,
      name: "Máy $id",
      isActive: true,
      installTime: time,
      startTime: 0,
      usedTime: 0,
      timeOut: 0,
      user: null,
    );
    return await firestore
        .collection('cs1')
        .doc('computer')
        .collection('computer')
        .doc(computer.id.toString())
        .set(computer.toJson());
  }

  static Future<void> updateComputerActive(bool isActive, String computerID) async {
    firestore
        .collection(currentAdmin.cs.toString())
        .doc('computer')
        .collection('computer')
        .doc(computerID.toString())
        .update({'isActive': isActive});
  }

  static Future<void> startUpComputer(int hour, String computerID) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    final endTime = startTime + hour * 3600000;

    firestore
        .collection(currentAdmin.cs.toString())
        .doc('computer')
        .collection('computer')
        .doc(computerID.toString())
        .update({'startTime': startTime, 'timeOut': endTime,'status':true});
  }
  static Future<void> addTimeComputer(int hour, String computerID) async {
    final ref = await APIs.firestore
        .collection(APIs.currentAdmin.cs.toString())
        .doc('computer')
        .collection('computer')
        .doc(computerID)
        .get();

    final computerData = ref.data();
    final computer = Computer.fromJson(computerData!);
    final endTime = int.parse(computer.timeOut.toString()) + hour * 3600000;

    firestore
        .collection(currentAdmin.cs.toString())
        .doc('computer')
        .collection('computer')
        .doc(computerID.toString())
        .update({'timeOut': endTime,});
  }
  static Future<void> shutdownComputer(String computerID) async {
    firestore
        .collection(currentAdmin.cs.toString())
        .doc('computer')
        .collection('computer')
        .doc(computerID.toString())
        .update({'status': false});
  }

}
