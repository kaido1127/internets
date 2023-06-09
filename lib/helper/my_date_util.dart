import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_cafes/apis/apis.dart';


class CountdownWidget extends StatefulWidget {
  final String computerID;
  final int timeOut;
  final Function(bool) updateStatus;

  CountdownWidget({required this.timeOut,required this.computerID,required this.updateStatus});

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  String countdownText = '';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startCountdown()  {
    timer = Timer.periodic(const Duration(seconds: 1), (timer)   {
      final now = DateTime.now().millisecondsSinceEpoch;
      final remainingTime = widget.timeOut - now;
      //if(remainingTime==0) await APIs.shutdownComputer(widget.computerID);
      final remainingDuration = Duration(milliseconds: remainingTime);
      final newCountdownText =
          '${remainingDuration.inHours} giờ : ${remainingDuration.inMinutes.remainder(60)} phút : ${remainingDuration.inSeconds.remainder(60)} giây';

      setState(() {
        countdownText = newCountdownText;
      });

      if (remainingTime <= 0) {
        timer.cancel();
        handleTimeout();
      }
    });
  }

 void handleTimeout()  {
     widget.updateStatus(false);
     APIs.shutdownComputer(widget.computerID);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Thời gian còn lại: $countdownText",
      style: const TextStyle(fontSize: 18),
    );
  }
}

class MyDateUtil {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    if (now.day == sent.day && now.month == sent.month && now.year == sent.year)
      return TimeOfDay.fromDateTime(sent).format(context);
    else
      return '${sent.day} ${_getMonth(sent)}';
  }

  static String _getMonth(DateTime time) {
    return 'Tháng ${time.month}';
  }

  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;
    if (i == -1) return '';
    DateTime now = DateTime.now();
    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    String formatTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day && time.month == now.month && now.year == time.year)
      return 'Online $formatTime hôm nay';
    return 'Online ${time.day} ${_getMonth(time)} ${time.year} $formatTime';
  }
  static String getCreatedTime(
      {required BuildContext context, required String created}) {
    final int i = int.tryParse(created) ?? -1;
    if (i == -1) return '';
    DateTime now = DateTime.now();
    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    String formatTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day && time.month == now.month && now.year == time.year)
      return 'Hôm nay';
    return '${time.day}/${_getMonth(time)}/${time.year}';
  }
  static String getTime(
      {required BuildContext context, required String ftime}) {
    final int i = int.tryParse(ftime) ?? -1;
    if (i == -1) return '';
    DateTime now = DateTime.now();
    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    String formatTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day && time.month == now.month && now.year == time.year)
      return formatTime;
    return '$formatTime ${time.day} ${_getMonth(time)} ${time.year} ';
  }
  static String convertMillisecondsToHours(String millisecondsStr) {
    int milliseconds = int.parse(millisecondsStr);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    int hours = dateTime.hour;

    return hours.toString().padLeft(2, '0');
  }
  static String formatDuration(int startTime, int endTime) {
    final Duration duration = Duration(milliseconds: endTime - startTime);

    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    final String formattedDuration = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }

}
