import 'package:flutter/material.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';
import 'package:noko_prototype/src/constants.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/route_button.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/route_switcher_panel.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/tile_button.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({Key? key}) : super(key: key);

  static const Map<String, bool> _routes = {
    'M 16, Gomel MT': true,
    'A 126, Gomel AP': true,
    'M 17, Gomel MT': true,
    'T 10, Gomel': false,
    'M 12, Gomel': false,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ContentWrapper(
        verticalPadding: 5.0,
        widget: Column(
          children: [
            TileButton(
              label: 'My position',
              icon: Icons.api,
              color: Colors.blue,
              callback: () {},
            ),
            const Divider(
              height: 1.0,
            ),
            TileButton(
              label: 'Add routes',
              icon: Icons.add_to_photos,
              callback: () {},
            ),
            const Divider(
              height: 1.0,
            ),
            const RouteSwitcherPanel(),
            const Divider(
              height: 1.0,
            ),
            Container(
              height: kDefaultButtonSize,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultButtonSize * 0.15),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Tracked routes',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _routes.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: kDefaultPadding,
                  );
                },
                itemBuilder: (context, index) {
                  return RouteButton(
                    label: _routes.keys.toList()[index],
                    callback: () {},
                    isActive: _routes.values.toList()[index],
                    isBus: _routes.keys.toList()[index].startsWith('A'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
