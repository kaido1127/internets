import 'dart:async';
import 'dart:isolate';

import 'package:internet_cafes/apis/apis.dart';

void backgroundTask(dynamic message) {
  // Thực hiện công việc tắt máy tính ở đây, sử dụng message nếu cần thiết
  APIs.shutdownComputer(message.toString());
}

void main(List<String> args, SendPort sendPort) {
  final dynamic message = args[0];

  // Thiết lập kết nối giữa Isolate và gửi thông điệp khi hoàn thành
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  // Lắng nghe thông điệp từ giao diện người dùng
  receivePort.listen((dynamic message) {
    if (message == 'start') {
      // Gọi hàm tắt máy tính
      backgroundTask(args[1]);

      // Gửi thông điệp hoàn thành khi tác vụ hoàn tất
      sendPort.send('completed');
    }
  });
}
