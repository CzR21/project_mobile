import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

class AppTextFieldComponent extends StatefulWidget {

  final bool autofocus;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final GlobalKey<FormState>? individualKey;
  final String? label;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? formatters;
  final String? hint;
  final TextStyle? hintStyle;
  final String? suffixIcon;
  final void Function()? suffixIconOnTap;
  final void Function(String value)? onEdit;
  final void Function(String value)? onSubmit;
  final bool Function(String value)? onPaste;
  final bool optional;
  final bool obscureText;
  final bool hasErrorText;
  final String? Function(String? value)? validator;
  final void Function(bool isValid)? onValidate;

  const AppTextFieldComponent({
    super.key,
    this.autofocus = false,
    this.focusNode,
    required this.controller,
    this.individualKey,
    this.label,
    this.textInputType,
    this.textInputAction,
    this.textAlign,
    this.formatters,
    this.hint,
    this.hintStyle,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.onEdit,
    this.onSubmit,
    this.onPaste,
    this.obscureText = false,
    this.optional = true,
    this.hasErrorText = true,
    this.validator,
    this.onValidate,
    this.textCapitalization,
  });

  @override
  State<AppTextFieldComponent> createState() => _AppTextFieldComponentState();
}

class _AppTextFieldComponentState extends State<AppTextFieldComponent> {

  late final FocusNode focusNode;
  late bool validated;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    validated = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null ? Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(widget.label!.toUpperCase(), style: AppFonts.regularDefault.copyWith(color: AppColors.textDarkColor), ),
        ) : const SizedBox(),
        TextFormField(
          validator: (value) {
            final errorText = widget.validator?.call(value);
            validated = (widget.controller.text.isNotEmpty || widget.optional) && errorText == null;
            if (mounted) {
              setState(() {});
            }
            widget.onValidate?.call(validated);
            if (!validated) {
              return errorText ?? 'Campo obrigatório';
            }
            return null;
          },
          autofocus: widget.autofocus,
          focusNode: focusNode,
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.textInputType ?? TextInputType.text,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          textAlign: widget.textAlign ?? TextAlign.left,
          inputFormatters: widget.formatters,
          onChanged: widget.onEdit,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          onFieldSubmitted: widget.onSubmit,
          style: AppFonts.regularDefault.copyWith(color: !validated && !focusNode.hasFocus ? AppColors.textRedColor : AppColors.textGreyColor,),
          cursorColor: !validated && !focusNode.hasFocus ? AppColors.textRedColor : AppColors.textGreyColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: AppColors.greyLiteColor,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: !validated ? AppColors.textRedColor : AppColors.greyLiteColor,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: !validated ? AppColors.textRedColor : AppColors.greyLiteColor,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: !validated ? AppColors.textRedColor : AppColors.greyLiteColor,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: const BorderSide(
                color: AppColors.textRedColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: const BorderSide(
                color: AppColors.textRedColor,
              ),
            ),
            suffixIcon: widget.suffixIcon == null ? null : GestureDetector(
              onTap: () => widget.suffixIconOnTap!.call(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 10, 8),
                child: Image.asset(widget.suffixIcon!, color: AppColors.textGreyColor, width: 24,),
              ),
            ),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? AppFonts.regularDefault.copyWith(
              color: !validated && !focusNode.hasFocus ? AppColors.textRedColor : AppColors.textGreyColor,
            ),
            errorStyle: AppFonts.regularDefault.copyWith(
              fontSize: widget.hasErrorText ? AppFonts.regularDefault.fontSize! : 0,
              color: AppColors.textRedColor,
            ),
            errorMaxLines: 2,

          ),
        ),
      ],
    );

    if (widget.individualKey != null) {
      return Form(
        key: widget.individualKey,
        child: textField,
      );
    }

    return textField;
  }
}
