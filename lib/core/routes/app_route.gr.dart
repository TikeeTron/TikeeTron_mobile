// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

/// generated route for
/// [CreateWalletPage]
class CreateWalletRoute extends PageRouteInfo<void> {
  const CreateWalletRoute({List<PageRouteInfo>? children})
      : super(
          CreateWalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateWalletPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [ImportWalletPage]
class ImportWalletRoute extends PageRouteInfo<void> {
  const ImportWalletRoute({List<PageRouteInfo>? children})
      : super(
          ImportWalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImportWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ImportWalletPage();
    },
  );
}

/// generated route for
/// [MyWalletPage]
class MyWalletRoute extends PageRouteInfo<MyWalletRouteArgs> {
  MyWalletRoute({
    Key? key,
    required WalletModel wallet,
    List<PageRouteInfo>? children,
  }) : super(
          MyWalletRoute.name,
          args: MyWalletRouteArgs(
            key: key,
            wallet: wallet,
          ),
          initialChildren: children,
        );

  static const String name = 'MyWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyWalletRouteArgs>();
      return MyWalletPage(
        key: args.key,
        wallet: args.wallet,
      );
    },
  );
}

class MyWalletRouteArgs {
  const MyWalletRouteArgs({
    this.key,
    required this.wallet,
  });

  final Key? key;

  final WalletModel wallet;

  @override
  String toString() {
    return 'MyWalletRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [OnBoardingPage]
class OnBoardingRoute extends PageRouteInfo<void> {
  const OnBoardingRoute({List<PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnBoardingPage();
    },
  );
}

/// generated route for
/// [ReceiptPage]
class ReceiptRoute extends PageRouteInfo<ReceiptRouteArgs> {
  ReceiptRoute({
    Key? key,
    required ReceiptModel data,
    List<PageRouteInfo>? children,
  }) : super(
          ReceiptRoute.name,
          args: ReceiptRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceiptRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReceiptRouteArgs>();
      return ReceiptPage(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class ReceiptRouteArgs {
  const ReceiptRouteArgs({
    this.key,
    required this.data,
  });

  final Key? key;

  final ReceiptModel data;

  @override
  String toString() {
    return 'ReceiptRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [ReceivePage]
class ReceiveRoute extends PageRouteInfo<ReceiveRouteArgs> {
  ReceiveRoute({
    Key? key,
    required String walletAddress,
    List<PageRouteInfo>? children,
  }) : super(
          ReceiveRoute.name,
          args: ReceiveRouteArgs(
            key: key,
            walletAddress: walletAddress,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceiveRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReceiveRouteArgs>();
      return ReceivePage(
        key: args.key,
        walletAddress: args.walletAddress,
      );
    },
  );
}

class ReceiveRouteArgs {
  const ReceiveRouteArgs({
    this.key,
    required this.walletAddress,
  });

  final Key? key;

  final String walletAddress;

  @override
  String toString() {
    return 'ReceiveRouteArgs{key: $key, walletAddress: $walletAddress}';
  }
}

/// generated route for
/// [SelectRecipientPage]
class SelectRecipientRoute extends PageRouteInfo<SelectRecipientRouteArgs> {
  SelectRecipientRoute({
    Key? key,
    required SendTypeEnum sendType,
    List<PageRouteInfo>? children,
  }) : super(
          SelectRecipientRoute.name,
          args: SelectRecipientRouteArgs(
            key: key,
            sendType: sendType,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectRecipientRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectRecipientRouteArgs>();
      return SelectRecipientPage(
        key: args.key,
        sendType: args.sendType,
      );
    },
  );
}

class SelectRecipientRouteArgs {
  const SelectRecipientRouteArgs({
    this.key,
    required this.sendType,
  });

  final Key? key;

  final SendTypeEnum sendType;

  @override
  String toString() {
    return 'SelectRecipientRouteArgs{key: $key, sendType: $sendType}';
  }
}

/// generated route for
/// [SendPage]
class SendRoute extends PageRouteInfo<void> {
  const SendRoute({List<PageRouteInfo>? children})
      : super(
          SendRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SendPage();
    },
  );
}

/// generated route for
/// [SendTicketPage]
class SendTicketRoute extends PageRouteInfo<SendTicketRouteArgs> {
  SendTicketRoute({
    Key? key,
    required String walletAddress,
    List<PageRouteInfo>? children,
  }) : super(
          SendTicketRoute.name,
          args: SendTicketRouteArgs(
            key: key,
            walletAddress: walletAddress,
          ),
          initialChildren: children,
        );

  static const String name = 'SendTicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendTicketRouteArgs>();
      return SendTicketPage(
        key: args.key,
        walletAddress: args.walletAddress,
      );
    },
  );
}

class SendTicketRouteArgs {
  const SendTicketRouteArgs({
    this.key,
    required this.walletAddress,
  });

  final Key? key;

  final String walletAddress;

  @override
  String toString() {
    return 'SendTicketRouteArgs{key: $key, walletAddress: $walletAddress}';
  }
}

/// generated route for
/// [SendTokenPage]
class SendTokenRoute extends PageRouteInfo<SendTokenRouteArgs> {
  SendTokenRoute({
    Key? key,
    required String walletAddress,
    List<PageRouteInfo>? children,
  }) : super(
          SendTokenRoute.name,
          args: SendTokenRouteArgs(
            key: key,
            walletAddress: walletAddress,
          ),
          initialChildren: children,
        );

  static const String name = 'SendTokenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendTokenRouteArgs>();
      return SendTokenPage(
        key: args.key,
        walletAddress: args.walletAddress,
      );
    },
  );
}

class SendTokenRouteArgs {
  const SendTokenRouteArgs({
    this.key,
    required this.walletAddress,
  });

  final Key? key;

  final String walletAddress;

  @override
  String toString() {
    return 'SendTokenRouteArgs{key: $key, walletAddress: $walletAddress}';
  }
}

/// generated route for
/// [SuccessCreateWalletPage]
class SuccessCreateWalletRoute extends PageRouteInfo<SuccessCreateWalletRouteArgs> {
  SuccessCreateWalletRoute({
    Key? key,
    required SuccessCreateWalletPageParams params,
    List<PageRouteInfo>? children,
  }) : super(
          SuccessCreateWalletRoute.name,
          args: SuccessCreateWalletRouteArgs(
            key: key,
            params: params,
          ),
          initialChildren: children,
        );

  static const String name = 'SuccessCreateWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuccessCreateWalletRouteArgs>();
      return SuccessCreateWalletPage(
        key: args.key,
        params: args.params,
      );
    },
  );
}

class SuccessCreateWalletRouteArgs {
  const SuccessCreateWalletRouteArgs({
    this.key,
    required this.params,
  });

  final Key? key;

  final SuccessCreateWalletPageParams params;

  @override
  String toString() {
    return 'SuccessCreateWalletRouteArgs{key: $key, params: $params}';
  }
}
