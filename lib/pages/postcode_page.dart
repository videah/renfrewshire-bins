import 'package:flutter/material.dart';
import 'package:renfrewshire_bins/pages/address_page.dart';

class PostcodePage extends StatelessWidget {
  final _postcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Postcode"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("To get started, enter your Postcode."),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _postcodeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Postcode",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: RaisedButton(
                          child: Icon(Icons.arrow_forward),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return AddressPage(
                                  postcode: _postcodeController.text,
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
