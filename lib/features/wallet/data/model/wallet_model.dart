import 'package:equatable/equatable.dart';

import '../../../../core/adapters/blockchain_network_adapter.dart';
import 'tag_data_model.dart';
import 'token_model.dart';
import 'wallet_address_model.dart';

class WalletModel extends Equatable {
  final String? name;
  final String? status;
  final String? method;
  final bool? readOnly;
  final dynamic totalBalance;
  final dynamic balanceInFiat;
  final int? walletPath;
  final bool? isGeneric;
  final bool? isLoading;
  final List<dynamic>? nft;
  final List<dynamic>? nonVisibleNFT;
  final TagDataModel? tagData;

  // CHANGED DATA TYPE
  final dynamic seed; // from String to dynamic
  final DateTime? createdAt; // from String to DateTime
  final DateTime? lastUpdate; // from String to DateTime
  final List<TokenModel>? tokenList; // from List<Map<String, Object>> to List<TokenModel>

  // ADD NEW
  final String? userName;
  final String? userEmail;
  final String? userProfilePictureUrl;
  final String? appVersion;
  final String? tikeetronUsername;
  final List<WalletAddressModel>? addresses;

  const WalletModel({
    this.name,
    // this.address,
    this.seed,
    // this.privateKey,
    this.tokenList,
    this.status,
    this.method,
    this.readOnly,
    this.totalBalance,
    this.balanceInFiat,
    this.lastUpdate,
    this.walletPath,
    // this.network,
    this.isGeneric,
    this.createdAt,
    this.isLoading,
    this.nft,
    this.userName,
    this.userEmail,
    this.userProfilePictureUrl,
    this.nonVisibleNFT,
    this.appVersion,
    this.tikeetronUsername,
    this.addresses,
    this.tagData,
  });

  factory WalletModel.fromJson(Map<dynamic, dynamic> json) {
    return WalletModel(
      name: json['name'],
      // address: json['address'],
      seed: json['seed'],
      // privateKey: json['privateKey'],
      status: json['status'],
      method: json['method'],
      readOnly: json['readOnly'],
      totalBalance: json['totalBalance'],
      balanceInFiat: json['balanceInFiat'],
      lastUpdate: json['lastUpdate'],
      walletPath: json['walletPath'],
      // network: json['network'],
      tagData: json['tagData'] != null ? TagDataModel.fromJson(json['tagData']['data']) : null,
      isGeneric: json['isGeneric'],
      createdAt: json['createdAt'],
      isLoading: json['isLoading'],
      nft: json['nft'],
      tokenList: (json['tokenList'] as List<dynamic>?)?.map((e) => TokenModel.fromJson(e)).toList(),
      userName: json['userName'],
      userEmail: json['userEmail'],
      userProfilePictureUrl: json['userProfilePictureUrl'],
      nonVisibleNFT: json['nonVisibleNFT'],
      appVersion: json['app_version'],
      tikeetronUsername: json['tikeetronUsername'],
      addresses: (json['addresses'] as List<dynamic>?)?.map((e) => WalletAddressModel.fromJson(e)).toList(),
    );
  }

  WalletModel copyWith({
    int? index,
    String? name,
    String? address,
    dynamic seed,
    String? privateKey,
    List<TokenModel>? tokenList,
    String? status,
    String? method,
    bool? readOnly,
    dynamic totalBalance,
    dynamic balanceInFiat,
    DateTime? lastUpdate,
    int? walletPath,
    BlockchainNetwork? network,
    bool? isGeneric,
    DateTime? createdAt,
    bool? isLoading,
    List<dynamic>? nft,
    String? userName,
    String? userEmail,
    String? userProfilePictureUrl,
    List<dynamic>? nonVisibleNFT,
    String? appVersion,
    String? tikeetronUsername,
    List<WalletAddressModel>? addresses,
    TagDataModel? tagData,
  }) {
    return WalletModel(
      name: name ?? this.name,
      seed: seed ?? this.seed,
      tokenList: tokenList ?? this.tokenList,
      status: status ?? this.status,
      method: method ?? this.method,
      readOnly: readOnly ?? this.readOnly,
      totalBalance: totalBalance ?? this.totalBalance,
      balanceInFiat: balanceInFiat ?? this.balanceInFiat,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      walletPath: walletPath ?? this.walletPath,
      isGeneric: isGeneric ?? this.isGeneric,
      createdAt: createdAt ?? this.createdAt,
      isLoading: isLoading ?? this.isLoading,
      nft: nft ?? this.nft,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userProfilePictureUrl: userProfilePictureUrl ?? this.userProfilePictureUrl,
      nonVisibleNFT: nonVisibleNFT ?? this.nonVisibleNFT,
      appVersion: appVersion ?? this.appVersion,
      tikeetronUsername: tikeetronUsername ?? this.tikeetronUsername,
      addresses: addresses ?? this.addresses,
      tagData: tagData ?? this.tagData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "seed": seed,
      "tokenList": tokenList?.map((e) => e.toJson()).toList(),
      "status": status,
      "method": method,
      "readOnly": readOnly,
      "totalBalance": totalBalance,
      "balanceInFiat": balanceInFiat,
      "lastUpdate": lastUpdate,
      "walletPath": walletPath,
      "isGeneric": isGeneric,
      "createdAt": createdAt,
      "isLoading": isLoading,
      "nft": nft,
      "userName": userName,
      "userEmail": userEmail,
      "userProfilePictureUrl": userProfilePictureUrl,
      "nonVisibleNFT": nonVisibleNFT,
      "app_version": appVersion,
      "tagData": tagData?.toJson(),
      "tikeetronUsername": tikeetronUsername,
      "addresses": addresses?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'WalletModel: ${toJson()}';
  }

  @override
  List<Object?> get props => [
        name,
        // address,
        seed,
        // privateKey,
        tokenList,
        status,
        method,
        readOnly,
        totalBalance,
        balanceInFiat,
        lastUpdate,
        walletPath,
        // network,
        isGeneric,
        createdAt,
        isLoading,
        nft,
        userName,
        userEmail,
        userProfilePictureUrl,
        nonVisibleNFT,
        appVersion,
        tikeetronUsername,
        addresses,
        tagData,
      ];
}
