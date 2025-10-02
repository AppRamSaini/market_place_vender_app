import 'package:market_place_app/data/models/issue_category_model.dart';
import 'package:market_place_app/data/models/issue_report_details_model.dart';
import 'package:market_place_app/data/models/issue_report_model.dart';
import 'package:market_place_app/utils/exports.dart';

abstract class IssueReportState {}

class IssueReportInitial extends IssueReportState {}

class IssueReportLoading extends IssueReportState {}

class IssueReportSuccess extends IssueReportState {
  final IssueCategoryModel issueCategoryModel;
  IssueReportSuccess({required this.issueCategoryModel});
}


class IssueReportFailure extends IssueReportState {
  final String error;
  IssueReportFailure({required this.error});
}

class IssueReportInvalidResult extends IssueReportState {}


/// issue report history
abstract class IssueReportHistoryState {}

class IssueReportHistoryInitial extends IssueReportHistoryState {}

class IssueReportHistoryLoading extends IssueReportHistoryState {}

class IssueReportHistorySuccess extends IssueReportHistoryState {
  final IssueReportHistoryModel issueReportHistoryModel;
  IssueReportHistorySuccess({required this.issueReportHistoryModel});
}
class IssueReportHistoryFailure extends IssueReportHistoryState {
  final String error;
  IssueReportHistoryFailure({required this.error});
}
class IssueReportHistoryInvalidResult extends IssueReportState {}



/// issue report history
abstract class IssueReportDetailsState {}

class IssueReportDetailsInitial extends IssueReportDetailsState {}

class IssueReportDetailsLoading extends IssueReportDetailsState {}

class IssueReportDetailsSuccess extends IssueReportDetailsState {
  final IssueReportDetailsModel issueReportDetailsModel;
  IssueReportDetailsSuccess({required this.issueReportDetailsModel});
}
class IssueReportDetailsFailure extends IssueReportDetailsState {
  final String error;
  IssueReportDetailsFailure({required this.error});
}
class IssueReportDetailsInvalidResult extends IssueReportState {}


/// create issue report history
abstract class CreateIssueReportState {}

class CreateIssueReportInitial extends CreateIssueReportState {}

class CreateIssueReportLoading extends CreateIssueReportState {}

class CreateIssueReportSuccess extends CreateIssueReportState {
  final String successMsg;
  CreateIssueReportSuccess({required this.successMsg});
}
class CreateIssueReportFailure extends CreateIssueReportState {
  final String error;
  CreateIssueReportFailure({required this.error});
}
class CreateIssueReportInvalidResult extends CreateIssueReportState {}


/// set data state
abstract class VoiceDataState {}


class VoiceDateInitial extends VoiceDataState {}
class VoiceDateLoading extends VoiceDataState {}

class VoiceDateSuccess extends VoiceDataState {
  final  List<File> audioList;
  VoiceDateSuccess({required this.audioList});
}

class VoiceDateFailed extends VoiceDataState {}


