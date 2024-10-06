part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeItemFavouriteEvent extends HomeEvent {
  FeaturedItem featuredItem;
  HomeItemFavouriteEvent({required this.featuredItem});
}

class HomeSignOutEvent extends HomeEvent {
  BuildContext context;
  HomeSignOutEvent({required this.context});
}
