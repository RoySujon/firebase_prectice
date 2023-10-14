import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    this.fillColor = Colors.white,
    this.hintText = 'Hint text',
    this.obscureText = false,
    this.controller,
    this.labelText,
    required this.errorText,
    this.prefixIcon,
    this.keyboardType,
    this.maxLine = 1,
    this.borderColor = Colors.transparent,
    this.onChanged,
  });
  final TextInputType? keyboardType;
  final Color fillColor;
  final String hintText, errorText;
  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final int? maxLine;
  final Color borderColor;
  final Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: TextFormField(
        onChanged: onChanged,
        maxLines: maxLine,
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          } else {
            return null;
          }
        },
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          fillColor: fillColor,
          label: labelText == null ? null : Text(labelText!),
          filled: true,
          // counterText: 'GKSKS',
          // suffixIcon: Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: Icon(
          //     Icons.check,
          //     color: Colors.green,
          //   ),
          // ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}

class RowTextWithButton extends StatelessWidget {
  const RowTextWithButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.metrophobic(),
          ),
          IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_right_alt,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.red,
    this.textColor = Colors.white,
    this.loading = true,
  });
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      elevation: 0,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 0, color: Colors.transparent)),
      color: color,
      onPressed: onTap,
      textColor: textColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: loading
            ? Text(text)
            : Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                )),
      ),
    );
  }
}

class LoginButtonWithSocialMedia extends StatelessWidget {
  const LoginButtonWithSocialMedia(
      {super.key, required this.googleButton, required this.facebookButton});
  final VoidCallback googleButton;
  final VoidCallback facebookButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Or login with social account'),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: googleButton,
              child: const CustomIconButton(
                icon: Icons.email,
              ),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: facebookButton,
              child: CustomIconButton(
                icon: Icons.facebook_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 87),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
        child: Icon(icon),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: GoogleFonts.metrophobic(
                fontSize: 34, fontWeight: FontWeight.bold),
          )),
    );
  }
}
