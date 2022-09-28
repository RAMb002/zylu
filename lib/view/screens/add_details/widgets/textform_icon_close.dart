import 'package:flutter/material.dart';

class MyTextFormFieldIconButtonClose extends StatelessWidget {
  const MyTextFormFieldIconButtonClose({required this.onPressed,
    Key? key,}) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding:  EdgeInsets.zero,
      constraints:  null,
      onPressed: onPressed,
      icon: const Icon(
        Icons.close,
        color:  Colors.black45,
        size: 22.0,
      ),
    );

  }
}
