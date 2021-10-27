import 'package:flutter/material.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ContentWrapper(
        widget: ListView(
          children: <Widget>[
            Container(
              height: 30.0,
              color: Colors.orange,
              child: Text('TEST1'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 30.0,
              color: Colors.orange,
              child: Text('TEST2'),
            ),
          ],
        ),
      ),
    );
  }
}
