import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wallpaper_app/widgets/buttons.dart';
import 'package:wallpaper_app/widgets/colors.dart';

class ImageView extends StatefulWidget {
  String original;
  ImageView({required this.original, Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor.withOpacity(.04),
              image: DecorationImage(
                image: NetworkImage(widget.original),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            bottom: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.nunito(
                        color: ColorData.white,
                      ),
                    ).text.lg.semiBold.make(),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: FilledButton(
                    textName: "Save Image",
                    onPressed: () {
                      _save();
                    },
                    buttonColor: ColorData.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    // if (Platform.isIOS) {
    //   await _askPermission();
    // }

    var response = await Dio().get(widget.original,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    Navigator.pop(context);
  }

  // Future<void> _setWallpaper() async {
  //   int location = WallpaperManagerFlutter.HOME_SCREEN;
  //   // var file = await DefaultCacheManager().getSingleFile(widget.original);
  //   var file = await DefaultCacheManager().getSingleFile(widget.original);
  //   // String result = await WallpaperManagerFlutter()
  //   //     .setwallpaperfromFile(cachedimage, location);
  //   WallpaperManagerFlutter().setwallpaperfromFile(file, location);
  // }

  // Future<void> _setWallpaper(location) async {
  //   var file = await DefaultCacheManager().getSingleFile(widget.original);
  //   try {
  //     WallpaperManagerFlutter().setwallpaperfromFile(file, location);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Wallpaper updated'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Error Setting Wallpaper'),
  //       ),
  //     );
  //   }
  // }

}
