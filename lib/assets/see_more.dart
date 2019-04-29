import 'package:flutter/material.dart';

class SeeMore extends StatelessWidget {

  var item = Map<String, dynamic>();
  SeeMore({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // View creation will be here.
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${item['ASSETNO']}'),
      ),
      body: new Column(
        children: <Widget>[
          ListTile(
            leading: new Icon(Icons.location_on),
            title: Text("${_smartText(item['LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Location'),
          ),
          new Divider(),
          ListTile(
              leading: new Icon(Icons.location_on),
              title: Text("${_smartText(item['CHK_LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Current Location')

          ),
          new Divider(),
          ListTile(
              leading: new Icon(Icons.laptop),
              title: Text("${_smartText(item['PCNO'])}", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('PC Number')
          ),
          new Divider(),
          ListTile(
              leading: new Icon(Icons.remove_red_eye),
              title: Row(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 100,
                    child: new RaisedButton(
                      child: Text('Status'),
                      onPressed: () {
                        _showDialog2(context);
                      },
                      color: Colors.blue,
                      splashColor: Colors.white,
                    ),
                  ),
                )
              ],),
          ),
        ],
      ),
    );
  }

  _showDialog2 (BuildContext context) async{

    SimpleDialog dialog = SimpleDialog(
//      title: const Text('Choose an animal'),
      children: <Widget>[
                new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['ASSETNO'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Asset Number'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['DESCRIPTION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Name'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Location'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['CHK_LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Current Location'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['RECEIVEDATE'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Receive Date'),
                  ),
                ),
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['LOCALIMPORT'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Local'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['INVOICENUMBER'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Invoice Number'),
                  ),
                ),
                new Expanded(
                  child: ListTile(
                    title: Text("${_smartText(item['PO'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('P/O'),
                  ),
                )
              ]
            ),
            Row(
                children: <Widget>[
                  new Expanded(
                    child: ListTile(
                      title: Text("${_smartText(item['PROPOSAL'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Proposal'),
                    ),
                  ),
                  new Expanded(
                    child: ListTile(
                      title: Text("${_smartText(item['DPCODE'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Depaertment Code'),
                    ),
                  )
                ]
            ),
            Row(
                children: <Widget>[
                  new Expanded(
                    child: ListTile(
                      title: Text("${_smartText(item['COSTASSET'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Cost Asset'),
                    ),
                  ),
                  new Expanded(
                    child: ListTile(
                      title: Text("${_smartText(item['RESPONSIBLEBY'])}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Responsible by'),
                    ),
                  )
                ]
            ),
          ],
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      child: new _SystemPadding(child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new LayoutBuilder(
          builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),

              ),
            );
          },
        )
//        new Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['ASSETNO'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Asset Number'),
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['DESCRIPTION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Name'),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Location'),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['CHK_LOCATION'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Current Location'),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['RECEIVEDATE'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Receive Date'),
//                  ),
//                ),
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['LOCALIMPORT'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Local'),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['INVOICENUMBER'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('Invoice Number'),
//                  ),
//                ),
//                new Expanded(
//                  child: ListTile(
//                    title: Text("${_smartText(item['PO'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                    subtitle: Text('P/O'),
//                  ),
//                )
//              ]
//            ),
//            Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: ListTile(
//                      title: Text("${_smartText(item['PROPOSAL'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                      subtitle: Text('Proposal'),
//                    ),
//                  ),
//                  new Expanded(
//                    child: ListTile(
//                      title: Text("${_smartText(item['DPCODE'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                      subtitle: Text('Depaertment Code'),
//                    ),
//                  )
//                ]
//            ),
//            Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: ListTile(
//                      title: Text("${_smartText(item['COSTASSET'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                      subtitle: Text('Cost Asset'),
//                    ),
//                  ),
//                  new Expanded(
//                    child: ListTile(
//                      title: Text("${_smartText(item['RESPONSIBLEBY'])}", style: TextStyle(fontWeight: FontWeight.bold)),
//                      subtitle: Text('Responsible by'),
//                    ),
//                  )
//                ]
//            ),
//          ],
//        ),
        ,actions: <Widget>[
          new FlatButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),),
    );
  }

  _smartText (var str) {
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