import 'package:flutter/material.dart';

class TextfiledHelper extends StatelessWidget {
  final TextEditingController ctr;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final IconData? icon;
  final IconData? suffixIcon;
  final Function(String) onChange;
  final Function()? onSuffixTap;
  final String hintText;
  final bool dividerIsVisible;
  final bool obscureText;
  const TextfiledHelper({
    super.key,
    required this.ctr,
    required this.focusNode,
    required this.onChange,
    required this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.dividerIsVisible = true,
    this.obscureText = false,
    this.onSuffixTap,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          if (icon != null) SizedBox(width: 10),
          if (icon != null) Icon(icon, color: Colors.blueGrey),
          if (dividerIsVisible && icon != null) SizedBox(width: 10),
          if (dividerIsVisible && icon != null)
            Container(width: 1.5, height: 50, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: ctr,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: (value) => onChange,
              focusNode: focusNode,
              onTapOutside: (event) => focusNode.unfocus(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          if (suffixIcon != null) SizedBox(width: 10),
          if (suffixIcon != null)
            InkWell(
              onTap: () {
                if (onSuffixTap != null) {
                  onSuffixTap!();
                }
              },
              child: Icon(suffixIcon, color: Colors.blueGrey),
            ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
