import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveler_app/misc/colors.dart';
import 'package:traveler_app/misc/cubit/app_cubit_state.dart';
import 'package:traveler_app/misc/cubit/app_cubits.dart';
import 'package:traveler_app/widgets/app_large_text.dart';
import 'package:traveler_app/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling"
  };
  @override
  Widget build(BuildContext context) {
    //tabbar controller
    TabController _tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            if (state is LoadedState) {
              var info = state.places;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Header
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, size: 30, color: Colors.black54),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                            image: DecorationImage(
                              image: AssetImage('images/hacker.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  //discover text
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: AppLargeText(text: "Discover"),
                  ),
                  SizedBox(height: 20),

                  // tabbar container
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        labelPadding: EdgeInsets.only(left: 20, right: 15),
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: CircleTabIndicator(
                            color: AppColors.mainColor, radius: 4),
                        tabs: [
                          Tab(text: "Places"),
                          Tab(text: "Inspiration"),
                          Tab(text: "Emotions"),
                        ],
                      ),
                    ),
                  ),
                  //tabbarview container
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    height: 300,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: info.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context)
                                    .detailPage(info[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'http://mark.bslmeiyu.com/uploads/' +
                                              info[index].img),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                        ),
                        Text('Sagol'),
                        Text('Hardasan'),
                      ],
                    ),
                  ),

                  //Explore more
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(text: "Explore more", size: 19),
                        AppText(
                          text: "See all",
                          color: AppColors.textColor1,
                          size: 12,
                        )
                      ],
                    ),
                  ),

                  Container(
                    height: 120,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 25),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('images/' +
                                            images.keys.elementAt(index)))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: AppText(
                                  text: images.values.elementAt(index),
                                  size: 12,
                                  color: AppColors.textColor2,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
