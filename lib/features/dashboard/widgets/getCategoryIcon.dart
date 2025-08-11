import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getCategoryIcon(String? category, String title) {
  final name = (category ?? title).toLowerCase();

  // Rides & Transport
  if (name.contains('uber')) return FontAwesomeIcons.uber;
  if (name.contains('ola')) return FontAwesomeIcons.taxi;
  if (name.contains('lyft')) return FontAwesomeIcons.taxi;

  // Food & Delivery
  if (name.contains('swiggy')) return Icons.delivery_dining_rounded;
  if (name.contains('zomato')) return Icons.restaurant_rounded;
  if (name.contains('domino')) return Icons.local_pizza_rounded;
  if (name.contains('pizza')) return Icons.local_pizza_rounded;
  if (name.contains('mcdonald')) return Icons.lunch_dining_rounded;
  if (name.contains('food')) return Icons.fastfood_rounded;

  // Shopping
  if (name.contains('amazon')) return FontAwesomeIcons.amazon;
  if (name.contains('flipkart')) return Icons.shopping_cart_rounded;
  if (name.contains('myntra')) return Icons.shopping_bag_rounded;
  if (name.contains('shopping')) return Icons.shopping_bag_rounded;

  // Entertainment & Subscriptions
  if (name.contains('netflix')) return Icons.ondemand_video_rounded;
  if (name.contains('spotify')) return FontAwesomeIcons.spotify;
  if (name.contains('youtube')) return FontAwesomeIcons.youtube;
  if (name.contains('prime')) return FontAwesomeIcons.amazon;
  if (name.contains('hotstar')) return Icons.tv_rounded;
  if (name.contains('disney')) return Icons.tv_rounded;
  if (name.contains('entertainment')) return Icons.movie_filter_rounded;

  // Finance
  if (name.contains('bank')) return Icons.account_balance_rounded;
  if (name.contains('paypal')) return FontAwesomeIcons.paypal;
  if (name.contains('paytm')) return Icons.account_balance_wallet_rounded;
  if (name.contains('upi')) return Icons.account_balance_wallet_rounded;

  // Travel & Stay
  if (name.contains('airbnb')) return FontAwesomeIcons.airbnb;
  if (name.contains('makemytrip')) return Icons.flight_takeoff_rounded;
  if (name.contains('trip')) return Icons.card_travel_rounded;
  if (name.contains('hotel')) return Icons.hotel_rounded;
  if (name.contains('flight')) return Icons.flight_rounded;

  // Health & Fitness
  if (name.contains('pharmacy')) return Icons.local_hospital_rounded;
  if (name.contains('doctor')) return Icons.local_hospital_rounded;
  if (name.contains('gym')) return Icons.fitness_center_rounded;
  if (name.contains('workout')) return Icons.fitness_center_rounded;

  // Utilities
  if (name.contains('electricity')) return Icons.electric_bolt_rounded;
  if (name.contains('water')) return Icons.water_drop_rounded;
  if (name.contains('gas')) return Icons.local_gas_station_rounded;
  if (name.contains('internet')) return Icons.wifi_rounded;
  if (name.contains('recharge')) return Icons.phone_android_rounded;

  // Default
  return Icons.receipt_long_rounded;
}
