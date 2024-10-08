import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../core/core.dart';

@RoutePage()
class AddMoreWalletPage extends StatefulWidget {
  const AddMoreWalletPage({super.key});

  @override
  State<AddMoreWalletPage> createState() => _AddMoreWalletPageState();
}

class _AddMoreWalletPageState extends State<AddMoreWalletPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Add / Connect Wallet',
          style: UITypographies.h4(
            context,
            color: UIColors.white50,
          ),
        ),
        leading: BounceTap(
          onTap: () {
            context.maybePop();
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: UIColors.grey200.withOpacity(0.24),
            ),
            child: Icon(
              Icons.arrow_back,
              color: UIColors.white50,
              size: 20.w,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 16.w,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: UIColors.black400,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: <Widget>[
                    BounceTap(
                      onTap: () {
                        navigationService.push(
                          const CreateWalletRoute(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: UIColors.white50.withOpacity(0.15),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Create New Account',
                              style: UITypographies.subtitleLarge(context),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: UIColors.white50,
                              size: 18.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BounceTap(
                      onTap: () {
                        navigationService.push(
                          const ImportWalletRoute(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Enter Recovery Phrase',
                              style: UITypographies.subtitleLarge(context),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: UIColors.white50,
                              size: 18.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
