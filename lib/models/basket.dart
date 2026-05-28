import 'store.dart';

class Basket {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final int totalSlots;
  final int remainingSlots;
  final DateTime pickupStart;
  final DateTime pickupEnd;
  final Store store;
  bool isFavorite;

  Basket({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.totalSlots,
    required this.remainingSlots,
    required this.pickupStart,
    required this.pickupEnd,
    required this.store,
    this.isFavorite = false,
  });

  double get discountPercent =>
      ((originalPrice - discountedPrice) / originalPrice * 100);

  bool get isAlmostGone => remainingSlots <= 2;
}