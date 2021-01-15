import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color primaryColor2 = Color(0xFF000000);
final Color secondaryColor = Colors.brown;
final Color secondaryColor2 = Colors.brown[200];

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.nunito(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.nunito(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.nunito(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.nunito(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.nunito(fontSize: 23, fontWeight: FontWeight.w700),
  headline6: GoogleFonts.nunito(
      fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 0.15),
  subtitle1: GoogleFonts.nunito(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle2: GoogleFonts.nunito(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.lora(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.lora(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.lora(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.lora(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.lora(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
