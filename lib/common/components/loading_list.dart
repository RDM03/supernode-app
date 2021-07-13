import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).brightness == Brightness.light
                ? greyColorShade300
                : blackColor12,
            highlightColor: Theme.of(context).brightness == Brightness.light
                ? greyColorShade100
                : whiteColor70,
            child: Column(
              children: [0, 1, 2, 3, 5]
                  .map((_) => Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              child: Container(
                                width: double.infinity,
                                height: 18.0,
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: <Widget>[
                                // ClipOval(
                                //   child: Container(
                                //     width: 22.0,
                                //     height: 22.0,
                                //     color: whiteColor,
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 8,
                                // ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  child: Container(
                                    width: 40.0,
                                    height: 14.0,
                                    color: whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  child: Container(
                                    width: 40.0,
                                    height: 14.0,
                                    color: whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  child: Container(
                                    width: 40.0,
                                    height: 14.0,
                                    color: whiteColor,
                                  ),
                                ),
                                Spacer(),
                                // Icon(
                                //   FontAwesomeIcons.comment,
                                //   size: 16.0,
                                //   color: greyColor,
                                // ),
                                SizedBox(
                                  width: 4,
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  child: Container(
                                    width: 20.0,
                                    height: 14.0,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color:
                                  ColorsTheme.of(context).textPrimaryAndIcons,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )),
    );
  }
}
