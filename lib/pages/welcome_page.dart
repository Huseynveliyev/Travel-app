import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveler_app/misc/colors.dart';
import 'package:traveler_app/widgets/app_large_text.dart';

import '../misc/cubit/app_cubits.dart';
import '../widgets/app_text.dart';
import '../widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    'welcome-one.png',
    'welcome-two.png',
    'welcome-three.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
            itemCount: images.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/" + images[index],
                      ),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Trips"),
                          AppText(
                            text: "Mountain",
                            size: 30,
                          ),
                          SizedBox(height: 18),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: AppText(
                              text:
                                  "Mountain hikes give you an incredible sense of freedom along with endurance tests",
                              color: AppColors.textColor2,
                              size: 14,
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<AppCubits>(context).getData();
                            },
                            child: Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    ResponsiveButton(width: 120),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: List.generate(3, (indexDots) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 2),
                            width: 8,
                            height: index == indexDots ? 25 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? AppColors.mainColor
                                  : AppColors.mainColor.withOpacity(0.3),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
