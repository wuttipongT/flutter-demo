import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asset_mobile/bloc/employee_bloc.dart';
import 'package:asset_mobile/assets/see_more.dart';
import 'package:bloc/bloc.dart';
import 'package:asset_mobile/repository/employee_repository.dart';
import 'package:loadmore/loadmore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:asset_mobile/model/app_state.dart';
import '../app_state_container.dart';

enum SwitchType {
  balance,
  all
}

class Assets extends StatefulWidget {
  String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Assets({Key key, @required this.title, @required this.scaffoldKey}) : super(key: key);

  @override
  _AssetsState createState() {
    return new _AssetsState();
  }
}

class _AssetsState extends State<Assets>{
  int get count => items.length;
  int present = 0;
  int perPage = 150;
  int total = 0;
  SwitchType _type = SwitchType.all;
  Widget appBarTitle;
  Icon _actionIcon = new Icon(Icons.search);
//  var originalItems = List<Map<String, dynamic>>.generate(10000, (i) => {"name":"itme ${i}", "title":"sub title ${i}"});
  var items = List<Map<String, dynamic>>();
  AppState appState;

  @override
  void initState(){
    super.initState();
    appBarTitle = new Text(widget.title);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    super.dispose();
//    appState.isLoading = true;
  }

  @override
  void deactivate() {

  }

  void onLoad(BuildContext context){

  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Loading data from API..."), CircularProgressIndicator()],
        ));
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => appState.isLoading = true);

    var container = AppStateContainer.of(context);
    appState = container.state;

    Widget body = _pageToDisplay;
    return Scaffold(
      appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Colors.white,),
            onPressed: () {
              widget.scaffoldKey.currentState.openDrawer();
            },
          ),
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(icon: _actionIcon,onPressed:(){
              setState(() {
                appState.isLoading = false;
                if ( this._actionIcon.icon == Icons.search){
                  this._actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)
                    ),
                    onSubmitted: (term) async {
                      items.clear();
                      var data = await bloc.getAssetByKey(term);

                      setState(() {
                        items.addAll(data);
                        total = count;
                        present = 0;
                        appState.isLoading = false;
                        print("data count = ${items.length}");
                      });
                    },
                  );
                }else {
                  this._actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text(widget.title);
                }
              });
            }),
//            new IconButton(icon: const Icon(FontAwesomeIcons.balanceScale),tooltip: 'Balance', onPressed: (){}),
            new MaterialButton(
              minWidth: 40.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Icon(FontAwesomeIcons.balanceScale),
              onPressed: () {
                setState(() {
                  _type = SwitchType.balance;
                  present = 0;
                  items.clear();
                  appState.isLoading = true;
//                  load(()=>appState.isLoading = false);
                  _getToal((res) async{
                    total = res;
                    load(() => appState.isLoading = false);
                  });
                });

              },
              splashColor: Colors.redAccent,
            ),
            new MaterialButton(
              minWidth: 40.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Text("All"),
              onPressed: () {

                  setState(() {
                    _type = SwitchType.all;
                    present = 0;
                    items.clear();
                    appState.isLoading = true;
//                    load(()=>appState.isLoading = false);
                    _getToal((res) async{
                      total = res;
                      load(() => appState.isLoading = false);
                    });
                  });

              },
              splashColor: Colors.redAccent,
            )
          ]
      ),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
//          child: Icon(Icons.save),
          icon: Icon(Icons.info),
//          label: StreamBuilder(
//            stream: bloc.subjectTotal.stream,
//            builder: (context, snapshot) {
//              return Text('Total ' + snapshot.data.toString());
//            },
//            initialData: 0,
//          ),
          label: Text('Total ' + total.toString()),
          backgroundColor: Colors.lightGreen
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget get _pageToDisplay {
    if (appState.isLoading) {
      return _loadingView;
    }else {
      return _buildWidget;
    }
  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget get _buildWidget {
    return Container(
      child: RefreshIndicator(
        child: LoadMore(
          isFinish: count >= total,
          onLoadMore: _loadMore,
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: count,
            separatorBuilder:(context, index) => new Divider(),
            itemBuilder: (context, index) {
              // if (index.isOdd) return Divider();
              return ListTile(
                title: Text('${items[index]['ASSETNO']}'),
                subtitle: Text('${items[index]['DESCRIPTION']}'),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeMore(item: this.items[index],)),
                  );

                  appState.isLoading = false;
                },
              );
            },
          ),
          whenEmptyLoad: false,
          delegate: DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        ),
        onRefresh: _refresh,
      ),
//        child: FutureBuilder(
//          future: _init(),
//          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//            return snapshot.connectionState == ConnectionState.done
//                    ? RefreshIndicator(
//                        child: LoadMore(
//                          isFinish: count >= total,
//                          onLoadMore: _loadMore,
//                          child: ListView.builder(
//                            padding: const EdgeInsets.all(16.0),
//                            itemCount: count,
//                            itemBuilder: (context, index) {
//                              //        if (index.isOdd) return Divider();
//
//                              return ListTile(
//                                title: Text('${items[index]['name']}'),
//                                subtitle: Text('${items[index]['title']}'),
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) => SeeMore(item: this.items[index],)),
//                                  );
//                                },
//                              );
//                            },
//                          ),
//                          whenEmptyLoad: false,
//                          delegate: DefaultLoadMoreDelegate(),
//                          textBuilder: DefaultLoadMoreTextBuilder.english,
//                        ),
//                        onRefresh: _refresh,
//                      )
//                    : CircularProgressIndicator();
//          },
//        ),
    );
  }

  Future<void> _init() async {
    await _getToal((res) async{
      total = res;
//      bloc.subjectTotal.sink.add(total);
      load(() => appState.isLoading = false);
    });
  }

  _getToal( Function func ) async {
    var res = _type == SwitchType.all ? await bloc.getTotal("asset") : await bloc.getTotal("balance");
    await func(res);
  }

  Future<bool> _loadMore() async {
//    print("onLoadMore");
//    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    await load(()=> appState.isLoading = false);
    return true;
  }

  void load(Function callback) async{
//    print("load");
    var originalItems = await _getData();
    setState(() {
      callback();
      items.addAll(originalItems);
      present = present + perPage;
      print("data count = ${items.length}");

    });
  }

  Future<void> _refresh() async {

    await _getToal((res) async{

      present = 0;

      load(() {
        total = res;
        items.clear();
        appState.isLoading = false;
      });
    });

  }

  Future<List<Map<String, dynamic>>> _getData() async {
    var o = Map();
    if((present + perPage )> total) {
      o = _type == SwitchType.all ? await bloc.getAsset({"take": total, "skip": present}) : await bloc.getBalance({"take": total, "skip": present});
    } else {
      o = _type == SwitchType.all ? await bloc.getAsset({"take": perPage, "skip": present + perPage}) : await bloc.getBalance({"take": perPage, "skip": present + perPage});
    }

    var data = o.containsKey('data') ? (o['data'] as List) : List();
    var originalItems = List<Map<String, dynamic>>();

    originalItems = data.length > 0 ? data.map((i) => (i as Map<String, dynamic>)).toList() : [];

    return originalItems;

  }

}