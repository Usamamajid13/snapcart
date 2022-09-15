import 'package:flutter/material.dart';
import 'package:snapcart/Constants/constants.dart';

class AppUtils {
  largeLabelTextStyle({color}) {
    return TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w600);
  }

  smallHeadingTextStyle({color}) {
    return TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 14);
  }

  smallLableTextStyle({color}) {
    return TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 14);
  }

  smallTitleTextStyle({color}) {
    return TextStyle(color: color, fontSize: 14);
  }

  bigButton(
      {width,
      height,
      borderColor,
      onTap,
      borderWidth,
      borderRadius,
      containerColor,
      text,
      shadowColors,
      textColor,
      fontSize,
      fontWeight}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth == null ? 2 : borderWidth.toDouble()),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          color: containerColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 3),
              color: shadowColors ?? Colors.black.withOpacity(0.2),
              blurRadius: 4,
            )
          ],
        ),
        child: Center(
          child: Text(
            text.toString(),
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: fontSize == null ? 13.0 : fontSize.toDouble(),
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  textField(
      {controller,
      hintText,
      width,
      fontSize,
      obscureText,
      labelText,
      labelColor,
      suffixIcon,
      validator,
      onChange}) {
    return SizedBox(
      width: width,
      // height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: labelColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            // height: 40,
            child: TextFormField(
              onChanged: onChange,
              validator: validator,
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  suffixIconColor: purpleColor,
                  contentPadding: const EdgeInsets.only(top: 5, left: 15),
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: fontSize,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: purpleColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: purpleColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
