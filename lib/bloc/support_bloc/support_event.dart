import 'package:market_place_app/utils/exports.dart';

abstract class SupportEvent {}

class FetchSupportEvent extends SupportEvent {
  final BuildContext context;
  FetchSupportEvent({required this.context});
}
