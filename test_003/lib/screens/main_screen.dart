import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test_003/utils/assets.dart';

import 'main_screen_widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool tabIsLeft = false;

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'See All ${imgList.indexOf(item)}/${imgList.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  changeTab() {
    if (_tabController.index == 0) {
      setState(() {
        tabIsLeft = true;
      });
    } else {
      setState(() {
        tabIsLeft = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            // 1st logos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Image.asset(CURRENCY_ICON)),
                    IconButton(
                        onPressed: () {}, icon: Image.asset(CHATACTIVE_ICON)),
                  ],
                )
              ],
            ),

            // Title name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Furama Riverfront, Singapore',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      )),
                ],
              ),
            ),

            // Address
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '405 Haveloack Road, Singapoer 169633',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(CURRENTLOCATION_ICON)),
                ],
              ),
            ),

            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconWithTextWidget(THEME_ICON, 'Amenities'),
                IconWithTextWidget(WORKOUT_ICON, 'Facilities'),
                IconWithTextWidget(FNB_ICON, 'F&B'),
                IconWithTextWidget(KIDSFAMILY_ICON, 'Kids/family'),
                IconWithTextWidget(WELLNESS_ICON, 'Wellness'),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // TabBar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
              ),
              child: TabBar(
                onTap: (index) {
                  changeTab();
                },
                controller: _tabController,
                indicator: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'By Room',
                  ),
                  Tab(
                    text: 'By Rates',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Tabbar View
            Container(
              height: 600,
              child: TabBarView(controller: _tabController, children: [
                // By Room Widgets
                Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://i.picsum.photos/id/536/200/300.jpg?hmac=emqhVKhR4nH8HnJQlumZfZBLPCgSkpGqQA-_Ypt55eo',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Deluxe Twin',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Twin Single Beds, Cabel TV,',
                                // 'Twin Single Beds, Cabel TV, Free Wifi, Free Gym , Free Bearkfats',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.orange),
                            ),
                            child: const Text(
                              'View Rates',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Avg.Nightly/ Room From',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'SGD',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                '161.42',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 3,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),

                // By Rates widgets
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'YOUR E-VOUCHER RATE',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Mobile App Special Voucher',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconWithTextWidget(
                                          FNB_ICON, 'Inclusive of Breakfast'),
                                      IconWithTextWidget(DISCOUNT_ICON,
                                          '20% off In-Room Service'),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.orange),
                                        ),
                                        child: const Text(
                                          'View Rates',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    height: 3,
                                    thickness: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            'Avg.Nightly/ Room From',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            'Subject to GST & Service Charge',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'SGD',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '161.42',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    color: Colors.yellow,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(GENERIC_ICON),
                                        const Text(
                                          'MEMBERS DEALS',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Weekend Staycation',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconWithTextWidget(
                                          FNB_ICON, 'Inclusive of Breakfast'),
                                      IconWithTextWidget(DISCOUNT_ICON,
                                          '20% off In-Room Service'),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.orange),
                                        ),
                                        child: const Text(
                                          'View Rates',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    height: 3,
                                    thickness: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            'Avg.Nightly/ Room From',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            'Subject to GST & Service Charge',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'SGD',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '161.42',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    color: Colors.yellow,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(GENERIC_ICON),
                                        const Text(
                                          'MEMBERS DEALS',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
