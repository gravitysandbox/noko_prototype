import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/usecases/update_app_theme.dart';
import 'package:noko_prototype/core/widgets/custom_icon_button.dart';
import 'package:noko_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_selected_vehicles.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_updater.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/custom_sidebar.dart';
import 'package:noko_prototype/core/widgets/custom_divider.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/google_map_fragment.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/google_map_label.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/navigation_button.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/route_button.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/route_switcher_panel.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/setting_category.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/underlined_text_tile.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<MapUpdater>().startTracking();
      _isInit = true;
    }
  }

  @override
  void dispose() {
    locator<MapUpdater>().stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final navigationBottomPosition =
        (mq.size.height / 2.0) - (StyleConstants.kDefaultButtonSize / 2.0);

    return SafeArea(
      child: Scaffold(
        drawer: const _LeftSidebar(),
        endDrawer: BlocBuilder<GarageBloc, GarageBlocState>(
          builder: (context, state) {
            final activeVehicles = state.vehicles.where((vehicle) {
              var index = state.vehicles.indexOf(vehicle);
              return state.schedules[index] != null &&
                  state.timetables[index] != null &&
                  state.busStops[index] != null;
            }).toList();
            final activeRoutes = activeVehicles.map((vehicle) {
              var index = state.vehicles.indexOf(vehicle);
              return state.timetables[index]!.timetable[0].routeID;
            }).toList();

            return _RightSidebar(
              activeVehicles: activeVehicles,
              activeRoutes: activeRoutes,
            );
          },
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Positioned(
              top: GoogleMapLabel.size,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: GoogleMapFragment(),
            ),
            const Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: GoogleMapLabel(),
            ),
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
            if (Platform.isIOS)
              Positioned(
                bottom: 0.0,
                left: StyleConstants.kDefaultPadding,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: StyleConstants.kDefaultPadding),
                  child: FloatingActionButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    backgroundColor: StyleConstants.kPrimaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LeftSidebar extends StatelessWidget {
  const _LeftSidebar({Key? key}) : super(key: key);

  void _onChangeAppThemeHandler(int choice) {
    if (choice == 0) {
      locator<UpdateAppTheme>().call(false);
    }

    if (choice == 1) {
      locator<UpdateAppTheme>().call(true);
    }
  }

  void _onEnableTrafficModeHandler(int choice) {
    if (choice == 0) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isTrafficEnabled: true));
    }

    if (choice == 1) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isTrafficEnabled: false));
    }
  }

  void _onEnableRouteModeHandler(int choice) {
    if (choice == 0) {
      locator<UpdateMapUtils>().call(const MapUtilsState(isRouteEnabled: true));
    }

    if (choice == 1) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isRouteEnabled: false));
    }
  }

  void _onReverseRouteModeHandler(int choice) {
    if (choice == 0) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isRouteReversed: true));
    }

    if (choice == 1) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isRouteReversed: false));
    }
  }

  void _onEnableTrackingModeHandler(int choice) {
    if (choice == 0) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isTrackingEnabled: true));
    }

    if (choice == 1) {
      locator<UpdateMapUtils>()
          .call(const MapUtilsState(isTrackingEnabled: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSidebar(
      widget: LayoutBuilder(
        builder: (context, constraints) {
          return ScrollableWrapper(
            widgets: <Widget>[
              BlocBuilder<AppBloc, AppBlocState>(
                buildWhen: (prev, current) {
                  return prev.isDarkTheme != current.isDarkTheme;
                },
                builder: (context, state) {
                  return Column(
                    children: <Widget>[
                      UnderlinedTextTile(
                        label: 'Route settings',
                        description: 'Selection of op and routes for control',
                        callback: () {},
                        isDark: state.isDarkTheme,
                      ),
                      UnderlinedTextTile(
                        label: 'Route schedule',
                        description: 'Current route schedule',
                        callback: () {},
                        isDark: state.isDarkTheme,
                      ),
                      SettingCategory(
                        label: 'State number type',
                        switches: const {
                          'Tax-1',
                          '1111',
                          'Disable',
                        },
                        callback: (value) {},
                        activePosition: 0,
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 0.75,
                      ),
                      SettingCategory(
                        label: 'Monitoring type',
                        switches: const {
                          'Light',
                          'Dark',
                        },
                        callback: _onChangeAppThemeHandler,
                        activePosition: state.isDarkTheme ? 1 : 0,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 0.75,
              ),
              BlocBuilder<GeoBloc, GeoBlocState>(
                buildWhen: (prev, current) {
                  return prev.utils != current.utils;
                },
                builder: (context, state) {
                  return Column(
                    children: <Widget>[
                      SettingCategory(
                        label: 'Traffic display',
                        switches: const {
                          'Enable',
                          'Disable',
                        },
                        callback: _onEnableTrafficModeHandler,
                        activePosition: state.utils.isTrafficEnabled! ? 0 : 1,
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 0.75,
                      ),
                      SettingCategory(
                        label: 'Route display',
                        switches: const {
                          'Enable',
                          'Disable',
                        },
                        callback: _onEnableRouteModeHandler,
                        activePosition: state.utils.isRouteEnabled! ? 0 : 1,
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 0.75,
                      ),
                      SettingCategory(
                        label: 'Reverse route',
                        switches: const {
                          'Enable',
                          'Disable',
                        },
                        callback: _onReverseRouteModeHandler,
                        activePosition: state.utils.isRouteReversed! ? 0 : 1,
                        isDisabled: !state.utils.isRouteEnabled!,
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 0.75,
                      ),
                      SettingCategory(
                        label: 'Follow the target',
                        switches: const {
                          'Enable',
                          'Disable',
                        },
                        callback: _onEnableTrackingModeHandler,
                        activePosition: state.utils.isTrackingEnabled! ? 0 : 1,
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RightSidebar extends StatelessWidget {
  final List<VehicleData> activeVehicles;
  final List<int> activeRoutes;

  const _RightSidebar({
    Key? key,
    required this.activeVehicles,
    required this.activeRoutes,
  }) : super(key: key);

  void _onSelectRouteHandler(int index) {
    locator<UpdateMapSelectedVehicles>().call(activeVehicles[index]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSidebar(
      widget: BlocBuilder<AppBloc, AppBlocState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              CustomIconButton(
                label: 'My position',
                icon: Icons.api,
                color: Colors.blue,
                callback: () {},
              ),
              CustomDivider(
                color: state.isDarkTheme
                    ? StyleConstants.kLightColor()
                    : StyleConstants.kDarkColor(),
              ),
              CustomIconButton(
                label: 'Add routes',
                icon: Icons.add_to_photos,
                callback: () {},
                color: state.isDarkTheme
                    ? StyleConstants.kLightColor()
                    : StyleConstants.kDefaultButtonColor,
              ),
              CustomDivider(
                color: state.isDarkTheme
                    ? StyleConstants.kLightColor()
                    : StyleConstants.kDarkColor(),
              ),
              const RouteSwitcherPanel(),
              CustomDivider(
                color: state.isDarkTheme
                    ? StyleConstants.kLightColor()
                    : StyleConstants.kDarkColor(),
              ),
              Container(
                height: StyleConstants.kDefaultButtonSize,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: StyleConstants.kDefaultButtonSize * 0.15),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Tracked routes',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<GeoBloc, GeoBlocState>(
                  builder: (context, geo) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: activeVehicles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: StyleConstants.kDefaultPadding * 0.5,
                        crossAxisSpacing: StyleConstants.kDefaultPadding * 0.5,
                      ),
                      itemBuilder: (context, index) {
                        return RouteButton(
                          label: activeRoutes[index].toString(),
                          callback: () => _onSelectRouteHandler(index),
                          isActive: geo.selectedVehicleIDs
                              .contains(activeVehicles[index].vehicleID),
                          isDark: state.isDarkTheme,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
