import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/id.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ChoferesState extends Equatable {
  final Chofer nombreChofer;
  final Id id;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const ChoferesState({
    this.nombreChofer = const Chofer.pure(),
    this.id = const Id.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  ChoferesState copyWith({
    Chofer? nombreChofer,
    Id? id,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ChoferesState(
      nombreChofer: nombreChofer ?? this.nombreChofer,
      id: id ?? this.id,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [nombreChofer, id, status, isValid, errorMessage];
}
