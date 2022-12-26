import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';

import '../../app/routes/routes.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items}) : super(key: key);

  @override
  PersistentBottomBarScaffoldState createState() => PersistentBottomBarScaffoldState();
}

class PersistentBottomBarScaffoldState extends State<PersistentBottomBarScaffold>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.items.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if (widget.items[_tabController.index].navigatorkey?.currentState?.canPop() ?? false) {
          widget.items[_tabController.index].navigatorkey?.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: BlocListener<BottomNavBarBloc, int>(
        listener: (context, state) {
          setTabTo(state);
        },
        child: Scaffold(
          body: IndexedStack(
            index: _tabController.index,
            children: widget.items
                .map((item) => Navigator(
                      key: item.navigatorkey,
                      onGenerateRoute: Routes.onGenerateRouted,
                      onGenerateInitialRoutes: (navigator, initialRoute) {
                        return [CupertinoPageRoute(builder: (context) => item.tab)];
                      },
                    ))
                .toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            onTap: setTabTo,
            elevation: 2,
            currentIndex: _tabController.index,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            items: widget.items
                .map((item) => BottomNavigationBarItem(icon: item.icon, label: item.title))
                .toList(),
          ),
        ),
      ),
    );
  }

  void setTabTo(index) {
    if (index == _tabController.index) {
      widget.items[index].navigatorkey?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _tabController.index = (index);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final Widget icon;

  PersistentTabItem({required this.tab, this.navigatorkey, required this.title, required this.icon});
}
