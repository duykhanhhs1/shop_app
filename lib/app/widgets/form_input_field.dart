import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key key,
    this.title,
    this.child,
    this.require = false,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool require;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            if (require)
              Text(' (*)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          ],
        ),
        child,
      ],
    );
  }
}
