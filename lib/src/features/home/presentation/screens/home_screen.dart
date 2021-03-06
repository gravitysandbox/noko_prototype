import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';
import 'package:noko_prototype/core/widgets/custom_outlined_button.dart';
import 'package:noko_prototype/core/widgets/loading_indicator.dart';
import 'package:noko_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/init_garage_screen.dart';
import 'package:noko_prototype/src/features/garage/presentation/screens/garage_screen.dart';
import 'package:noko_prototype/src/features/home/presentation/widgets/user_profile_fragment.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_map_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<InitGarageScreen>().call(NoParams()).then((result) {
        result.fold(
          (failure) {
            logPrint('-----> ! NO ACTIVE VEHICLE ! <-----');
            return null;
          },
          (result) {
            Future.delayed(const Duration(seconds: 2)).then((value) {
              locator<InitMapScreen>().call(context);
            });
          },
        );
      });
      _isInit = true;
    }
  }

  void _onOpenMapHandler(BuildContext context) {
    Navigator.of(context).pushNamed(MapScreen.routeName);
    // Navigator.of(context).pushNamed(MapSettingsScreen.routeName);
    // Navigator.of(context).pushNamed(TempScreen.routeName);
  }

  void _onOpenGarageHandler(BuildContext context) {
    Navigator.of(context).pushNamed(GarageScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: DefaultTextStyle(
          style: StyleConstants.kDarkTheme.textTheme.bodyText2!,
          child: Column(
            children: <Widget>[
              const UserProfileFragment(),
              const SizedBox(
                height: StyleConstants.kDefaultPadding,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: StyleConstants.kDarkColor(),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                          StyleConstants.kDefaultButtonSize * 0.3),
                    ),
                  ),
                  child: ContentWrapper(
                    widget: ScrollableWrapper(
                      widgets: [
                        BlocBuilder<GeoBloc, GeoBlocState>(
                          buildWhen: (prev, current) {
                            return prev.isInit != current.isInit;
                          },
                          builder: (context, state) {
                            return AbsorbPointer(
                              absorbing: !state.isInit,
                              child: CustomOutlinedButton(
                                title: '????????????????????',
                                subtitle: '???? ??????????????????????',
                                subtitleStyle: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                                asset: Image.asset(
                                  'assets/images/ic_active_monitoring.png',
                                ),
                                leading: state.isInit
                                    ? null
                                    : const LoadingIndicator(
                                        size: 48.0,
                                      ),
                                color: Colors.white,
                                callback: () => _onOpenMapHandler(context),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '??????????',
                          subtitle: '50 ????????????',
                          titleStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          asset: Image.asset(
                            'assets/images/ic_bus_garage.png',
                          ),
                          leading: Text(
                            '3173 TAX-3',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: true
                                  ? StyleConstants.kPrimaryColor
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                          color: Colors.white,
                          callback: () => _onOpenGarageHandler(context),
                          isActive: true,
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '???????????? ????????????',
                          subtitle: '3173 TAX-3',
                          titleStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          asset: Image.asset(
                            'assets/images/ic_schedule.png',
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '????????????:',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: true
                                      ? StyleConstants.kPrimaryColor
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'M-18/24',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: true
                                      ? StyleConstants.kPrimaryColor
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          color: Colors.white,
                          callback: () {},
                          isActive: true,
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '??????????????????',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: const Icon(Icons.settings),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '???????????????? ??????????????????????????',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: const Icon(Icons.send),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '??????????????',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: const Icon(Icons.account_circle),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: '??????????',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: const Icon(Icons.power_settings_new),
                          color: Colors.white,
                          callback: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
