import 'dart:async';
import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc.dart';
import '../../blocs/home/patient_bloc_event.dart';
import '../../blocs/home/patient_bloc_state.dart';
import '../../network/models/home/schedule.dart';
import '../../network/services/schedules/appointment_service.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';

class PatientBloc
    extends BaseBloc<PatientAppointmentBlocEvent, PatientAppointmentBlocState> {
  PatientBloc() : super(PatientAppointmentBlocState.initial());

  @override
  Stream<PatientAppointmentBlocState> mapEventToState(
      PatientAppointmentBlocEvent event) async* {
    print("mapEventToState=$event");
    var memberId =
        await MySharedPreferences.instance.getStringValue(Keys.memberId);
    print('memberID $memberId');
//event for Search Patient
    if (event is SearchPatientEvent) {
      yield state.copyWith(keyword: event.keyword);
    }

//event for GetScheduledPatientList
    if (event is GetSchedulePatientsList) {
      yield state.reset();
      yield state.copyWith(
        isLoading: true,
      );

      List<ScheduleList> patients;
      patients = await Services.getSchedule(
          event.keyword1,
          event.providerId,
          event.locationId,
          event.dictationId,
          event.startDate,
          event.endDate,
          event.searchString,
          int.tryParse(memberId));
      if (patients == null || patients.isEmpty) {
        yield state.copyWith(
            isLoading: false,
            errorMsg: "No Patients Available",
            patients: patients);
      } else {
        yield state.copyWith(
            isLoading: false, errorMsg: null, patients: patients);
      }
    }
  }
}
