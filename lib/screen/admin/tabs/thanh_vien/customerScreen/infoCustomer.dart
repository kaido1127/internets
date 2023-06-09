import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/helper/my_date_util.dart';
import 'package:internet_cafes/models/customer.dart';

class InfoCustomer extends StatefulWidget {
  final Customer customer;
  const InfoCustomer({super.key, required this.customer});

  @override
  State<InfoCustomer> createState() => _InfoCustomerState();
}

class _InfoCustomerState extends State<InfoCustomer> {
  
  final _formKeyChangePassword = GlobalKey<FormState>();
  final _formKeyDelete = GlobalKey<FormState>();
  final _formKeyPay = GlobalKey<FormState>();

  final _passController = TextEditingController();
  final _rePassController = TextEditingController();

  final _costController = TextEditingController();
  final _reCostController = TextEditingController();

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red[100],
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên đăng nhập: ${widget.customer.username}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Mật khẩu: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      if (hidePassword)
                        const Text('********', style: TextStyle(fontSize: 18)),
                      Visibility(
                        visible: !hidePassword,
                        child: Text(
                          widget.customer.password.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            text: hidePassword ? 'Hiện' : 'Ẩn',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueGrey,
                              decorationStyle: TextDecorationStyle.solid,
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Số dư: ${widget.customer.currentCost} VNĐ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tổng nạp: ${widget.customer.totalCost} VNĐ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'SĐT: ${widget.customer.phoneNumber}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ngày đăng kí: ${MyDateUtil.getCreatedTime(
                        context: context, created: widget.customer.startTime.toString())}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tổng thời lượng chơi: 20:21:22',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.customer.isActive.toString() == 'false')
                    const Text(
                      'Trạng thái hoạt động: Không hoạt động',
                      style:  TextStyle(fontSize: 18),
                    ),
                  if (widget.customer.isActive.toString() == 'true')
                    const Text(
                      'Trạng thái hoạt động: Đang hoạt động',
                      style:  TextStyle(fontSize: 18),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text('Đổi mật khẩu'),
                              content: Form(
                                key: _formKeyChangePassword,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _passController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Mật khẩu mới',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'Vui lòng nhập mật khẩu';
                                        else if (value.length < 8)
                                          return 'Mật khẩu phải có độ dài từ 8 kí tự';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: _rePassController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Xác nhận mật khẩu',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'Vui lòng xác nhận mật khẩu';
                                        else if (value != _passController.text)
                                          return 'Mật khẩu không khớp';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    _passController.text = '';
                                    _rePassController.text = '';
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    'Hủy',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Dialogs.showAdminAuth(context, () async {
                                      if (_formKeyChangePassword.currentState!
                                          .validate()) {
                                        await APIs.updateCustomerPassword(
                                            widget.customer.id.toString(), _passController.text);
                                        setState(() {
                                          widget.customer.password=_passController.text;
                                        });
                                        _passController.text = '';
                                        _rePassController.text = '';
                                        Dialogs.showSnackBar(
                                            context, 'Đổi mật khẩu thành công');
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                  child: const Text('Đổi'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }, //on
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    label: const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text('Xóa thành viên'),
                              content: Form(
                                key: _formKeyDelete,
                                child: Wrap(
                                  children: [
                                    const Text('Bạn chắc chắn muốn xóa thành viên ',),
                                    Text('${widget.customer.username}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                    const Text(' ?',),
                                  ],
                                ),

                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    'Hủy',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Dialogs.showAdminAuth(context, () async {
                                      if (_formKeyDelete.currentState!.validate()) {
                                        await APIs.deleteCustomer(widget.customer.id.toString());
                                        Dialogs.showSnackBar(
                                            context, 'Xóa thành viên thành công');
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: const Text('Xóa'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }, //on
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 20,
                    ),
                    label: const Text(
                      'Xóa ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogTheme: DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: AlertDialog(
                          title: const Text('Nạp tiền'),
                          content: Form(
                            key: _formKeyPay,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: _costController,
                                  decoration: const InputDecoration(
                                    labelText: 'Số tiền muốn nạp (VNĐ)',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập số tiền muốn nạp (VNĐ)';
                                    }
                                    final amount = int.tryParse(value);
                                    if (amount == null || amount < 5000) {
                                      return 'Nạp tối thiểu 5000 VNĐ';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: _reCostController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập lại số tiền muốn nạp',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập lại số tiền muốn nạp';
                                    }
                                    if (value != _costController.text) {
                                      return 'Số tiền không khớp';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _costController.text = '';
                                _reCostController.text = '';
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Dialogs.showAdminAuth(context, () async {
                                  if (_formKeyPay.currentState!.validate()) {
                                    await APIs.recharegeCustomer(
                                        widget.customer.id.toString(), _costController.text);
                                    setState(() {
                                      widget.customer.currentCost=((widget.customer.currentCost!)+int.parse(_costController.text));
                                      widget.customer.totalCost=((widget.customer.totalCost!)+int.parse(_costController.text));
                                    });
                                    _costController.text = '';
                                    _reCostController.text = '';
                                    Dialogs.showSnackBar(context, 'Nạp tiền thành công');
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              child: const Text('Nạp'),
                              //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }, //on
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(mq.width * 0.6, mq.height * 0.07)),
                icon: const Icon(
                  Icons.payment_outlined,
                  size: 20,
                ),
                label: const Text(
                  'Nạp tiền',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )
    );
  }
}
