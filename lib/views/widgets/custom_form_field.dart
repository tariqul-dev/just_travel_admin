import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  bool isPassword;
  bool isPrefIcon;
  int maxLine;
  IconData? icon;
  TextInputType textInputType;
  final String labelText;
  VoidCallback? onEditingComplete;

  CustomFormField({
    required this.controller,
    this.icon,
    required this.labelText,
    this.onEditingComplete,
    this.isPassword = false,
    this.isPrefIcon = true,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => TextFormField(
        controller: controller,
        maxLines: maxLine,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
          prefixIcon: isPrefIcon ? Icon(icon) : null,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: authProvider.changeVisibility,
                  icon: authProvider.isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
        ),
        obscureText: isPassword ? authProvider.isObscure : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field must not be empty';
          }
          return null;
        },
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
