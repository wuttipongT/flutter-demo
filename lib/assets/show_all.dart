import 'package:flutter/material.dart';

class ShowAll extends StatelessWidget {

  var item = Map<String, dynamic>();
  ShowAll({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // View creation will be here.
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${item['pcno']}'),
      ),
      body: new LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(children: [
                // remaining stuffs
                ListTile(
                  title: Text("${_smartString(item['section'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Section'),
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['subject'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Subject')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['pcno'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('PC Number')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['asset'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Asset')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['ipno'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('IP Number')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['username'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Username')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['tel'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Tel')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['os'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('OS')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['ostype'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('OS Type')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['keywindows'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Key Windows')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['office'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Office')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['officever'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Office Version')
                ),
                new Divider(),
                ListTile(
                    title: Text("${_smartString(item['keyoffice'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Key Office')
                ),
              ]),
            ),
          );
        },
      )
    );
  }

  _smartString (var str) {
    return str.toString().isEmpty ? '-' : str ?? '-';
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}