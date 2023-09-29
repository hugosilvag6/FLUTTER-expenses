import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmit;
  final String placeholder;
  final TextInputType keyboardType;

  const AdaptativeTextfield({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmit,
              keyboardType: keyboardType,
              placeholder: placeholder,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
        )
        : TextField(
            controller: controller,
            onSubmitted: onSubmit,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: placeholder,
            ),
          );
  }
}
