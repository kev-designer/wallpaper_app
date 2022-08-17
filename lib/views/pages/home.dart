import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wallpaper_app/models/tranding_model.dart';
import 'package:wallpaper_app/services/api_services.dart';
import 'package:wallpaper_app/views/pages/search.dart';
import 'package:wallpaper_app/widgets/app_bar.dart';
import 'package:wallpaper_app/widgets/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/widgets/const.dart';

import 'image_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  TrendyApiServices trendyApiServices = TrendyApiServices();

  @override
  void initState() {
    trendyApiServices;
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //SEARCH
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: ColorData.white.withOpacity(.08),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SearchPage(
                              searchQuery: searchController.text,
                            )),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: SvgPicture.asset(
                      "assets/svg/search.svg",
                      height: 20,
                      color: ColorData.white,
                    ),
                  ),
                ),
                enabled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                hintText: "Search Wallpaper...",
                hintStyle: GoogleFonts.nunito(
                  color: ColorData.white,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cursorColor: ColorData.white,
              style: GoogleFonts.nunito(
                color: ColorData.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            20.heightBox,

            Expanded(
              child: FutureBuilder<TrendyModel>(
                future: trendyApiServices.getTrendyWallpaperApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data?.photos?.length,
                      itemBuilder: (context, index) {
                        Photos? photos = snapshot.data?.photos?[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => ImageView(
                                          original: snapshot.data!
                                              .photos![index].src!.original
                                              .toString(),
                                        )),
                                  ),
                                );
                              },
                              child: Container(
                                height: height(context) * .25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.04),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      photos?.src?.original.toString() ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return SpinKitFadingCircle(
                      color: ColorData.white,
                      controller: animationController,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
