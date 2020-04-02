import 'package:flutter/material.dart';

class BinTile extends StatelessWidget {
  final String name;
  final double fontSize;
  final double width;
  final double height;

  const BinTile({Key key, this.name, this.fontSize, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            "/help/info",
            arguments: name,
          );
        },
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(
                "assets/images/bin_$name.png",
              ),
            ),
            Text(
              "${name[0].toUpperCase() + name.substring(1)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
