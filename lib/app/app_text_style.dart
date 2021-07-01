import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textFieldText = GoogleFonts.notoSans(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textFieldTextGray = GoogleFonts.notoSans(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w500,
  );
  
  static final TextStyle titleBold = GoogleFonts.notoSans(
    color: AppColors.darkGrey,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
  
  static final TextStyle titleBoldMobile = GoogleFonts.notoSans(
    color: AppColors.darkGrey,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle buttonText = GoogleFonts.notoSans(
    color: AppColors.darkGrey,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle textFieldTextError = GoogleFonts.notoSans(
    color: AppColors.darkRed,
    fontWeight: FontWeight.w500,
  );
}