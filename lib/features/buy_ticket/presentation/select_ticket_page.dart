import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/utils/extensions/string_parsing.dart';
import '../../../core/core.dart';
import '../../shared/presentation/loading_page.dart';
import 'cubit/get_list_event_ticket_cubit.dart';
import 'widget/detail_ticket_card_widget.dart';

@RoutePage()
class SelectTicketPage extends StatefulWidget {
  const SelectTicketPage({super.key});

  @override
  State<SelectTicketPage> createState() => _SelectTicketPageState();
}

class _SelectTicketPageState extends State<SelectTicketPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Buy Ticket',
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
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: Paddings.defaultPaddingH,
            child: BlocBuilder<GetListEventTicketCubit, GetListEventTicketState>(builder: (context, state) {
              if (state is! GetListEventTicketLoadedState) {
                return const LoadingPage(opacity: 1);
              }
              final listTicket = state.listEvent?.data?.ticketTypes;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: List.generate(
                    listTicket?.length ?? 0,
                    (index) {
                      return DetailTicketCardWidget(
                        title: listTicket?[index].name ?? '',
                        capacity: listTicket?[index].capacity ?? 0,
                        subtitle: listTicket?[index].description ?? '',
                        onTap: () {
                          navigationService.push(
                            ConfirmBuyTicketRoute(
                              selectedTicket: listTicket![index],
                              eventId: state.listEvent?.data?.eventId ?? 0,
                            ),
                          );
                        },
                        price: listTicket?[index].price?.toString().amountInWeiToToken(
                                  decimals: 6,
                                  fractionDigits: 0,
                                ) ??
                            '',
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
