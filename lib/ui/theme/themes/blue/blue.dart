import 'package:flutter/material.dart';
import 'package:insta_following/ui/theme/app_theme_data.dart';
import 'package:insta_following/ui/theme/iapp_colors.dart';
import 'package:insta_following/ui/theme/iapp_text_styles.dart';
import 'package:insta_following/ui/theme/theme_utils.dart';




class BlueThemeColors extends IAppColors {
  @override
  Color get accent => Color(0xff0095ff);
  @override
  Color get canvasDark => Color(0xffdfe6f1);
  @override
  Color get canvas => Color(0xffedf1f7);
  @override
  Color get canvasLight => Color(0xffffffff);
  @override
  Color get disabled => Color(0xff8f9bb3);
  @override
  Color get divider => Color(0xffd1dbeb);
  @override
  Color get success => Color(0xff3dc954);
  @override
  Color get error => Color(0xfff54d53);
  @override
  Color get warning => Color(0xfff47d34);
  @override
  Color get info => primary;
  @override
  Color get fontDark => Color(0xff222B45);
  @override
  Color get font => Color(0xff444A59);
   @override
  Color get fontPale => Color(0xff7F889B);
  @override
  Color get fontLight => Color(0xffffffff);
  @override
  Color get primary => Color(0xff0095ff);
  @override
  Color get primaryPale => primary.withOpacity(0.8);

  @override
  Color get unselectedWidgetColor => Color(0xff8f9bb3);
  @override
  Color get toggleableActiveColor => primary;
  //Inkwell
  @override
  Color get splash => Color(0xffc5cee0).withOpacity(0.5);
  @override
  Color get highlight => Color(0xffc5cee0).withOpacity(0.2);
}

class BlueThemeTextStyles extends IAppTextStyles {
  BlueThemeTextStyles(this.data, this.colors);
  ThemeData data;
  IAppColors colors;
  @override
  TextStyle get emptyBackroundHint => data.textTheme.headline6.copyWith(color: colors.primary.withOpacity(0.3));
}

AppThemeData buildBlueTheme(BuildContext context) {
  //appbar spesific copy
  TextTheme _appBarTextTheme(
    TextTheme base,
    Color color,
    String fontFamily,
  ) {
    return ThemeUtils.textThemeCopyWith(base, color, fontFamily).copyWith(
      headline6: base.headline6.copyWith(
        color: color,
        fontSize: base.headline6.fontSize,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
    );
  }

  var fontFamily = 'Roboto';
  var buttonBorderRadius = BorderRadius.circular(4);
  var textBorderRadius = BorderRadius.circular(4);
  var cardBorderRadius = BorderRadius.circular(0);
  var appColors = BlueThemeColors();
  var baseTheme = Theme.of(context);
  var newTheme = ThemeData(
    fontFamily: fontFamily,
    primaryColor: appColors.primary,
    primaryColorLight: appColors.primary,
    primaryColorDark: appColors.primary,
    primaryColorBrightness: Brightness.dark,
    accentColor: appColors.accent,
    accentColorBrightness: Brightness.dark,
    canvasColor: appColors.canvas,
    scaffoldBackgroundColor: appColors.canvas,
    highlightColor: appColors.highlight,
    splashColor: appColors.splash,
    dialogBackgroundColor: appColors.canvas,
    errorColor: appColors.error,
    indicatorColor: appColors.primary,
    cursorColor: appColors.primary,
    unselectedWidgetColor: appColors.unselectedWidgetColor,
    toggleableActiveColor: appColors.toggleableActiveColor,

    toggleButtonsTheme: ToggleButtonsThemeData(
      constraints: BoxConstraints(minWidth: kMinInteractiveDimension, minHeight: kMinInteractiveDimension * 0.8),
      borderRadius: buttonBorderRadius,
      color: appColors.font,
      selectedColor: appColors.primary,
      disabledColor: appColors.disabled,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0.5,
    ),

    chipTheme: ChipThemeData.fromDefaults(
      labelStyle: baseTheme.textTheme.bodyText2,
      primaryColor: appColors.primary,
      secondaryColor: Color(0xffe8600d),
    ),
    textSelectionHandleColor: appColors.primary,
    popupMenuTheme: PopupMenuThemeData(elevation: 0.5),
    floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0.5),
    dividerTheme: DividerThemeData(color: appColors.divider),
    tabBarTheme: TabBarTheme(
      labelColor: appColors.canvasLight,
      // unselectedLabelColor: appColors.fontPale,
    ),

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: appColors.canvasLight),
      textTheme: _appBarTextTheme(baseTheme.primaryTextTheme, appColors.canvasLight, fontFamily),
      color: appColors.primary,
      elevation: 0.5,
      brightness: Brightness.dark,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: appColors.canvasLight,
      elevation: 0.5,
    ),
    buttonTheme: NButtonThemeData(
      highlightColor: Colors.white24,
      splashColor: Colors.white30,
      raisedButtonElevation: 0.5,
      buttonColor: appColors.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
    ),
    cardTheme: CardTheme(
      color: appColors.canvasLight,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: baseTheme.textTheme.bodyText2.copyWith(color: appColors.font),
        backgroundColor: appColors.canvasLight,
        elevation: 4,
        actionTextColor: appColors.primary),

    textTheme: ThemeUtils.textThemeCopyWith(baseTheme.textTheme, appColors.font, fontFamily),
    primaryTextTheme: ThemeUtils.textThemeCopyWith(baseTheme.primaryTextTheme, appColors.font, fontFamily),
    accentTextTheme: ThemeUtils.textThemeCopyWith(baseTheme.accentTextTheme, appColors.fontLight, fontFamily),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: appColors.fontPale),
      hintStyle: TextStyle(color: appColors.fontPale.withOpacity(0.7)),
      helperStyle: TextStyle(color: appColors.fontPale),
      prefixStyle: TextStyle(color: appColors.fontPale),
      suffixStyle: TextStyle(color: appColors.fontPale),
      counterStyle: TextStyle(color: appColors.fontPale),
      errorStyle: TextStyle(color: appColors.error.withOpacity(0.7)),
      contentPadding: EdgeInsets.all(10),
      
      fillColor: appColors.canvas,
      filled: true,
      isDense: true,
      border: ThemeUtils.inputBorder(
        appColors.canvasDark,
        textBorderRadius,
      ),
      focusedBorder: ThemeUtils.inputBorder(
        appColors.primary.withOpacity(0.3),
        textBorderRadius,
      ),
      enabledBorder: ThemeUtils.inputBorder(
        appColors.canvasDark,
        textBorderRadius,
      ),
      errorBorder: ThemeUtils.inputBorder(
        appColors.error.withOpacity(0.3),
        textBorderRadius,
      ),
      focusedErrorBorder: ThemeUtils.inputBorder(
        appColors.error.withOpacity(0.5),
        textBorderRadius,
      ),
      disabledBorder: ThemeUtils.inputBorder(
        appColors.disabled.withOpacity(0.5),
        textBorderRadius,
      ),
    ),
    // snackBarTheme: baseTheme.snackBarTheme.copyWith(
    //     contentTextStyle: baseTheme.snackBarTheme.contentTextStyle
    //         .copyWith(color: appColors.fontDark)),
    colorScheme: ColorScheme(
      background: appColors.canvas,
      brightness: Brightness.light,
      error: appColors.error,
      primary: appColors.primary,
      primaryVariant: appColors.primary,
      secondary: appColors.accent,
      secondaryVariant: appColors.accent,
      surface: appColors.canvasLight,
      onBackground: appColors.font,
      onError: appColors.fontLight,
      onPrimary: appColors.fontLight,
      onSecondary: appColors.fontLight,
      onSurface: appColors.font,
    ),

    primaryIconTheme: IconThemeData(color: appColors.canvasLight),
    accentIconTheme: IconThemeData(color: appColors.canvasLight),
    iconTheme: IconThemeData(color: appColors.primary),
    //use cupertino slide effect
    // pageTransitionsTheme: PageTransitionsTheme(builders: {
    //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //   TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    // }),
  );

  return AppThemeData(newTheme, appColors, BlueThemeTextStyles(newTheme, appColors));
}
