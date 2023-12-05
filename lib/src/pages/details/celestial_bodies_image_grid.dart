import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/services/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';

class CelestialBodiesImageGrid extends StatelessWidget {
  const CelestialBodiesImageGrid({
    super.key,
    required this.celestialBodyId,
  });

  final int celestialBodyId;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CelestialBodyPhoto>>(
      future: DBHelper.getCelestialBodyPhotos(celestialBodyId),
      builder: (BuildContext context,
          AsyncSnapshot<List<CelestialBodyPhoto>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Image.asset("assets/images/ckram.gif");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text("Gallery", style: theme.textTheme.headlineMedium),
              GridView.builder(
                shrinkWrap: true,
                clipBehavior: Clip.hardEdge,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildFirstItem(context);
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/image', arguments: snapshot.data![index].imagePath);
                        
                      },
                      child: GridAnimatorWidget(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Hero(
                              tag: snapshot.data![index].imagePath,
                              child: ExtendedImage.file(
                                File(snapshot.data![index].imagePath),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                                cacheHeight: 1000,
                                cacheWidth: 1000,
                                scale: 0.1,
                                enableLoadState: true,
                                loadStateChanged: (ExtendedImageState state) {
                                  switch (state.extendedImageLoadState) {
                                    case LoadState.loading:
                                      //_controller.reset();
                                      return Image.asset(
                                        "assets/images/ckram.gif",
                                        fit: BoxFit.cover,
                                      );
                                    //break;
                                            
                                    case LoadState.completed:
                                      // _controller.forward();
                                      return GestureDetector(
                                        onTap: () {},
                                        child: ExtendedRawImage(
                                          image: state.extendedImageInfo?.image,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    //break;
                                    case LoadState.failed:
                                      return GestureDetector(
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/images/error.png",
                                              fit: BoxFit.cover,
                                            ),
                                            const Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Text(
                                                "load image failed, click to reload",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          state.reLoadImage();
                                        },
                                      );
                                    // break;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ).animate().fadeIn(duration: const Duration(milliseconds: 600), curve: Curves.ease),
                    );
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildFirstItem(BuildContext context) {
    return GridAnimatorWidget(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: GestureDetector(
            onTap: () {
              ImagePickerService(context)
                  .openSinglePickerDialog(celestialBodyId);
            },
            child: Container(
              color: const Color(0XFFF9DB80), // Replace with your color
              child: const Center(
                child: Icon(
                  LineIcons.plus,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
