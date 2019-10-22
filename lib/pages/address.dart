import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class AddressPage extends StatelessWidget {
  final String postcode;

  const AddressPage({Key key, this.postcode}) : super(key: key);

  Future _getAddresses() async {
    // We just provide these headers to make the request look more authentic.
    // Not that I expect them to notice or anything.
    var headers = {
      "Accept": "text/javascript, application/javascript",
      "Referer": "http://renfrewshire.gov.uk/checkyourbincollectionday",
      "X-Requested-With": "XMLHttpRequest",
    };

    // I swear this is the best way of doing this.
    // I have no idea what the id parameter is for, it's some random int.
    // Local government APIs are weird and stupid.
    var jsonRpc = '''
      {
        "id": ${Random().nextInt(100000000)},
        "method": "postcodeSearch",
        "params": {"provider": "EndPoint", "postcode": "$postcode"}
      }
    ''';

    // The callback parameter is some bullshit needed for the jQuery
    // thing they use. As far as I can tell it's random.
    // We're also passing the current DateTime for some reason.
    // If you don't pass it then the server returns a 404 (great API design!)
    Map<String, String> queryParams = {
      "callback": "",
      "_": "${DateTime.now().millisecondsSinceEpoch}",
      "jsonrpc": jsonRpc,
    };

    // Yes I'm afraid that their API doesn't use https, so postcodes go over
    // in plaintext.
    //There's nothing I can do about this, blame Renfrewshire Council.
    var uri = Uri.http(
      "renfrewshire.gov.uk",
      "/apiserver/postcode",
      queryParams,
    );

    // Fingers crossed.
    Response response = await Dio().getUri(
      uri,
      options: Options(headers: headers),
    );

    // We need to strip some brackets because the API returns a callback
    // method with the addresses as a parameter.
    String stripped = response.data.toString().substring(1);
    String strippedAgain = stripped.substring(0, stripped.length - 1);
    return json.decode(strippedAgain)["result"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Address"),
      ),
      body: FutureBuilder(
        future: _getAddresses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                var address = Map<String, dynamic>.from(snapshot.data[i]);
                String line =
                    "${address["line1"]} ${ReCase(address["line2"]).titleCase}";
                String town = address["town"];
                return ListTile(
                  title: Text(line),
                  subtitle: Text(town),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure?"),
                          content: Text("Is $line your address?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("NO"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text("YES"),
                              onPressed: () {},
                            )
                          ],
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, i) {
                return Divider(
                  height: 0.0,
                );
              },
            );
          }
        },
      ),
    );
  }
}
