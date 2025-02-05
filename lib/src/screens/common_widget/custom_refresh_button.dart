import 'package:flutter/material.dart';

class CustomRefreshButton extends StatelessWidget {
  final void Function() onPress;

  const CustomRefreshButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onPress,
        icon: Icon(
          Icons.refresh,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
