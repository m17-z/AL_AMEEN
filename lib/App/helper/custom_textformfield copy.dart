// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? suffixicon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final int? maxLines;
  final bool readOnly;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final bool required;
  final EdgeInsetsGeometry? padding;
  final bool withLabel;
  final TextStyle? style;
  final TextButton? textButton;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.label,
      this.hintText,
      this.isPassword = false,
      this.validator,
      this.autofillHints,
      this.keyboardType,
      this.suffix,
      this.suffixicon,
      this.maxLines = 1,
      this.readOnly = false,
      this.onChanged,
      this.onTap,
      this.prefix,
       this.textButton,
      this.prefixIcon,
      this.required = false,
      this.padding,
      this.withLabel = true,
      this.style});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShow = false;
  String? errorText = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.withLabel) const SizedBox(height: 2.0),
        TextFormField(
          controller: widget.controller,
          cursorColor: Get.theme.colorScheme.primary,
          style: widget.style ??
              TextStyle(color: Get.theme.colorScheme.onBackground),
          obscureText: widget.isPassword ? !isShow : false,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          decoration: InputDecoration(
            contentPadding: widget.padding,
            border: normalBorder(),
            enabledBorder: normalBorder(),
            focusedBorder: activeBorder(),
            suffix: widget.suffix,
            hintText: widget.label,
            prefix: widget.prefix,
            fillColor: context.theme.colorScheme.shadow.withOpacity(.2),
            filled: true,
            errorMaxLines: 3,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => isShow = !isShow),
                    child: Icon(
                      isShow ? Icons.visibility : Icons.visibility_off,
                      color: Get.theme.colorScheme.primary,
                    ),
                  )
                : widget.suffixicon,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder normalBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        color: Colors.purple,
      ),
    );
  }

  OutlineInputBorder activeBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
      borderSide: const BorderSide(
        color: Colors.green,
      ),
    );
  }
}
