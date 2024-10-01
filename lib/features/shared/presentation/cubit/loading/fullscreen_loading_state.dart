part of 'fullscreen_loading_cubit.dart';

abstract class FullscreenLoadingState extends Equatable {
  const FullscreenLoadingState();

  @override
  List<Object> get props => [];
}

class FullscreenLoadingInitial extends FullscreenLoadingState {}

class ShowFullScreenLoading extends FullscreenLoadingState {
  final String title;
  final String subtitle;

  const ShowFullScreenLoading({
    required this.title,
    required this.subtitle,
  });

  @override
  List<Object> get props => [title, subtitle];
}

class HideFullScreenLoading extends FullscreenLoadingState {}
