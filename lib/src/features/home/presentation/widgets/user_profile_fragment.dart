import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';
import 'package:noko_prototype/core/widgets/custom_divider.dart';
import 'package:noko_prototype/src/features/home/presentation/widgets/top_up_balance_button.dart';

class UserProfileFragment extends StatelessWidget {
  const UserProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'skrskr',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: StyleConstants.kDefaultPadding * 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '9069.0 руб.',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    CustomDivider(
                      size: StyleConstants.kDefaultPadding,
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                    Text(
                      '9069 дней. Гомельская область.',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: StyleConstants.kDefaultPadding * 0.5,
              ),
              Flexible(
                flex: 1,
                child: TopUpBalanceButton(
                  label: 'Пополнить',
                  callback: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
