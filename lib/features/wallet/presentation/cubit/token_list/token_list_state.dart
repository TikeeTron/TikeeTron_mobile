part of 'token_list_cubit.dart';

abstract class TokenListState extends Equatable {
  const TokenListState();

  @override
  List<Object?> get props => [];
}

class TokenListInitial extends TokenListState {}

class TokenListLoadingState extends TokenListState {}

class TokenListLoadedState extends TokenListState {}

class TokenListErrorState extends TokenListState {
  final String message;

  const TokenListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
