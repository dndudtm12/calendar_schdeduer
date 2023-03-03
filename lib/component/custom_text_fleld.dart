import 'package:calendar_schdeduer/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final String initialValue;
  final FormFieldSetter<String>? onSave;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSave,
    Key? key, required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSave,
      validator: (String? val) {
        if(val == null || val.isEmpty){
          return '값을 입력해주세요.';
        }

        if(isTime){
          int time = int.parse(val!);

          if(time < 0){
            return '0 이상의 숫자를 입력해주세요.';
          }
          if(time > 24){
            return '24 이하의 숫자를 입력해주세요.';
          }
        }else{

        }

        return null;
      },
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      maxLines: isTime ? 1 : null,
      initialValue: initialValue,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
        suffixText: isTime ?  '시' : null,

      ),
    );
  }
}
