import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/choice_chip.dart';
import 'package:cargocontrol/utils/form_validators/numero_guia.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CamionSaliendoSate extends Equatable {
  final Placa placa;
  final ChoiceChip bodega;
  final Peso pesoBruto;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const CamionSaliendoSate({
    this.placa = const Placa.pure(),
    this.pesoBruto = const Peso.pure(),
    this.bodega = const ChoiceChip.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  CamionSaliendoSate copyWith({
    NumeroGuia? numeroGuia,
    Placa? placa,
    Chofer? nombreChofer,
    Peso? pesoTara,
    FormzSubmissionStatus? status,
    ChoiceChip? bodega,
    bool? isValid,
    String? errorMessage,
  }) {
    return CamionSaliendoSate(
      placa: placa ?? this.placa,
      pesoBruto: pesoTara ?? this.pesoBruto,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      bodega: bodega ?? this.bodega,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [bodega, placa, pesoBruto, status, isValid, errorMessage];
}
