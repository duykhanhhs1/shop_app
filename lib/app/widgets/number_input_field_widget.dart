import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputIncDec extends StatelessWidget {
  const NumberInputIncDec({
    Key key,
    this.onTapIncrease,
    this.onTapDecrease,
    this.onChanged,
    this.textController,
  }) : super(key: key);

  final Function onTapIncrease;
  final Function onTapDecrease;
  final Function onChanged;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: onTapDecrease,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 30,
            height: 30,
            child: Icon(
              Icons.remove,
              size: 13,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          height: 30,
          width: 43,
          child: TextFormField(
            controller: textController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
            textAlign: TextAlign.center,
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTapIncrease,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 30,
            height: 30,
            child: Icon(
              Icons.add,
              size: 13,
            ),
          ),
        )
      ],
    );
  }
}
