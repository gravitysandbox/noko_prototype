import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/constants.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/left_sidebar.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/right_sidebar.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/google_map_fragment.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/map_utils_panel.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/navigation_button.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<InitGoogleMap>().call(context);
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final navigationBottomPosition = (mq.height / 2.0) - (kDefaultButtonSize / 2.0);

    return SafeArea(
      child: Scaffold(
        drawer: const LeftSidebar(),
        endDrawer: const RightSidebar(),
        body: Builder(
          builder: (ctx) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                const GoogleMapFragment(),
                Positioned(
                  left: 0.0,
                  bottom: navigationBottomPosition,
                  child: const NavigationButton(isLeft: true),
                ),
                Positioned(
                  right: 0.0,
                  bottom: navigationBottomPosition,
                  child: const NavigationButton(isLeft: false),
                ),
                const Positioned(
                  bottom: kDefaultPadding,
                  left: kDefaultPadding,
                  child: MapUtilsPanel(),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
