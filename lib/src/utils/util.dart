import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../helper/constant.dart';

int convertStringToInt(String value) {
  try {
    return value.isEmpty ? 0 : int.parse(value);
  } catch (err) {
    return 0;
  }
}

double convertStringToDouble(String value) {
  try {
    return value.isEmpty ? 0.0 : double.parse(value);
  } catch (err) {
    return 0;
  }
}

double formattedDouble(double value) {
  return value.toPrecision(2);
}

void showMassage(String? msg, {bool isSuccess = false}) {
  Fluttertoast.showToast(
      msg: msg ?? "",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}




int convertStringColorToInt(String value) {
  try {
    var v = int.parse(value.replaceFirst('#', '0xFF'));
    return v;
  } catch (err) {
    return int.parse('0xFFFFFFFF');
  }
}

void customModalSheet(
    {required BuildContext context,
    required Widget content,
    void Function()? onDismiss}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColorLight,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10).r,
        topRight: const Radius.circular(10).r,
      ),
    ),
    builder: (ctx) => content,
  ).whenComplete(() {
    if (onDismiss != null) {
      onDismiss();
    }
  });
}

String formatIsoToCustomDate(String isoDate) {
  if (isoDate.isEmpty) {
    return "";
  }

  DateTime dateTime = DateTime.parse(isoDate).toLocal();

  String daySuffix = getDaySuffix(dateTime.day);
  String formattedDate = DateFormat("MMMM d'$daySuffix' yyyy").format(dateTime);

  String formattedTime = DateFormat("h:mm a").format(dateTime);

  return "$formattedDate, $formattedTime";
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
