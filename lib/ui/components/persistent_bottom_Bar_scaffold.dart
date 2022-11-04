import 'package:flutter/material.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items}) : super(key: key);

  @override
  PersistentBottomBarScaffoldState createState() => PersistentBottomBarScaffoldState();
}

class PersistentBottomBarScaffoldState extends State<PersistentBottomBarScaffold>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.items.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.items[_tabController.index].navigatorkey?.currentState?.canPop() ?? false) {
          widget.items[_tabController.index].navigatorkey?.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: widget.items
              .map((item) => Navigator(
                    key: item.navigatorkey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [MaterialPageRoute(builder: (context) => item.tab)];
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            if (index == _tabController.index) {
              widget.items[index].navigatorkey?.currentState?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _tabController.animateTo(index);
              });
            }
          },
          elevation: 2,
          currentIndex: _tabController.index,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).iconTheme.color,
          items: widget.items
              .map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.title))
              .toList(),
        ),
      ),
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem({required this.tab, this.navigatorkey, required this.title, required this.icon});
}
