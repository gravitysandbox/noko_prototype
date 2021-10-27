import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noko_prototype/locator.dart';
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

    return SafeArea(
      child: Scaffold(
        drawer: const LeftSidebar(),
        endDrawer: const RightSidebar(),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const GoogleMapFragment(),
            Positioned(
              left: 0.0,
              bottom: (mq.height / 2.0) - 30.0,
              child: const NavigationButton(isLeft: true),
            ),
            Positioned(
              right: 0.0,
              bottom: (mq.height / 2.0) - 30.0,
              child: const NavigationButton(isLeft: false),
            ),
            const Positioned(
              bottom: 20.0,
              left: 20.0,
              child: MapUtilsPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
