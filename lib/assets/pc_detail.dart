import 'package:flutter/material.dart';
import '../app_state_container.dart';
import 'package:asset_mobile/model/app_state.dart';
import 'package:asset_mobile/bloc/employee_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:asset_mobile/assets/show_all.dart';
//import 'auth_screen.dart';

class PcDetail extends StatefulWidget {
  String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  PcDetail({Key key, @required this.title, @required this.scaffoldKey}) : super(key: key);

  @override
  PcDetailState createState() => new PcDetailState();
}

class PcDetailState extends State<PcDetail> {
  AppState appState;
  int present = 0;
  int perPage = 150;
  int total = 0;
  var items = List<Map<String, dynamic>>();
  int get count => items.length;

  Widget appBarTitle;
  Icon _actionIcon = new Icon(Icons.search);

  @override
  void initState(){
    super.initState();
    appBarTitle = new Text(widget.title);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _init());
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

  Widget get _homeView {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Logged In:',
            style: new TextStyle(
              fontSize: 18.0,
            ),
          ),
          new Text(
            '555',
            style: new TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => appState.isLoading = true);

    var container = AppStateContainer.of(context);
    appState = container.state;
    Widget body = _pageToDisplay;

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(icon: _actionIcon,onPressed:(){
            setState(() {
              appState.isLoading = false;
              if (this._actionIcon.icon == Icons.search){
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
                    var data =  await bloc.getPcDetailByKey(term);
                    setState(() {
                      items.addAll(data);
                      total = count;
                      present = 0;
                      appState.isLoading = false;
                    });
                  },
                );
              }else {
                this._actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text(widget.title);
              }
            });
          }),
        ],
        leading: new IconButton(
            icon: new Icon(Icons.menu, color: Colors.white,),
            onPressed: () => widget.scaffoldKey.currentState.openDrawer()
        ),
        title: appBarTitle,
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

  Widget get _buildWidget {
    return Container(
      child: RefreshIndicator(
        child: LoadMore(
          isFinish: count >= total,
          onLoadMore: _loadMore,
          child: ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: count,
            separatorBuilder:(context, index) => new Divider(),
            itemBuilder: (context, index) {
              //        if (index.isOdd) return Divider();
              return ListTile(
                title: Text('${items[index]['pcno']}'),
                subtitle: Text('${items[index]['asset']}'),
                onTap: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowAll(item: this.items[index],)),
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
    );
  }

  Future<void> _init() async {
    total = await _getToal();
    load(() => appState.isLoading = false);
  }

  _getToal() async {
    var res = await bloc.getTotal("pc-detail");
    return res;
  }

  Future<bool> _loadMore() async {
//    print("onLoadMore");
//    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    await load(()=>appState.isLoading = false);
    return true;
  }

  void load(Function callback) async{
    var originalItems = await _getData();

    setState(() {
      callback();
      items.addAll(originalItems);
      present = present + perPage;

    });
  }

  @override
  void dispose() {
    super.dispose();
//    appState.isLoading = true;
  }

  Future<void> _refresh() async {
    var _total = await _getToal();

    present = 0;

    load(() {
      total = _total;
      items.clear();
      appState.isLoading = false;
    });
  }

  @override
  void deactivate() {

  }

  Future<List<Map<String, dynamic>>> _getData() async {
    var o = List<Map<String, dynamic>>();
    if((present + perPage )> total) {
      o = await bloc.getPc({"take": perPage, "skip": total});
    } else {
      o = await bloc.getPc({"take": perPage, "skip": present + perPage});
    }

    return o;

  }

}