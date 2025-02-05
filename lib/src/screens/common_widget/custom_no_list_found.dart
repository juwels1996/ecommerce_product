import 'package:flutter/material.dart';

class CustomNoListFount extends StatelessWidget {
  final String msg;
   const CustomNoListFount({super.key, required this.msg}) ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
