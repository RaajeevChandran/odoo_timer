import 'package:flutter/material.dart';
import 'package:odoo_timer/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String?) onChanged;
  const CustomTextField({required this.hintText, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: context.colorScheme.secondary, width: 2.0)
        ),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintText: hintText,
              hintStyle: context.textTheme.bodyMedium
              ),
        ),
      ),
    );
  }
}
