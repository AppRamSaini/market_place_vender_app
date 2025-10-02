import 'dart:io';

import '../../utils/exports.dart';

abstract class IssueReportEvent {}
abstract class IssueReportHistoryEvent {}

abstract class IssueReportDetailsEvent {}



class FetchIssueCategoryReportEvent extends IssueReportEvent {}
class FetchIssueReportHistoryEvent extends IssueReportHistoryEvent {
  final String type;
  final BuildContext context;
  FetchIssueReportHistoryEvent({required this.type,required this.context});
}



class FetchIssueReportDetailsEvent extends IssueReportDetailsEvent {
  final String uuid;
  FetchIssueReportDetailsEvent({required this.uuid});
}

class SubmitCreateReportEvent extends IssueReportEvent {
  final BuildContext context;
  SubmitReportModel submitReportModel;
  SubmitCreateReportEvent(
      {required this.context, required this.submitReportModel});
}

class SubmitReportModel {
  String? categoryUUID;
  String? deliveryUUID;
  String? action;
  String? description;
  String? priority;
  List<File>? imageList;
  List<File>? videoList;
  List<File>? audioList;

  SubmitReportModel(
      {this.description,
      this.action,
      this.audioList,
      this.priority,
      this.categoryUUID,
        this.deliveryUUID,
      this.imageList,
      this.videoList});
}



/// set dat event

class VoiceDataEvent extends IssueReportDetailsEvent {
  final List<File> audioList;
  VoiceDataEvent({required this.audioList});
}