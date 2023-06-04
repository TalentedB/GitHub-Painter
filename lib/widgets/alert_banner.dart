import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

import '../styles/typography.dart';

void showAlert(BuildContext context, String message, bool errorColor) {
  showAlertBanner(
    context,
    () {},
    MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: errorColor ? const Color(0xffFF6D60) : const Color(0xff98D8AA),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          message,
          style: font2.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
    alertBannerLocation: AlertBannerLocation.bottom,
    maxLength: MediaQuery.of(context).size.width / 3,
    durationOfStayingOnScreen: const Duration(milliseconds: 7000),
  );
}
