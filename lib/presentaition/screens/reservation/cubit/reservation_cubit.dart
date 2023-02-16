// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

// import '../../../../domain/models/reservations_model.dart';
// import '../../../../domain/repositry/reservation_repo/reservation_repo.dart';

// part 'reservation_state.dart';

// class ReservationCubit extends Cubit<ReservationState> {
//   ReservationCubit() : super(ReservationInitial());
//   static ReservationCubit get(context) => BlocProvider.of(context);
//   List<ReservationsModel> reservationsModel = [];
//   ReservationsModel? oneReservations;
//   int index = 0;
//   getAllReservation(context) async {
//     emit(LoadingReservations());

//     final response = await ReservationRepo.fetchAllReservation(context);
//     if (response != null) {
//       reservationsModel = response;
//       print(reservationsModel);
//       emit(SuccessReservations());
//     } else {
//       emit(ErrorReservations());
//     }
//   }

//   getOneReservation(id, context) async {
//     emit(OneLoadingReservations());
//     index = 0;
//     final response = await ReservationRepo.fetchOneReservation(id, context);
//     if (response != null) {
//       oneReservations = response;
//       for (Progress d in oneReservations?.progress ?? []) {
//         d.status == 'finished' ? index += 1 : null;
//         print(index);
//       }
//       print(reservationsModel);
//       emit(OneSuccessReservations());
//     } else {
//       emit(OneErrorReservations());
//     }
//   }

//   int indexData = 0;

//   changeIndex(i) {
//     indexData = i;
//     emit(ChangeIndexReservations());
//   }
// }
