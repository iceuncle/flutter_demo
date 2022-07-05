import 'package:flutter/material.dart';

///滑动悬停tabBar效果
class HoverScrollViewPage extends StatefulWidget {
  @override
  _HoverScrollViewPageState createState() => _HoverScrollViewPageState();
}

class _HoverScrollViewPageState extends State<HoverScrollViewPage>
    with SingleTickerProviderStateMixin {
  TabController _TabController;

  @override
  void initState() {
    _TabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('滑动悬停tabBar效果'),
        ),
        body:
          NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context),
                  sliver: SliverAppBar(
                    titleSpacing: 0,
                    backgroundColor: Colors.white,
                    leading: null,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    title: TabBar(
                      controller: _TabController,
                      labelColor: Colors.black45,
//                      labelPadding: EdgeInsets.only(bottom: 4),
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: Color(0xff2fcfbb), width: 3),
                          insets: EdgeInsets.only(bottom: 6)
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: <Widget>[
                        Tab(
                          text: 'Home',
                        ),
                        Tab(
                          text: 'Mine',
                        )
                      ],
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(controller: _TabController, children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    height: 1000,
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                  )
                ],
              ),
              ListView(
                children: <Widget>[
                  Container(
                    height: 1000,
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                  )
                ],
              )
            ]),
          ),
        );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
