import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({
    Key? key,
    required this.value,
    required this.isEditable,
    this.textFormField,
    required this.title,
  }) : super(key: key);
  final String value;
  final bool isEditable;
  final Widget? textFormField;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(title),
                      isEditable ? Text(value) : const Text(''),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 12.0),
                child: isEditable
                    ? textFormField!
                    : Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(value),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
