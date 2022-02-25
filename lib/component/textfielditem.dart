import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController? value;
  final TextInputType? keybordtype;
  final String? hint;
  final int? line;
  final bool isPassword;
  final bool isSecure;
  final Function()? onPress;
  final Function(dynamic val)? validtion;
  const TextFieldItem(
      {Key? key,
      this.line = 1,
      this.isPassword = false,
      this.isSecure = false,
      this.onPress,
      this.validtion,
      this.value,
      this.keybordtype,
      this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: line,
      validator: (value) => validtion!(value),
      obscureText: isPassword ? isSecure : false,
      controller: value,
      keyboardType: keybordtype,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onPress,
                icon: Icon(isSecure ? Icons.visibility_off : Icons.visibility))
            : null,
        hintText: hint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.shortestSide * .047),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }
}
