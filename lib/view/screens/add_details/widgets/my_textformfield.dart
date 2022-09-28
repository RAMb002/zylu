
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zylu/model/employee_data.dart';
import 'package:zylu/view/css/css.dart';
import 'package:zylu/view/screens/add_details/widgets/textform_icon_close.dart';

const tIconSize = 22.0;
BorderRadius lBorderRadius = BorderRadius.all(Radius.circular(6));


class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.headingText,
    required this.isNumber,
    this.email = false,
    this.hintText = '',
    Key? key,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool email;
  final String hintText;
  final String headingText;
  final bool isNumber;
  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  // final
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headingText,
          style:const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)

        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          cursorColor:  Colors.black,
          style: const TextStyle( color : Colors.black54,fontSize: 15),
          autofocus: false,
          validator: widget.validator,
          inputFormatters:widget.isNumber ?  <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ] : null,

          onChanged: (value) {

            setState(() {});
          },

          decoration: InputDecoration(
              filled:  true,
              fillColor:  kFormColor,
              errorStyle: const TextStyle(color:kPrimaryColor,),
              focusedErrorBorder:
              UnderlineInputBorder(
                  borderSide: const BorderSide(color: kPrimaryColor, width: 3), borderRadius: lBorderRadius),
              errorBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: kPrimaryColor, width: 3), borderRadius: lBorderRadius),
              enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kFormColor, width: 0), borderRadius: lBorderRadius),
              focusedBorder:
                   OutlineInputBorder(
                      borderSide: const BorderSide(color: kFormColor, width: 0), borderRadius: lBorderRadius),
              hintText: widget.hintText,
              // hintStyle:widget.lineColorWhite ? TextStyle(color: Colors.white54) : null,
              // labelText: widget.labelText,
              labelStyle: const TextStyle(color: Colors.black),
              suffixIcon: widget.controller.text.isEmpty
                  ? Container(
                      width: 0,
                    )
                  : getIconButton()),
        ),
        const SizedBox(
          height: kDPSizedBoxHeightAfterWidget,
        ),
      ],
    );
  }

  Widget? getIconButton() {
      if (widget.controller.text.isEmpty) {
        return Container(
          width: 0,
        );
      } else if (widget.controller.text.isNotEmpty) {
        return MyTextFormFieldIconButtonClose(
          onPressed: () {
            widget.controller.clear();
            setState(() {});
          },
        );
      }
  }

}
