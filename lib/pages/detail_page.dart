import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveler_app/misc/colors.dart';
import 'package:traveler_app/misc/cubit/app_cubit_state.dart';
import 'package:traveler_app/misc/cubit/app_cubits.dart';
import 'package:traveler_app/widgets/app_large_text.dart';
import 'package:traveler_app/widgets/app_text.dart';
import 'package:traveler_app/widgets/responsive_button.dart';

import '../widgets/app_buttons.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return SafeArea(
        child: Scaffold(
          body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://mark.bslmeiyu.com/uploads/' +
                                  detail.place.img,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Positioned(
                    left: 20,
                    top: 15,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 17),
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: detail.place.name,
                                size: 24,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              AppLargeText(
                                text: "\$" + detail.place.price.toString(),
                                size: 20,
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(width: 5),
                              AppText(
                                text: detail.place.location,
                                color: AppColors.textColor1,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < detail.place.stars
                                        ? AppColors.starColor
                                        : AppColors.textColor1,
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: "(5.0)",
                                color: AppColors.textColor1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          AppLargeText(
                            size: 20,
                            text: "People",
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(height: 5),
                          AppText(
                            text: "Number of people in your group",
                            size: 14,
                          ),
                          Wrap(
                            children: List.generate(
                              5,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 14, top: 10),
                                    child: AppButtons(
                                        size: 50,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        backgroundColor: selectedIndex == index
                                            ? Colors.black
                                            : AppColors.buttonBackgroundColor,
                                        borderColor: selectedIndex == index
                                            ? Colors.black
                                            : AppColors.buttonBackgroundColor,
                                        text: (index + 1).toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          AppLargeText(
                            text: "Description",
                            size: 18,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: 80,
                            child: AppText(
                              text: detail.place.description,
                              size: 14,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                AppButtons(
                                  size: 50,
                                  color: AppColors.textColor2,
                                  backgroundColor: Colors.white,
                                  borderColor: AppColors.textColor2,
                                  isIcon: true,
                                  icon: Icons.favorite_border,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                ResponsiveButton(
                                  isResponsive: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
