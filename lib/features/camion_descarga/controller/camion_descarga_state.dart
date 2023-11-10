import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/choice_chip.dart';
import 'package:cargocontrol/utils/form_validators/numero_guia.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CamionDescargaState extends Equatable {
  final Placa placa;
  final Peso pesoBruto;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const CamionDescargaState({
    this.placa = const Placa.pure(),
    this.pesoBruto = const Peso.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  CamionDescargaState copyWith({
    Placa? placa,
    Peso? pesoBruto,
    FormzSubmissionStatus? status,
    ChoiceChip? bodega,
    bool? isValid,
    String? errorMessage,
  }) {
    return CamionDescargaState(
      placa: placa ?? this.placa,
      pesoBruto: pesoBruto ?? this.pesoBruto,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [placa, pesoBruto, status, isValid, errorMessage];
}
