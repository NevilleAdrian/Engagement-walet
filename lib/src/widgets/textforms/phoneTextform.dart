import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/values/radii.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

typedef String? ValidatorCallback(String? value);
typedef OnChangedCallback(String value);
typedef OnTapCallback();

class PhoneTextForm extends StatefulWidget {

  const PhoneTextForm(
      {Key? key,
      this.controller,
      this.validatorCallback,
      this.onChangedCallback,
      this.onTap,
      this.focusNode,
      this.contentPadding,
      this.fillColor,
      this.errorText,
      this.labelText,
      this.hintText,
      this.hintSize,
      this.textColor,
      this.labelColor,
      this.hintColor,
      this.textAlignVertical,
      this.prefixText,
      this.inputFormatter,
      this.borderColor,
        this.useDefaultSuffix = false,

        this.focusBorderColor,
      this.prefixColor,
      this.suffix,
      this.prefix,
      this.maxLength,
      this.padding,
      required this.text,
        required this.textInputType,


      })
      : super(key: key);

  final TextEditingController? controller;
  final ValidatorCallback? validatorCallback;
  final OnChangedCallback? onChangedCallback;
  final OnTapCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType textInputType;

  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final double? hintSize;
  final Color? textColor;
  final bool useDefaultSuffix;

  final Color? labelColor;

  final Color? hintColor;

  final TextAlignVertical? textAlignVertical;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatter;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? prefixColor;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final EdgeInsets? padding;
  final String text;

  @override
  State<PhoneTextForm> createState() => _PhoneTextFormState();
}

class _PhoneTextFormState extends State<PhoneTextForm> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text, style: textStyle400Small),
        kVerySmallHeight,
        IntlPhoneField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          disableLengthCheck: true,
          cursorColor: secondaryColor,
          decoration: InputDecoration(
            // labelText: 'Phone Number',
            fillColor: lightGreyColor,
            filled: true,
            prefixIcon: widget.prefix,
            suffixIcon: widget.useDefaultSuffix
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: secondaryColor,
                      ),
                    ],
                  )
                : widget.suffix,
            prefixText: widget.prefixText != null ? '${widget.prefixText} ' : '',
            prefixStyle: theme.textTheme.bodyText2!.copyWith(
                color: widget.prefixColor ?? theme.textTheme.bodyText2!.color,
               ),
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: Radii.k10pxRadius,
              borderSide: BorderSide(color: secondaryColor, width: 1.0),
            ),
            hintStyle: theme.primaryTextTheme.bodyText2!.copyWith(
              color: theme.inputDecorationTheme.hintStyle!.color,
            ),
            border: OutlineInputBorder(
              borderRadius: Radii.k10pxRadius,
              borderSide: BorderSide(
                  color: theme.inputDecorationTheme.border!.borderSide.color),
            ),
          ),

          initialCountryCode: 'NG',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ),
      ],
    );
  }
}
