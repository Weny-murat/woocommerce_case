import 'package:flutter/material.dart';

class StandartEditField extends StatelessWidget {
  const StandartEditField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

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
      child: TextFormField(
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
