import 'package:market_place_app/data/models/issue_report_details_model.dart';
import 'package:market_place_app/data/models/issue_report_model.dart';
import 'package:market_place_app/utils/exports.dart';

/// ISSUE REPORT CATEGORY BLOC
class IssueReportBloc extends Bloc<IssueReportEvent, IssueReportState> {
  IssueCategoryModel? _issueCategoryModel;

  final issueRepo = IssueReportRepo();

  IssueReportBloc() : super(IssueReportInitial()) {
    on<FetchIssueCategoryReportEvent>(_onFetchIssueCategory);
    // on<SubmitCreateReportEvent>(_onSubmitIssueReportApi);
  }

  /// FETCH ISSUE CATEGORY DATA
  Future _onFetchIssueCategory(FetchIssueCategoryReportEvent event,
      Emitter<IssueReportState> state) async {
    emit(IssueReportLoading());
    try {
      final issueCategory = await issueRepo.fetchIssueCategory();
      if (issueCategory is String) {
        emit(IssueReportFailure(error: issueCategory.toString()));
      } else if (issueCategory == null) {
        emit(IssueReportFailure(error: issueCategory ?? 'Data not found!'));
      } else {
        _issueCategoryModel = issueCategory;
        emit(IssueReportSuccess(issueCategoryModel: _issueCategoryModel!));
      }
    } catch (e) {
      emit(IssueReportFailure(error: e.toString()));
    }
  }
}

/// CREATE ISSUE REPORT BLOC
class CreateIssueReportBloc
    extends Bloc<SubmitCreateReportEvent, CreateIssueReportState> {
  final issueRepo = IssueReportRepo();
  CreateIssueReportBloc() : super(CreateIssueReportInitial()) {
    on<SubmitCreateReportEvent>(_onSubmitIssueReportApi);
  }
  Future _onSubmitIssueReportApi(SubmitCreateReportEvent event,
      Emitter<CreateIssueReportState> state) async {
    emit(CreateIssueReportLoading());
    try {
      final report = await issueRepo.createIssueReport(
          event.context, event.submitReportModel);
      if (report is String) {
        emit(CreateIssueReportFailure(error: report.toString()));
      } else if (report == null) {
        emit(CreateIssueReportFailure(
            error: report ?? 'Something went wrong. Please try again'));
      } else {
        emit(
            CreateIssueReportSuccess(successMsg: report['message'].toString()));
      }
    } catch (e) {
      emit(CreateIssueReportFailure(error: e.toString()));
    }
  }
}

/// Report history api
class FetchIssueReportHistoryBloc
    extends Bloc<IssueReportHistoryEvent, IssueReportHistoryState> {
  IssueReportHistoryModel? _issueReportHistoryModel;
  final issueRepo = IssueReportRepo();
  FetchIssueReportHistoryBloc() : super(IssueReportHistoryInitial()) {
    on<FetchIssueReportHistoryEvent>(_onFetchIssueReportHistory);
  }

  /// FETCH ISSUE CATEGORY DATA
  Future _onFetchIssueReportHistory(FetchIssueReportHistoryEvent event,
      Emitter<IssueReportHistoryState> state) async {
    emit(IssueReportHistoryLoading());
    try {
      final issueHistory = await issueRepo.fetchIssueReportHistory(event.type);
      if (issueHistory is String) {
        emit(IssueReportHistoryFailure(error: issueHistory.toString()));
      } else if (issueHistory == null) {
        emit(IssueReportHistoryFailure(
            error: issueHistory ?? 'Data not found!'));
      } else {
        _issueReportHistoryModel = issueHistory;
        emit(IssueReportHistorySuccess(
            issueReportHistoryModel: _issueReportHistoryModel!));
      }
    } catch (e) {
      emit(IssueReportHistoryFailure(error: e.toString()));
    }
  }
}

/// Report issue details bloc
class FetchIssueReportDetailsBloc
    extends Bloc<IssueReportDetailsEvent, IssueReportDetailsState> {
  IssueReportDetailsModel? _issueReportDetailsModel;
  final issueRepo = IssueReportRepo();
  FetchIssueReportDetailsBloc() : super(IssueReportDetailsInitial()) {
    on<FetchIssueReportDetailsEvent>(_onFetchIssueReportDetails);
  }

  /// FETCH ISSUE REPORT DETAILS DATA
  Future _onFetchIssueReportDetails(FetchIssueReportDetailsEvent event,
      Emitter<IssueReportDetailsState> state) async {
    emit(IssueReportDetailsLoading());
    try {
      final issueDetails = await issueRepo.fetchIssueReportDetails(event.uuid);
      if (issueDetails is String) {
        emit(IssueReportDetailsFailure(error: issueDetails.toString()));
      } else if (issueDetails == null) {
        emit(IssueReportDetailsFailure(
            error: issueDetails ?? 'Data not found!'));
      } else {
        _issueReportDetailsModel = issueDetails;
        emit(IssueReportDetailsSuccess(
            issueReportDetailsModel: _issueReportDetailsModel!));
      }
    } catch (e) {
      emit(IssueReportDetailsFailure(error: e.toString()));
    }
  }
}

/// Report issue details bloc
class SetVoiceDataBloc extends Bloc<VoiceDataEvent, VoiceDataState> {
  SetVoiceDataBloc() : super(VoiceDateInitial()) {
    on<VoiceDataEvent>(_setVoiceData);
  }

  List<File> audioList = [];
  Future _setVoiceData(
      VoiceDataEvent event, Emitter<VoiceDataState> state) async {
    emit(VoiceDateLoading());
    try {
      audioList = event.audioList;
      emit(VoiceDateSuccess(audioList: audioList));
    } catch (e) {
      emit(VoiceDateFailed());
    }
  }
}
