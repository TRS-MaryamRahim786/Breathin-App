import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../model/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController homeSearchBarController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // Your featured item data
  final List<FeaturedItem> featuredItems = [
    FeaturedItem(
        title: 'Drift Off',
        time: '10 mins',
        category: 'Sleep',
        imageUrl:
            'https://images.unsplash.com/photo-1560193327-e52dafa295f4?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    FeaturedItem(
        title: 'Calm',
        time: '05 mins',
        category: 'Sleep',
        imageUrl: 'https://example.com/image2.jpg'),
    FeaturedItem(
        title: 'Breath',
        time: '03 mins',
        category: 'Sleep',
        imageUrl: 'https://example.com/image3.jpg'),
    FeaturedItem(
        title: 'Calm',
        time: '05 mins',
        category: 'Sleep',
        imageUrl: 'https://example.com/image2.jpg'),
    FeaturedItem(
        title: 'Breath',
        time: '03 mins',
        category: 'Sleep',
        imageUrl: 'https://example.com/image3.jpg'),
  ];

  HomeBloc() : super(HomeInitialState()) {
    on<HomeItemFavouriteEvent>((event, emit) {
      event.featuredItem.isFavorite = !event.featuredItem.isFavorite;
      event.featuredItem;
      emit(HomeUpdateItemState());
      // TODO: implement event handler
    });
  }
}
