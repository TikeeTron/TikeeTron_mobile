import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../../common/common.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../core/injector/locator.dart';
import '../../../shared/presentation/event_card_widget.dart';
import '../../../shared/presentation/my_ticket_qr_bottom_sheet.dart';
import '../../../wallet/domain/repository/wallet_core_repository.dart';
import '../../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../../data/model/response/ask_ai_response.dart';
import '../../data/model/response/get_detail_ticket_response.dart';
import '../../domain/entity/chat_entity.dart';
import '../cubit/ask_ai_cubit.dart';
import '../widget/home_chat_menu_widget.dart';

class HomeChatTabBarView extends StatefulWidget {
  const HomeChatTabBarView({super.key});

  @override
  State<HomeChatTabBarView> createState() => _HomeChatTabBarViewState();
}

class _HomeChatTabBarViewState extends State<HomeChatTabBarView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _chatController = TextEditingController();

  List<ChatEntity> _chats = [];

  @override
  void dispose() {
    _scrollController.dispose();
    _chatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          if (_chats.isEmpty) _emptyChat(),
          _filledChat(),
          _chatField(),
        ],
      ),
    );
  }

  Widget _filledChat() {
    return BlocConsumer<AskAiCubit, AskAiState>(
      listener: (context, state) {
        if (state is AskAiLoaded) {
          _chats.removeLast();
          final chat = ChatEntity(
            response: state.result,
            isSystem: true,
            isTyping: true,
          );
          _chats.add(chat);

          _scrollToBottom();
          Future.delayed(const Duration(milliseconds: 5000), () {
            _chats.last = _chats.last.copyWith(isTyping: false);
          });
        } else if (state is AskAiLoading) {
          final question = ChatEntity(
            response: AskAiResponse(
              message: state.question,
            ),
          );
          const loading = ChatEntity(isSystem: true, isLoading: true);

          if (_chats.isNotEmpty) {
            _chats.addAll([question, loading]);
          } else {
            setState(() {
              _chats.addAll([question, loading]);
            });
          }

          _scrollToBottom();
        } else if (state is AskAiError) {
          _chats.removeLast();
          final chat = ChatEntity(
            response: AskAiResponse(
              message: state.message,
            ),
            isSystem: true,
          );
          _chats.add(chat);

          _scrollToBottom();
        }
      },
      builder: (context, state) {
        if (_chats.isEmpty) {
          return const SizedBox();
        }

        return Positioned.fill(
          top: 20.h,
          bottom: 96.h,
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final chat = _chats[index];

              return _ChatBubbleItem(
                chat: chat,
                scrollToBottom: _scrollToBottom,
              );
            },
            itemCount: _chats.length,
            padding: Paddings.defaultPaddingH,
          ),
        );
      },
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _emptyChat() {
    return Positioned.fill(
      child: SingleChildScrollView(
        padding: Paddings.defaultPaddingH,
        child: Column(
          children: <Widget>[
            UIGap.size(h: 100.h),
            SvgUI(
              SvgConst.icAiHome,
              width: 54.w,
              height: 54.h,
            ),
            UIGap.size(h: 30.h),
            Text(
              'Welcome, Dani',
              style: UITypographies.h2(
                context,
                fontSize: 28.sp,
              ),
            ),
            UIGap.size(h: 4.h),
            Text(
              'Ask anything about events, tickets, or more.',
              style: UITypographies.bodyLarge(
                context,
                color: UIColors.grey500,
              ),
            ),
            UIGap.size(h: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: <Widget>[
                  HomeChatMenuWidget(
                    icon: IconsConst.icConcertHome,
                    title: 'Find concerts',
                    subtitle: 'near me this weekend.',
                    onTap: _onTemplateTap,
                  ),
                  UIGap.h12,
                  HomeChatMenuWidget(
                    icon: IconsConst.icFestivalHome,
                    title: 'Explore top festivals',
                    subtitle: 'this month.',
                    onTap: _onTemplateTap,
                  ),
                  UIGap.h12,
                  HomeChatMenuWidget(
                    icon: IconsConst.icTicketHome,
                    title: 'Check tickets',
                    subtitle: 'for sports events.',
                    onTap: _onTemplateTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatField() {
    return Positioned(
      bottom: 0,
      child: _ChatTextFieldWidget(
        controller: _chatController,
        onSend: _onSend,
        onVoice: _onVoice,
      ),
    );
  }

  void _onSend(String value) {
    final walletAddress = _getWalletAddress();
    if (walletAddress != null) {
      context.read<AskAiCubit>().askAi(
            question: value,
            userAddress: walletAddress,
          );
    }
  }

  void _onVoice() {}

  String? _getWalletAddress() {
    final activeWalletCubit = BlocProvider.of<ActiveWalletCubit>(context);
    final activeWallet = activeWalletCubit.getActiveWallet();
    if (activeWallet != null) {
      return locator<WalletCoreRepository>().getWalletAddress(
        wallet: activeWallet,
      );
    }

    return null;
  }

  void _onTemplateTap(String value) {
    _onSend(value);
  }
}

class _ChatTextFieldWidget extends StatelessWidget {
  _ChatTextFieldWidget({
    required this.controller,
    required this.onSend,
    required this.onVoice,
  });

  final TextEditingController controller;
  final Function(String value) onSend;
  final Function() onVoice;

  final ValueNotifier<bool> _isTyping = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 96.h,
      color: UIColors.black500,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 30.h,
        left: 0.w,
        right: 16.w,
      ),
      child: _chatField(),
    );
  }

  Widget _chatField() {
    return UITextField(
      onChanged: _onTyping,
      textController: controller,
      radius: 99.r,
      hint: 'Chat with Tibot...',
      suffixIcon: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: UIColors.primary500,
          borderRadius: BorderRadius.circular(999),
        ),
        child: ValueListenableBuilder(
          valueListenable: _isTyping,
          builder: (context, bool isTyping, _) {
            return IconButton(
              icon: Icon(
                isTyping ? Icons.north : Icons.mic,
                color: UIColors.white50,
              ),
              onPressed: isTyping ? _onSend : _onVoice,
            );
          },
        ),
      ),
      hintColor: UIColors.white50.withOpacity(0.4),
      fillColor: UIColors.black400,
      borderColor: UIColors.white50.withOpacity(0.15),
    );
  }

  void _onTyping(String value) {
    if (value != '') {
      _isTyping.value = true;
    } else {
      _isTyping.value = false;
    }
  }

  void _onSend() {
    onSend(controller.text);
    controller.clear();
    _isTyping.value = false;
  }

  void _onVoice() {
    onVoice();
  }
}

class _ChatBubbleItem extends StatelessWidget {
  final ChatEntity chat;
  final Function scrollToBottom;

  const _ChatBubbleItem({
    required this.chat,
    required this.scrollToBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chat.isSystem ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chat.isSystem) ...[
            _circularAvatar(),
            UIGap.w8,
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _chatBody(context),
                if (chat.response?.events != null &&
                    chat.response!.events.isNotEmpty)
                  _eventList(
                    context,
                    chat.response!.events,
                  ),
                if (chat.response?.tickets != null &&
                    chat.response!.tickets.isNotEmpty)
                  _ticketList(
                    context,
                    chat.response!.tickets,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.only(
        top: 8.h,
        bottom: 8.h,
        right: chat.isSystem ? 32.w : 0,
        left: chat.isSystem ? 0 : 32.w,
      ),
      decoration: BoxDecoration(
        color: chat.isSystem ? UIColors.black400 : UIColors.blue500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: !chat.isSystem ? Radius.zero : Radius.circular(16.r),
        ),
      ),
      child: chat.isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(UIColors.white50),
                strokeWidth: 2,
              ),
            )
          : _text(context),
    );
  }

  Widget _text(BuildContext context) {
    final styles = MarkdownStyleSheet(
      p: UITypographies.bodyMedium(
        context,
        color: UIColors.white50,
      ),
      listBullet: UITypographies.bodyMedium(
        context,
        color: UIColors.white50,
      ),
      h1: UITypographies.h1(
        context,
        color: UIColors.white50,
      ),
      h2: UITypographies.h2(
        context,
        color: UIColors.white50,
      ),
      h3: UITypographies.h3(
        context,
        color: UIColors.white50,
      ),
      h4: UITypographies.h4(
        context,
        color: UIColors.white50,
      ),
    );

    if (chat.isTyping && chat.isSystem) {
      return TypeWriter(
        controller: TypeWriterController(
          text: chat.response?.message ?? '',
          duration: const Duration(milliseconds: 10),
        ),
        onFinished: (_) => scrollToBottom(),
        builder: (context, value) {
          Future.delayed(const Duration(milliseconds: 300), () {
            scrollToBottom();
          });

          return MarkdownBody(
            data: value.text,
            styleSheet: styles,
          );
        },
      );
    }

    return MarkdownBody(
      data: chat.response?.message ?? '',
      styleSheet: styles,
    );
  }

  Widget _circularAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      height: 32.h,
      width: 32.w,
      child: const CircleAvatar(
        backgroundImage: AssetImage(
          ImagesConst.appLogo,
        ),
      ),
    );
  }

  Widget _eventList(
    BuildContext context,
    List<Event> events,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16.w,
        children: events
            .map(
              (e) => EventCardWidget(
                width: 240,
                image: e.banner ?? '',
                title: e.name ?? '',
                desc: e.description ?? '',
                estimatePrice: (e.ticketTypes?.first.price ?? 0).toString(),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _ticketList(
      BuildContext context, List<GetDetailTicketResponse> tickets) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16.w,
        children: tickets
            .map(
              (e) => EventCardWidget(
                width: 240,
                image: e.event?.banner ?? '',
                title: e.event?.name ?? '',
                desc: e.event?.description ?? '',
                estimatePrice:
                    (e.event?.ticketTypes?.first.price ?? 0).toString(),
                haveTicket: true,
                onTapMyTicket: () async {
                  await ModalHelper.showModalBottomSheet(
                    context,
                    child: MyTicketQrBottomSheet(
                      ticketId: e.ticketId?.toString() ?? '',
                    ),
                    isHasCloseButton: false,
                    padding: EdgeInsets.zero,
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
