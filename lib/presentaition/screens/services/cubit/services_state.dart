part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesFirstChild extends ServicesState {}

class ServicesSecChild extends ServicesState {}

class SelectDateState extends ServicesState {}

class SelectContryState extends ServicesState {}

class SelectBranchState extends ServicesState {}

class SelectCarState extends ServicesState {}

class ServicesErrorState extends ServicesState {}

class ServicesSuccessState extends ServicesState {}

class ServicesLoadingState extends ServicesState {}

class ServiceErrorState extends ServicesState {}

class ServiceSuccessState extends ServicesState {}

class ServiceLoadingState extends ServicesState {}

class LoadingState extends ServicesState {}

class ErrorState extends ServicesState {}

class SuccessState extends ServicesState {}

class ChangePrivacyState extends ServicesState {}

class SuccessRemoveCartState extends ServicesState {}

class SuccessAddCartState extends ServicesState {}

class SuccessReviewState extends ServicesState {}

class ErrorReviewState extends ServicesState {}

class ReviewLoadingState extends ServicesState {}

class SuccessCodeState extends ServicesState {}

class ErrorCodeState extends ServicesState {}

class SwitchDelivery extends ServicesState {}

class DeletePromoCOde extends ServicesState {}

class LoadingServicesBooking extends ServicesState {}

class SuccessServicesBooking extends ServicesState {}

class ErrorServicesBooking extends ServicesState {}

class ChangeSubService extends ServicesState {}

class ChangeProfile extends ServicesState {}

class ChooseLocation extends ServicesState {}
