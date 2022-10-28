import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandartEditField extends StatelessWidget {
  const StandartEditField({
    Key? key,
    required this.nameController,
    required this.formatter,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      width: 120,
      child: TextField(
        inputFormatters: [formatter],
        keyboardType: TextInputType.text,
        controller: nameController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
        ),
      ),
    );
  }
}
