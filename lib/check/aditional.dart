import 'package:flutter/material.dart';

class Aditional extends StatelessWidget {

  var item = Map<String, dynamic>();
  Aditional({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // View creation will be here.
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('${item['CHK_ASSNO']}'),
        ),
      body: new Column(
        children: <Widget>[
          ListTile(
            leading: new Icon(Icons.group),
            title: Text("${_smartText(item['CHK_SECTIONS'])}", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('section'),
          ),
          new Divider(),
          ListTile(
            leading: new Icon(Icons.check),
            title: Text("${_smartText(item['USERNAME'])}", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('check by')

          ),
          new Divider(),
          ListTile(
            leading: new Icon(Icons.repeat),
            title: Text("${_smartText(item['DOUBLE_CHK'])}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: Text('double check')
          ),
          new Divider(),
          ListTile(
              leading: new Icon(Icons.location_on),
              title: Text("${_smartText(item['CHK_LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('location')
          ),
          new Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: new TextFormField(
              decoration: new InputDecoration(
                  hintText: "remark",
              ),
              initialValue: "${_smartText(item['Remake'])}",
              keyboardType: TextInputType.multiline,
              maxLines: null,
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }

  String _smartText(var str) {
    return str.toString().isEmpty ? "-" : str ?? "-";
  }
}