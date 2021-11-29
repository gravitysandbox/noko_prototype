import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';
import 'package:noko_prototype/core/widgets/custom_outlined_button.dart';
import 'package:noko_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:noko_prototype/src/features/garage/presentation/screens/garage_screen.dart';
import 'package:noko_prototype/src/features/home/presentation/widgets/user_profile_fragment.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_settings_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/temp_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  void _onOpenMapHandler(BuildContext context) {
    // Navigator.of(context).pushNamed(MapSettingsScreen.routeName);
    Navigator.of(context).pushNamed(TempScreen.routeName);
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
                        CustomOutlinedButton(
                          title: 'Мониторинг',
                          subtitle: 'Не активирован',
                          subtitleStyle: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          asset: Image.asset(
                            'assets/images/ic_active_monitoring.png',
                          ),
                          color: Colors.white,
                          callback: () => _onOpenMapHandler(context),
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: 'Гараж',
                          subtitle: '50 машины',
                          titleStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_trolley_blue.png',
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
                          title: 'График работы',
                          subtitle: '3173 TAX-3',
                          titleStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_shuttle_yellow.png',
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Завтра:',
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
                          title: 'Настройки',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_shuttle_grey.png',
                          ),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: 'Написать разработчикам',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_shuttle_grey.png',
                          ),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: 'Аккаунт',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_shuttle_grey.png',
                          ),
                          color: Colors.white,
                          callback: () {},
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        CustomOutlinedButton(
                          title: 'Выход',
                          titleStyle: const TextStyle(
                            fontSize: 16.0,
                          ),
                          asset: Image.asset(
                            'assets/images/btn_shuttle_grey.png',
                          ),
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
