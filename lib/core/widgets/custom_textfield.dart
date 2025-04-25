import 'package:flutter/material.dart';
import 'package:investement_app/core/constants/app_text_styles.dart';
import 'package:investement_app/core/utils/app_colors.dart';
import 'package:investement_app/core/utils/app_utils.dart';
import 'package:investement_app/gen/assets.gen.dart';

enum CustomTextFieldType { phone, email, password, name, text }

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String label;
  final Widget? icon;
  final Function(String)? onChanged;
  final bool? obscureText;
  final String? obsecuringCharacter;
  final TextInputType? keyboardType;
  final CustomTextFieldType? type;
  final TextEditingController? textEditingController;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintTextStyle;
  final BoxConstraints? prexixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final double? top;
  final double? bottom;
  final double? end;
  final double? start;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final bool? customValidation;
  final TextStyle? inputTextStyle;
  final Color borderColor;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.obsecuringCharacter = "*",
    this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.type = CustomTextFieldType.text,
    this.maxLines = 1,
    required this.prefixIcon,
    this.suffixIcon,
    required this.label,
    this.hintTextStyle,
    this.prexixIconConstraints,
    this.suffixIconConstraints,
    this.top,
    this.bottom,
    this.end,
    this.start,
    this.validator,
    this.isReadOnly,
    this.customValidation = false,
    this.borderColor = AppColors.blue,
    this.inputTextStyle, // Add the new parameter
  });
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObsecured;
  final FocusNode _focusNode = FocusNode();
  bool _hasValidationError = false;
  String? _errorMessage;
  @override
  void initState() {
    isObsecured = widget.obscureText ?? false;
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void togglePasswordVisibility() {
    setState(() {
      isObsecured = !isObsecured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(
            top: widget.top ?? (AppScreenUtils.isTablet ? 8 : 4),
            end: widget.end ?? 23,
            bottom: widget.bottom ?? (AppScreenUtils.isTablet ? 8 : 4),
            start: widget.start ?? 11,
          ),
          child: TextFormField(
            cursorHeight: 22,
            readOnly: widget.isReadOnly ?? false,
            onTap: () {
              setState(() {
                _focusNode.requestFocus();
              });
            },
            focusNode: _focusNode,
            validator: (value) {
              //handle custom validation by helmy(11/11/2024)
              if (widget.customValidation == true) {
                return widget.validator?.call(value);
              } else if (value?.isEmpty ?? true) {
                setState(() {
                  _hasValidationError = true;
                  _errorMessage = "الحقل مطلوب";
                });
                return "";
              }
              final validationResult = widget.validator?.call(value);
              setState(() {
                _hasValidationError = validationResult != null;
                _errorMessage = validationResult;
              });
              return validationResult;
            },
            maxLines: widget.maxLines,
            obscureText: isObsecured,
            obscuringCharacter: "*",
            enableSuggestions: true,
            controller: widget.textEditingController,
            style: AppTextStyles.hevoLight20WhitekW100,
            cursorColor: AppColors.whiteBlack,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              filled: false,
              fillColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(.3),
              errorStyle: const TextStyle(fontSize: 0),
              prefixIconConstraints: widget.prexixIconConstraints ??
                  const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                    maxWidth: 50,
                    maxHeight: 50,
                  ),
              contentPadding: EdgeInsetsDirectional.only(
                start: widget.start ?? 15,
                end: widget.end ?? 15,
                top: widget.top ?? (AppScreenUtils.isTablet ? 8 : 4),
                bottom: widget.bottom ?? (AppScreenUtils.isTablet ? 8 : 4),
              ),
              labelText: _focusNode.hasFocus ? widget.label : widget.hintText,
              labelStyle: _focusNode.hasFocus
                  ? AppTextStyles.hevoLight15WhiteBlackW500
                  : AppTextStyles.hevoLight15WhiteBlackW500,
              hintText: widget.hintText,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.prefixIcon,
              ),
              hintStyle: widget.hintTextStyle ??
                  AppTextStyles.hevoLight15WhiteBlackW500,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      _hasValidationError ? AppColors.red : widget.borderColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.grey,
                  width: 1.5,
                ),
              ),
              suffixIconConstraints: widget.suffixIconConstraints ??
                  BoxConstraints(
                    minWidth: AppScreenUtils.isTablet ? 20 : 20,
                    minHeight: AppScreenUtils.isTablet ? 25 : 25,
                    maxWidth: AppScreenUtils.isTablet ? 20 : 20,
                    maxHeight: AppScreenUtils.isTablet ? 25 : 25,
                  ),
              suffixIcon: checkAboutSuffixIcon(),
            ),
          ),
        ),
        if (_hasValidationError && _errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10),
            child: Text(
              _errorMessage!,
              style: AppTextStyles.hevoLight11redw400,
            ),
          ),
      ],
    );
  }

  ///make check if the suffix icon is specified or no , if so then it will be returned and if not then make another check if the obsecure text is set to true and if so then it will provide a button to toggle the obsecure
  Widget? checkAboutSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    } else if (widget.obscureText == true) {
      return GestureDetector(
        onTap: () {
          togglePasswordVisibility();
        },
        child: Padding(
          padding: const EdgeInsets.only(
              right: 20), // Add 20 spacing from the border
          child: Container(
            width: 30, // Ensure the icon retains its size
            height: 30,
            alignment: Alignment.center, // Center the icon
            child: isObsecured
                ? Assets.images.icons.eyeDisabled
                    .svg(height: 20, width: 20, color: Colors.black)
                : Assets.images.icons.eyeEnabled
                    .svg(height: 20, width: 20, color: Colors.blue),
          ),
        ),
      );
    }
    return null;
  }
}
