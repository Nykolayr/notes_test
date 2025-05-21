import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notes_test/presentation/theme/theme.dart';

class NotesTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isMultiLine;
  const NotesTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: AppText.t16rw.copyWith(color: AppColor.black),
        ),
        const Gap(10),
        TextFormField(
          controller: controller,
          validator: (value) {
            value = value?.trim();
            if (value == null || value.isEmpty) {
              return 'Заполните поле';
            }
            return null;
          },
          keyboardType: keyboardType,
          style: AppText.t16rw.copyWith(color: AppColor.greyText),
          maxLines: isMultiLine ? 5 : 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.backgrounField,
            hintText: hintText,
            hintStyle: AppText.t16rw.copyWith(color: AppColor.greyText),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
