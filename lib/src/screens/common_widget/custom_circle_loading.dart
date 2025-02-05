import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

class CustomCircleLoading extends StatelessWidget {
  const CustomCircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
        strokeWidth: 2.w,
      ),
    );
  }
}
