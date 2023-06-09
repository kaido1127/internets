
import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';
import 'package:internet_cafes/helper/dialogs.dart';
import 'package:internet_cafes/helper/my_date_util.dart';
import 'package:internet_cafes/models/computer.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/screen/admin/tabs/khach/computer/computerChat.dart';

class ComputerInfoPage extends StatefulWidget {
  final Computer computer;
  const ComputerInfoPage({required this.computer, super.key});

  @override
  State<ComputerInfoPage> createState() => _ComputerInfoPageState();
}

class _ComputerInfoPageState extends State<ComputerInfoPage> {

  final _formKeyComputerError = GlobalKey<FormState>();
  final _formKeyComputerStartUp = GlobalKey<FormState>();
  final _formKeyComputerShutDown = GlobalKey<FormState>();
  final _formKeyComputerAddTime = GlobalKey<FormState>();
  final _formKeyComputerActive = GlobalKey<FormState>();

  final _hourController = TextEditingController();
  final _addHourController = TextEditingController();


  Future<void> updateStatus(bool newStatus) async {
    setState(() {
      widget.computer.status = newStatus;
    });
    await APIs.shutdownComputer(widget.computer.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông tin máy tính',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: mq.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red[100],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displaying the customer name
                    Text(
                      widget.computer.name.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    // Displaying the customer's phone number
                    Text(
                      "ID: ${widget.computer.id}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 7),
                    // Displaying the customer's phone number
                    widget.computer.status == true
                        ? const Text(
                            'Status: Đang hoạt động',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          )
                        : const Text(
                            'Status: Máy trống',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                    const SizedBox(height: 7),
                    // Displaying the customer's phone number
                    widget.computer.isActive == true
                        ? const Text(
                            'Hỏng: Không',
                            style: TextStyle(fontSize: 18),
                          )
                        : const Text(
                            'Hỏng: Có',
                            style: TextStyle(fontSize: 18),
                          ),
                    const SizedBox(height: 7),
                    // Displaying the customer's phone number
                    Text(
                      "Tổng thời gian sử dụng: ${widget.computer.usedTime}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 7),
                    // Displaying the customer's phone number
                    Text(
                      "Thời gian lắp đặt: ${MyDateUtil.getTime(context: context, ftime: widget.computer.installTime.toString())}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (widget.computer.status == true)
                Container(
                  width: mq.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red[100],
                  ),
                  child: StreamBuilder(
                      stream: APIs.firestore.collection(APIs.currentAdmin.cs.toString()).doc('computer').collection('computer').doc(widget.computer.id.toString()).snapshots(),
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
                              final computerData = snapshot.data?.data();
                              final computer = Computer.fromJson(computerData!);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Displaying the customer name
                                  if (computer.user == null || computer.user!.isEmpty)
                                    const Text(
                                      'Khách',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                    )
                                  else
                                    Text(
                                      computer.user.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                    ),
                                  const SizedBox(height: 10),
                                  // Displaying the customer's phone number
                                  Text(
                                    "Thời gian bắt đầu: ${MyDateUtil.getTime(context: context, ftime: computer.startTime.toString())}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 7),
                                  // Displaying the customer's phone number
                                  Text(
                                    "Thời gian kết thúc: ${MyDateUtil.getTime(context: context, ftime: computer.timeOut.toString())}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 7),
                                  CountdownWidget(timeOut: computer.timeOut!,computerID: widget.computer.id.toString(),updateStatus: updateStatus,),
                                ],
                              );
                            }
                        }
                      }),
                ),
              const SizedBox(height: 20,),
              if(widget.computer.status==true)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    title: const Text('Thêm giờ'),
                                    content: Form(
                                      key: _formKeyComputerAddTime,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: _addHourController,
                                            decoration: const InputDecoration(
                                              labelText: 'Thêm giờ chơi',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Vui lòng nhập số giờ thêm';
                                              }
                                              final hour =double.tryParse(value);
                                              if (hour == null || hour < 1) {
                                                return 'Giờ thêm tối thiểu là 1 giờ';
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
                                          _addHourController.text = '';
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
                                            if (_formKeyComputerAddTime.currentState!.validate()) {
                                              await APIs.addTimeComputer(int.parse(_addHourController.text), widget.computer.id.toString());
                                              _addHourController.text = '';
                                              Dialogs.showSnackBar(context, 'Thêm thời gian thành công');
                                              Navigator.of(context).pop();
                                            }
                                          });
                                        },
                                        child: const Text('Thêm'),
                                        //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }, //on
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                          icon: const Icon(
                            Icons.timer,
                            size: 20,
                          ),
                          label: const Text(
                            'Thêm giờ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
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
                                    title: const Text('Tắt máy'),
                                    content: Form(
                                      key: _formKeyComputerShutDown,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '${widget.computer.name}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            ' sẽ bị tắt ?',
                                          ),
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
                                            if (_formKeyComputerShutDown.currentState!.validate()) {
                                              setState(() {
                                                widget.computer.status = false;
                                              });
                                             await APIs.shutdownComputer(widget.computer.id.toString());
                                              Dialogs.showSnackBar(context, 'Tắt máy thành công');
                                              Navigator.of(context).pop();
                                            }
                                          });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                        ),
                                        child: const Text('Xác nhận'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }, //on
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                          label: const Text(
                            'Tắt máy',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ComputerChat(computer: widget.computer,)));
                      }, //on
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                      icon: const Icon(
                        Icons.chat_bubble,
                        size: 20,
                      ),
                      label: const Text(
                        'Nhắn tin',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              if (widget.computer.status == false && widget.computer.isActive == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                title: const Text('Bật máy'),
                                content: Form(
                                  key: _formKeyComputerStartUp,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: _hourController,
                                        decoration: const InputDecoration(
                                          labelText: 'Số giờ chơi',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng nhập số giờ chơi';
                                          }
                                          final hour =double.tryParse(value);
                                          if (hour == null || hour < 1) {
                                            return 'Giờ chơi tối thiểu là 1 giờ';
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
                                      _hourController.text = '';
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
                                        if (_formKeyComputerStartUp.currentState!.validate()) {
                                          await APIs.startUpComputer(int.parse(_hourController.text), widget.computer.id.toString());
                                          setState(() {
                                            widget.computer.status=true;
                                          });
                                          _hourController.text = '';
                                          Dialogs.showSnackBar(context, 'Bật máy thành công');
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                    child: const Text('Bật'),
                                    //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }, //on
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                      icon: const Icon(
                        Icons.lock_open_outlined,
                        size: 20,
                      ),
                      label: const Text(
                        'Bật máy',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
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
                                title: const Text('Báo máy lỗi'),
                                content: Form(
                                  key: _formKeyComputerError,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        '${widget.computer.name}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        ' bị lỗi ?',
                                      ),
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
                                        if (_formKeyComputerError.currentState!.validate()) {
                                          setState(() {
                                            widget.computer.isActive = false;
                                          });
                                          await APIs.updateComputerActive(
                                              false, widget.computer.id.toString());
                                          Dialogs.showSnackBar(context, 'Báo lỗi thành công');
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                    ),
                                    child: const Text('Xác nhận'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }, //on
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                      icon: const Icon(
                        Icons.error,
                        size: 20,
                      ),
                      label: const Text(
                        'Báo lỗi',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              if(widget.computer.isActive==false)
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
                            title: const Text('Cập nhật trạng thái máy tính'),
                            content: Form(
                              key: _formKeyComputerActive,
                              child: Wrap(
                                children: [
                                  Text(
                                    '${widget.computer.name}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    ' đã hoạt động bình thường ?',
                                  ),
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
                                    if (_formKeyComputerActive.currentState!.validate()) {
                                      await APIs.updateComputerActive(true, widget.computer.id.toString());
                                      setState(() {
                                        widget.computer.isActive=true;
                                      });
                                      Dialogs.showSnackBar(context, 'Cập nhật thành công');
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                                child: const Text('Cập nhật'),
                                //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }, //on
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      minimumSize: Size(mq.width * 0.4, mq.height * 0.07)),
                  icon: const Icon(
                    Icons.running_with_errors,
                    size: 20,
                  ),
                  label: const Text(
                    'Đã sửa',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
