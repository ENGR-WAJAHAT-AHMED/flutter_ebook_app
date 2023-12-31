import 'dart:convert';

import 'package:ebook_app/app_colors.dart';
import 'package:ebook_app/my_tabs.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBook = [];
  List books = [];
  List sequenceBooks = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBook = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/sequencebooks.json")
        .then((s) {
      setState(() {
        sequenceBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.apps,
                        size: 24,
                        color: Colors.black,
                      )),
                  // Expanded(child: Container()),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_active,
                            size: 20,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Popular Books',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: -20,
                    child: Container(
                      height: 180,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount:
                              popularBook == null ? 0 : popularBook.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: AssetImage(popularBook[i]["img"]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColor.silverBackground,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, left: 10),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(0),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          tabs: [
                            AppTabs(color: AppColor.menu1Color, text: 'New'),
                            AppTabs(
                                color: AppColor.menu2Color, text: 'Popular'),
                            AppTabs(
                                color: AppColor.menu3Color, text: 'Trending'),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(controller: _tabController, children: [
                ListView.builder(
                    itemCount: books == null ? 0 : books.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.tabVarViewColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(books[i]["img"]))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColor.starColor,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          books[i]["rating"],
                                          style: TextStyle(
                                              color: AppColor.menu2Color),
                                        )
                                      ],
                                    ),
                                    Text(
                                      books[i]["title"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      books[i]["text"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.subTitleText,
                                          fontFamily: "Avenir"),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.loveColor,
                                      ),
                                          child: Text(
                                        "Love",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          fontFamily: "Avenir"
                                        ),
                                       ),
                                        alignment: Alignment.center,

                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                ListView.builder(
                    itemCount: sequenceBooks == null ? 0 : sequenceBooks.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.tabVarViewColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(sequenceBooks[i]["img"]))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColor.starColor,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          sequenceBooks[i]["rating"],
                                          style: TextStyle(
                                              color: AppColor.menu2Color),
                                        )
                                      ],
                                    ),
                                    Text(
                                      sequenceBooks[i]["title"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      sequenceBooks[i]["text"],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.subTitleText,
                                          fontFamily: "Avenir"),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.loveColor,
                                      ),
                                      child: Text(
                                        "popular",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: "Avenir"
                                        ),
                                      ),
                                      alignment: Alignment.center,

                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                ListView.builder(
                    itemCount: popularBook == null ? 0 : popularBook.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.tabVarViewColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(popularBook[i]["img"]))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColor.starColor,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          popularBook[i]["rating"],
                                          style: TextStyle(
                                              color: AppColor.menu2Color),
                                        )
                                      ],
                                    ),
                                    Text(
                                      popularBook[i]["title"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      popularBook[i]["text"],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.subTitleText,
                                          fontFamily: "Avenir"),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.loveColor,
                                      ),
                                      child: Text(
                                        "Trends",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: "Avenir"
                                        ),
                                      ),
                                      alignment: Alignment.center,

                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

              ]),
            )),
          ],
        ),
      )),
    );
  }
}
