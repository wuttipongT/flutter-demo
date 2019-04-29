import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asset_mobile/bloc/employee_bloc.dart';
import 'package:asset_mobile/check/aditional.dart';
import 'package:bloc/bloc.dart';
import 'package:asset_mobile/model/app_state.dart';
import '../app_state_container.dart';
import 'package:loadmore/loadmore.dart';

class ListViewCheck extends StatefulWidget {
  @override
  _ListViewState createState() {
    return new _ListViewState();
  }

}

class _ListViewState extends State<ListViewCheck>{

  int present = 0;
  int perPage = 15;
  int total = 0;
  int get count => items.length;
//  var originalItems = List<Map<String, dynamic>>.generate(10000, (i) => {"name":"itme ${i}", "title":"sub title ${i}"});
  var items = List<Map<String, dynamic>>();
  FocusNode _focusNode = new FocusNode();
  AppState appState;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _init());
//    bloc.getCheckData({"take": perPage, "skip": present});
//    bloc.getTotal();
//    setState(() {
//      items.addAll(originalItems.getRange(present, present + perPage));
//      present = present + perPage;
//    });

  }

  void _init() async{
    total = await _getToal();
    load(() => appState.isLoading = false);
  }

  Future<int> _getToal() async {
    return await bloc.getTotal();
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
              //        if (index.isOdd) return Divider();

              return ListTile(
                title: Text('${items[index]['CHK_ASSNO']}'),
                subtitle: Text('${items[index]['DESC']}'),
                onTap: () async {
                 await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aditional(item: this.items[index],)),
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
      )
    );
  }

  Future<bool> _loadMore() async {
    await load(()=>appState.isLoading = false);
    return true;
  }

  void load(Function callback) async{
    var originalItems = await _getData();

    setState(() {
      items.addAll(originalItems);
      present = present + perPage;
      print("data count = ${items.length}");
      callback();
    });
  }

  Future<void> _refresh() async {
    present = 0;
    items.clear();
    await load(() => appState.isLoading = false);
  }

  Future<List<Map<String, dynamic>>> _getData() async {
    var o = Map();
    if((present + perPage )> total) {
      o = await bloc.getCheckData({"take": perPage, "skip": total});
    } else {
      o = await bloc.getCheckData({"take": perPage, "skip": present + perPage});
    }

    var data = o.containsKey('data') ? (o['data'] as List) : List();
    var originalItems = List<Map<String, dynamic>>();

    originalItems = data.length > 0 ? data.map((i) => (i as Map<String, dynamic>)).toList() : [];

    return originalItems;
  }

  @override
  void dispose() {
    super.dispose();
//    bloc.subject.close();
//    bloc.subjectTotal.close();
//    appState.isLoading = true;
  }

  @override
  void deactivate() {
//    appState.isLoading = true;
  }

  /*
  void loadMore() async{

    if((present + perPage )> total) {
//        items.addAll(originalItems.getRange(present, originalItems.length));
      bloc.getCheckData({"take": perPage, "skip": total});
    } else {
//        items.addAll(originalItems.getRange(present, present + perPage));
      bloc.getCheckData({"take": perPage, "skip": present + perPage});
    }

    StreamBuilder<Map>(
      stream: bloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bloc.subject.sink.add(snapshot.data);
//          present = present + perPage;

        }
      },
    );
    bloc.subject.sink.add(event);
    setState(() {
      if((present + perPage )> originalItems.length) {
        items.addAll(
            originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(
            originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }
*/
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
      body: body,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
//          child: Icon(Icons.save),
          icon: Icon(Icons.info),
          label: Text("Total ${total.toString()}"),
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

  /*
  @override
  Widget _buildWidget(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
                loadMore();
            }
          },
          child: StreamBuilder<Map>(
            stream: bloc.subject.stream,
            builder: (context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData) {
                var o = snapshot.data;
                total = o['total'];
                var originalItems = (o['data'] as List).map((i) => {
                  "name":(i as Map)['CHK_ASSNO'],
                  "title":(i as Map)['DESC'],
                  "CHK_SECTIONS": (i as Map)['CHK_SECTIONS'],
                  "USERNAME": (i as Map)['USERNAME'],
                  "DOUBLE_CHK": (i as Map)['DOUBLE_CHK'],
                  "CHK_LOCATION": (i as Map)['CHK_LOCATION'],
                  "remark": (i as Map)['remark'],
                }).toList();
                items.addAll(originalItems.getRange(0, originalItems.length));
                present = present + perPage;

                return _listView();

              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
//          child: Icon(Icons.save),
          icon: Icon(Icons.info),
          label: StreamBuilder(
            stream: bloc.subjectTotal.stream,
            builder: (context, snapshot) {
              return Text('Total ' + snapshot.data.toString());
            },
            initialData: 0,
          ),
            backgroundColor: Colors.lightGreen
        ),
    );
  }
*/

  /*
  ListView _listView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: (present <= total) ? items.length + 1 : items.length,
      itemBuilder: (context, index) {
//        if (index.isOdd) return Divider();

        return (index == items.length ) ?
        Container(
          color: Colors.greenAccent,
          child: FlatButton(
            child: Text("Load More"),
            onPressed: () {
              loadMore();
            },
          ),
        )
            :
        ListTile(
          title: Text('${items[index]['name']}'),
          subtitle: Text('${items[index]['title']}'),
          trailing: CircleAvatar( child: new Icon(Icons.check, size: 40,)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Aditional(item: this.items[index],)),
            );
          },
        );
      },
    );
  }
  */
}