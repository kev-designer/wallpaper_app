import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wallpaper_app/widgets/colors.dart';

//BACK ARROW ICON
AppBar buildAppBar(String appbarTitle, BuildContext context) {
  return AppBar(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: ColorData.white,
      ),
    ),
    title: Text(
      appbarTitle,
      style: GoogleFonts.nunito(
        color: ColorData.white,
      ),
    )
        .text
        .xl2
        .semiBold
        .maxLines(1)
        .softWrap(true)
        .overflow(TextOverflow.ellipsis)
        .make(),
  );
}

//MAIN APP BAR
AppBar buildMainAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: ColorData.black,
    title: Text(
      "Wallpaper App",
      style: GoogleFonts.nunito(color: ColorData.white),
    ).text.xl2.semiBold.make(),
  );
}

//ALL APP BAR PAGES
AppBar buildAllNewsAppBar(BuildContext context) {
  return AppBar(
    title: HStack(
      [
        Text(
          "Wallpaper",
          style: GoogleFonts.nunito(color: ColorData.primary),
        ).text.xl2.semiBold.make(),
        Text(
          "App",
          style: GoogleFonts.nunito(color: ColorData.secondary),
        ).text.xl2.semiBold.make(),
      ],
    ),
    elevation: 0,
    backgroundColor: ColorData.white,
    bottom: TabBar(
      isScrollable: true,
      labelStyle: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
      ),
      labelColor: ColorData.primary,
      unselectedLabelColor: ColorData.grey,
      indicator: MaterialIndicator(
        horizontalPadding: 16,
        topLeftRadius: 10,
        topRightRadius: 10,
        color: ColorData.primary,
      ),
      tabs: [
        Tab(
          child: Text(
            "Apple News",
            style: GoogleFonts.nunito(),
          ).text.lg.make(),
        ),
        Tab(
          child: Text(
            "Tesla News",
            style: GoogleFonts.nunito(),
          ).text.lg.make(),
        ),
        Tab(
          child: Text(
            "Top Headlines",
            style: GoogleFonts.nunito(),
          ).text.lg.make(),
        ),
        Tab(
          child: Text(
            "TechCrunch",
            style: GoogleFonts.nunito(),
          ).text.lg.make(),
        ),
        Tab(
          child: Text(
            "Wall Street Journal",
            style: GoogleFonts.nunito(),
          ).text.lg.make(),
        ),
      ],
    ),
  );
}
