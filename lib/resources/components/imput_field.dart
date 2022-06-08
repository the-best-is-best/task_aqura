import 'package:flutter/material.dart';

import '../values_manager.dart';

class InputField extends StatefulWidget {
  final String label;
  final String? errorText;
  final ThemeData themeData;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixWidget;

  const InputField({
    Key? key,
    required this.label,
    required this.themeData,
    required this.keyBoardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.nextNode,
    required this.errorText,
    this.onChanged,
    this.prefixIcon,
    this.suffixWidget,
  }) : super(key: key);
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void dispose() {
    widget.focusNode?.dispose();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: widget.themeData.textTheme.labelMedium,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
      maxLength: 4,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
            child: Icon(
              widget.prefixIcon,
              size: AppSpacing.ap30,
            ),
          ),
          suffixIcon: widget.suffixWidget,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
            child: Text(widget.label),
          ),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
