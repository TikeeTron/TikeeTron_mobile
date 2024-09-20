import 'package:equatable/equatable.dart';

class CoinModel extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double amount;
  final double price;
  final double change;

  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.amount,
    required this.price,
    required this.change,
  });

  @override
  List<Object?> get props => [id, name, symbol, imageUrl, amount, price, change];
}

final dummyCoins = [
  CoinModel(
    id: 'bitcoin',
    name: 'Bitcoin',
    symbol: 'BTC',
    imageUrl: 'assets/images/token/img_btc.png',
    amount: 1.5,
    price: 50000,
    change: 0.5,
  ),
  CoinModel(
    id: 'ethereum',
    name: 'Ethereum',
    symbol: 'ETH',
    imageUrl: 'assets/images/token/img_eth.png',
    amount: 2.5,
    price: 3000,
    change: 0.3,
  ),
  CoinModel(
    id: 'binancecoin',
    name: 'Binance Coin',
    symbol: 'BNB',
    imageUrl: 'assets/images/token/img_bnb.png',
    amount: 3.5,
    price: 500,
    change: 0.7,
  ),
  CoinModel(
    id: 'tether',
    name: 'Tether',
    symbol: 'USDT',
    imageUrl: 'assets/images/token/img_usdt.png',
    amount: 4.5,
    price: 1,
    change: 0.1,
  ),
];

final dummyCoinsMore = [
  ...dummyCoins,
  ...dummyCoins,
  ...dummyCoins,
];
