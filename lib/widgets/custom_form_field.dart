import 'package:flutter/material.dart';
import 'package:my_app/core/const.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? requestFocusNode;
  final TextInputType? keyboardType;
  final String? labelText;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color focusColor;
  final bool passwordField;

  const CustomFormField({
    this.keyboardType,
    this.labelText,
    this.focusNode,
    this.textInputAction,
    this.requestFocusNode,
    this.validator,
    this.controller,
    this.onChanged,
    this.focusColor = Colors.blue,
    required this.title,
    this.hintText,
    this.passwordField = false,
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0, left: 10),
            child: TextFormField(
              onChanged: widget.onChanged,
              controller: widget.controller,
              obscureText: widget.passwordField ? !visibility : false,
              onTap: () {
                setState(() {
                  widget.focusNode!.requestFocus();
                });
              },
              focusNode: widget.focusNode,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              onFieldSubmitted: (v) {
                setState(() {
                  FocusScope.of(context).requestFocus(widget.requestFocusNode);
                });
              },
              keyboardType: widget.keyboardType,
              cursorColor: Colors.black12,
              cursorWidth: 1.5,
              cursorHeight: 25,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: widget.passwordField
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          icon: Icon(
                            visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: visibility ? kBlueColor : Colors.grey,
                            size: 24,
                          ))
                      : null,
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.focusNode!.hasFocus
                          ? widget.focusColor
                          : Colors.black54),
                  labelText: widget.labelText,
                  fillColor: widget.focusColor,
                  focusColor: widget.focusColor,
                  hoverColor: widget.focusColor,
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: widget.focusColor, width: 2))),
            ),
          ),
        ],
      ),
    );
  }
}
