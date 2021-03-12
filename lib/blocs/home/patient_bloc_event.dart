import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc_event.dart';
import 'package:flutter/widgets.dart';

abstract class PatientAppointmentBlocEvent extends BaseBlocEvent {}

class GetPatientAppointmentBlocEvent extends PatientAppointmentBlocEvent {
  @override
  //declaring the list of objects
  List<Object> get props => [];
}

class SearchPatientEvent extends PatientAppointmentBlocEvent {
  final String keyword;
//writting the search event
  SearchPatientEvent({@required this.keyword});

  @override
  List<Object> get props => [this.keyword];
}

class GetProvidersListEvent extends PatientAppointmentBlocEvent {
  final String memberId;
// Event  for geting the list of provider
  GetProvidersListEvent({this.memberId});

  @override
  List<Object> get props => [this.memberId];
}

// Creating an event GetSchedulePatientList
class GetSchedulePatientsList extends PatientAppointmentBlocEvent {
  //declaring the variables for event
  final String keyword1;
  final int providerId;
  final int locationId;
  final int dictationId;
  final String startDate;
  final String endDate;
  final String searchString;
  final int memberId;
  GetSchedulePatientsList({
    @required this.keyword1,
    @required this.providerId,
    @required this.locationId,
    @required this.dictationId,
    this.startDate,
    this.endDate,
    this.searchString,
    this.memberId,
  });
  @override
  List<Object> get props => [
        this.keyword1,
        this.providerId,
        this.locationId,
        this.dictationId,
        this.startDate,
        this.endDate,
        this.searchString,
        this.memberId,
      ];
}
