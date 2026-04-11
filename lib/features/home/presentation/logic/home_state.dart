import '../../domain/entities/trending_coin.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TrendingCoin> coins;
  HomeSuccess(this.coins );
}

class CategorySuccess extends HomeState {
  final List<TrendingCoin> categories;
  CategorySuccess(this.categories);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
