import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/choice_chip.dart';
import 'package:cargocontrol/utils/form_validators/numero_guia.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CamionDestinoState extends Equatable {
  final Placa placa;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const CamionDestinoState({
    this.placa = const Placa.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  CamionDestinoState copyWith({
    Placa? placa,
    FormzSubmissionStatus? status,
    ChoiceChip? bodega,
    bool? isValid,
    String? errorMessage,
  }) {
    return CamionDestinoState(
      placa: placa ?? this.placa,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [placa, status, isValid, errorMessage];
}
