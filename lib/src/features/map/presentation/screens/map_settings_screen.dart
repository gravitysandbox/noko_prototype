import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/custom_divider.dart';
import 'package:noko_prototype/core/widgets/custom_text_button.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_map_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_screen.dart';

class MapSettingsScreen extends StatefulWidget {
  static const routeName = '/route-settings';

  const MapSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MapSettingsScreen> createState() => _MapSettingsScreenState();
}

class _MapSettingsScreenState extends State<MapSettingsScreen> {
  bool _isInit = false;
  bool _isStartPage = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<InitMapScreen>().call(context);
      _isInit = true;
    }
  }

  final List<Widget> _routeTabs = const [
    Tab(
      text: 'Прямое направление',
    ),
    Tab(
      text: 'Обратное направление',
    ),
  ];

  final List<Widget> _vehicleTabs = const [
    Tab(
      text: 'Автобус',
    ),
    Tab(
      text: 'Маршутка',
    ),
    Tab(
      text: 'Троллейбус',
    ),
  ];

  void _onGoNextHandler() {
    if (!_isStartPage) {
      Navigator.of(context).pushReplacementNamed(MapScreen.routeName);
    } else {
      setState(() {
        _isStartPage = false;
      });
    }
  }

  void _onGoBackHandler() {
    setState(() {
      _isStartPage = true;
    });
  }

  Widget _buildRouteSettings() {
    return DefaultTabController(
      length: _routeTabs.length,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              color: StyleConstants.kPrimaryColor,
            ),
            child: TabBar(
              tabs: _routeTabs,
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _RouteSettings(),
                _RouteSettings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleSettings() {
    return DefaultTabController(
      length: _vehicleTabs.length,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              color: StyleConstants.kPrimaryColor,
            ),
            child: TabBar(
              tabs: _vehicleTabs,
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _VehicleSettings(),
                _VehicleSettings(),
                _VehicleSettings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: StyleConstants.kDarkTheme.textTheme.bodyText2!,
        child: Scaffold(
          backgroundColor: StyleConstants.kDarkColor(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: StyleConstants.kDefaultPadding),
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Настройка маршута'),
                Text(
                  _isStartPage
                      ? 'Выберете остановки для контроля'
                      : 'Выберете маршуты для контроля',
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: _isStartPage
                      ? _buildRouteSettings()
                      : _buildVehicleSettings(),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade800.withOpacity(0.9),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: StyleConstants.kDefaultPadding),
                  child: _isStartPage
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AbsorbPointer(
                              absorbing: true,
                              child: Opacity(
                                opacity: 0.0,
                                child: CustomTextButton(
                                  title: 'Назад',
                                  callback: _onGoBackHandler,
                                ),
                              ),
                            ),
                            CustomTextButton(
                              title: 'Далее',
                              callback: _onGoNextHandler,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomTextButton(
                              title: 'Назад',
                              callback: _onGoBackHandler,
                            ),
                            CustomTextButton(
                              title: 'Далее',
                              callback: _onGoNextHandler,
                            ),
                          ],
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

class _RouteSettings extends StatefulWidget {
  const _RouteSettings({Key? key}) : super(key: key);

  @override
  _RouteSettingsState createState() => _RouteSettingsState();
}

class _RouteSettingsState extends State<_RouteSettings> {
  final List<String> _temp = const [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  Set<int> _selected = {};
  bool _isAllCheckBoxTapped = false;

  void _onSelectAllHandler(bool value) {
    if (value) {
      _selected = Iterable<int>.generate(_temp.length, (i) => i++).toSet();
    } else {
      _selected.clear();
    }

    setState(() {
      _isAllCheckBoxTapped = value;
    });
  }

  void _onSelectItemHandler(bool value, int index) {
    if (value) {
      _selected.add(index);
    } else {
      _selected.remove(index);
    }

    if (_temp.length == _selected.length) {
      setState(() {
        _isAllCheckBoxTapped = true;
      });
    } else {
      setState(() {
        _isAllCheckBoxTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomTextButton(
              title:
                  _isAllCheckBoxTapped ? 'Отменить веделение' : 'Выделить всё',
              callback: () => _onSelectAllHandler(!_isAllCheckBoxTapped),
            ),
            Checkbox(
              value: _isAllCheckBoxTapped,
              onChanged: (value) => _onSelectAllHandler(value!),
            ),
            const SizedBox(
              width: 16.0,
            ),
          ],
        ),
        CustomDivider(
          size: 1.0,
          thickness: 1.0,
          color: Colors.grey.withOpacity(0.3),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: _temp.length,
            separatorBuilder: (context, index) {
              return CustomDivider(
                size: 1.0,
                thickness: 1.0,
                color: Colors.grey.withOpacity(0.3),
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                leading: Text(
                  _temp[index],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Checkbox(
                  value: _selected.contains(index),
                  onChanged: (value) => _onSelectItemHandler(value!, index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VehicleSettings extends StatefulWidget {
  const _VehicleSettings({Key? key}) : super(key: key);

  @override
  _VehicleSettingsState createState() => _VehicleSettingsState();
}

class _VehicleSettingsState extends State<_VehicleSettings> {
  final List<String> _temp = const [
    '5',
    '4',
    '3',
    '2',
    '1',
  ];
  Set<int> _selected = {};
  bool _isAllCheckBoxTapped = false;

  void _onSelectAllHandler(bool value) {
    if (value) {
      _selected = Iterable<int>.generate(_temp.length, (i) => i++).toSet();
    } else {
      _selected.clear();
    }

    setState(() {
      _isAllCheckBoxTapped = value;
    });
  }

  void _onSelectItemHandler(bool value, int index) {
    if (value) {
      _selected.add(index);
    } else {
      _selected.remove(index);
    }

    if (_temp.length == _selected.length) {
      setState(() {
        _isAllCheckBoxTapped = true;
      });
    } else {
      setState(() {
        _isAllCheckBoxTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomTextButton(
              title:
                  _isAllCheckBoxTapped ? 'Отменить веделение' : 'Выделить всё',
              callback: () => _onSelectAllHandler(!_isAllCheckBoxTapped),
            ),
            Checkbox(
              value: _isAllCheckBoxTapped,
              onChanged: (value) => _onSelectAllHandler(value!),
            ),
            const SizedBox(
              width: 16.0,
            ),
          ],
        ),
        CustomDivider(
          size: 1.0,
          thickness: 1.0,
          color: Colors.grey.withOpacity(0.3),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: _temp.length,
            separatorBuilder: (context, index) {
              return CustomDivider(
                size: 1.0,
                thickness: 1.0,
                color: Colors.grey.withOpacity(0.3),
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                leading: Text(
                  _temp[index],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Checkbox(
                  value: _selected.contains(index),
                  onChanged: (value) => _onSelectItemHandler(value!, index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
