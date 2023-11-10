import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/numero_guia.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CamionEntrandoState extends Equatable {
  final NumeroGuia numeroGuia;
  final Placa placa;
  final Chofer nombreChofer;
  final Peso pesoTara;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const CamionEntrandoState({
    this.numeroGuia = const NumeroGuia.pure(),
    this.placa = const Placa.pure(),
    this.nombreChofer = const Chofer.pure(),
    this.pesoTara = const Peso.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  CamionEntrandoState copyWith({
    NumeroGuia? numeroGuia,
    Placa? placa,
    Chofer? nombreChofer,
    Peso? pesoTara,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return CamionEntrandoState(
      numeroGuia: numeroGuia ?? this.numeroGuia,
      placa: placa ?? this.placa,
      nombreChofer: nombreChofer ?? this.nombreChofer,
      pesoTara: pesoTara ?? this.pesoTara,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        numeroGuia,
        placa,
        nombreChofer,
        pesoTara,
        status,
        isValid,
        errorMessage
      ];
}
