import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ProductCountButton extends StatelessWidget {
  final void Function() onPositivePress;
  final void Function() onNegativePress;
  final int value;

  const ProductCountButton(
      {super.key,
      required this.onNegativePress,
      required this.onPositivePress,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 120.w,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onNegativePress,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(4.0).r,
                  border: Border.all(color: Colors.black, width: 1.0.w)),
              child: const Icon(Icons.remove),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 11.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(4.0).r,
                    border: Border.all(color: Colors.black, width: 1.0.w)),
                child: Center(
                  child: Text(
                    "$value",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: onPositivePress,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(4.0).r,
                  border: Border.all(color: Colors.black, width: 1.0.w)),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
