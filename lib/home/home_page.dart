import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asset_mobile/authentication/authentication.dart';
import 'package:asset_mobile/account/user_widget.dart';
import 'package:asset_mobile/model/drawer_item.dart';
import 'package:asset_mobile/home/default_screen.dart';
import 'package:asset_mobile/check/check_asset.dart';
import 'package:asset_mobile/bloc/session_bloc.dart';
import 'package:asset_mobile/home/chart.dart';
import 'package:asset_mobile/check/check_tabbar.dart';
import 'package:asset_mobile/assets/assets.dart';
import 'package:asset_mobile/assets/pc_detail.dart';

class HomePage extends StatefulWidget {
//  final String title;
//  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _action = new List<Widget>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final drawerItems  = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Asset", Icons.computer),
    new DrawerItem("Check Asset", Icons.check),
    new DrawerItem("PC Detail", Icons.info)
  ];

  Widget appBarTitle;
  Icon _actionIcon = new Icon(Icons.search);

  @override
  void initState() {
    super.initState();
    bloc.getSession();
  }

  _getDrawItemScreen(int pos) {

    StatefulWidget widget;
    _action = List();

    if (pos == 0) {
      return DatumLegendWithMeasures.withSampleData(_scaffoldKey);
    }else if(pos == 1) {
      return Assets(title: drawerItems[_selectedIndex].title, scaffoldKey: _scaffoldKey,);
    }else if (pos == 2) {
      return CheckTabBar(title: drawerItems[_selectedIndex].title, scaffoldKey: _scaffoldKey,);
    }else if (pos == 3) {
      return PcDetail(title: drawerItems[_selectedIndex].title, scaffoldKey: _scaffoldKey);
    } else {

      widget = new DefaultScreen(drawerItem: drawerItems[_selectedIndex]);
    }

    return widget;
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _getDrawItemScreen(_selectedIndex);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return _buildHomeWigget(snapshot.data);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ));
  }

  Widget _buildHomeWigget (Map o) {
    List<Widget> drawerOptions = new List<Widget>();
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(
          d.title,
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                currentAccountPicture: new CircleAvatar(
                  radius: 60.0,
                  backgroundColor: const Color(0xFF778899),
                  backgroundImage: NetworkImage("http://wmsdev.world-electric.co.th/letters/users.png"), // for Network image

                ),
                accountName: new Text(
                  "${o['name']}",
                  style: new TextStyle(
                      fontSize: 18.8, fontWeight: FontWeight.w500
                  ),
                ),
                accountEmail: new Text(
                  "${o['email']}",
                  style: new TextStyle(
                      fontSize: 18.8, fontWeight: FontWeight.w500
                  ),
                ),
                margin: EdgeInsets.zero
            ),
            new Expanded(child: new ListView(
              padding: const EdgeInsets.only(top: 8.0),
              children: <Widget>[
                new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: drawerOptions
                ),
                new Divider(
                  color: Colors.grey,
                ),
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: new Text(
                        "Logout",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400
                        ),
                      ),
                      onTap: () {
                        authenticationBloc.dispatch(LoggedOut());
                      },
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
      body: _getDrawItemScreen(_selectedIndex),
    );
  }
}