import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class NumberInputIncDec extends StatelessWidget {
  NumberInputIncDec({
    Key key,

    this.setValue,
    this.textController,
  }) : super(key: key);


  final Function setValue;
  final TextEditingController textController;


  @override
  Widget build(BuildContext context) {
    int quantityTemp = 0;
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            quantityTemp = int.tryParse(textController.text);
            if (quantityTemp > 1) quantityTemp--;
            textController.text = quantityTemp.toString();
            setValue();
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
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
            onChanged: (value) {
              print(value);
              if (int.tryParse(textController.text) == null || int.tryParse(textController.text) < 1) {
                textController.clear();
              } else setValue();
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            quantityTemp = int.tryParse(textController.text);
            if (quantityTemp < 999) quantityTemp++;
            textController.text = quantityTemp.toString();
            setValue();
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
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
