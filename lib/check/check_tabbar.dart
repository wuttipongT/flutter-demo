import 'package:flutter/material.dart';
import 'package:asset_mobile/check/check_asset.dart';
import 'package:asset_mobile/check/list_view.dart';

class CheckTabBar extends StatefulWidget {
  String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  CheckTabBar({Key key, @required this.title, this.scaffoldKey}) : super(key: key);
  @override
  _CheckTabBarState createState() => _CheckTabBarState();
}

class _CheckTabBarState extends State<CheckTabBar> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.menu, color: Colors.white,),
              onPressed: ()=>widget.scaffoldKey.currentState.openDrawer()
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.input) ),
              Tab(icon: Icon(Icons.view_list))
            ],
            onTap: (term){
//              if (term == 0) {
//                SystemChannels.textInput.invokeMethod('TextInput.show');
//              } else {
//                SystemChannels.textInput.invokeMethod('TextInput.hide');
//              }
            }
          ),
          title: Text(widget.title),
//          actions: <Widget>[
//            Builder(builder: (context) {
//              _tabIndex = DefaultTabController.of(context).index;
//            })
//          ],
        ),
        body: TabBarView(
          children: [
            CheckAsset(),
            ListViewCheck(),
          ],
        ),
      ),
    );
  }
}