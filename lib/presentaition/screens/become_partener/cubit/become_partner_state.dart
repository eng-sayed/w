part of 'become_partner_cubit.dart';

@immutable
abstract class BecomePartnerState {}

class BecomePartnerInitial extends BecomePartnerState {}

class LoadingCountries extends BecomePartnerState {}

class ErrorCountries extends BecomePartnerState {}

class SuccessCountries extends BecomePartnerState {}
