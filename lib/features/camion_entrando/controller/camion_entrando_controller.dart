import 'package:cargocontrol/features/camion_entrando/services/camion_entrando_repository.dart';
import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/numero_guia.dart';
import 'package:cargocontrol/utils/form_validators/peso.dart';
import 'package:cargocontrol/utils/form_validators/placa.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cargocontrol/features/camion_entrando/controller/camion_entrando_state.dart';
import 'package:formz/formz.dart';

final camionEntrandoRepoProvider =
    Provider<CamionEntrandoRepository>((_) => CamionEntrandoRepository());

final camionEntrandoProvider =
    StateNotifierProvider<CamionEntrandoNotifier, CamionEntrandoState>(
        (ref) => CamionEntrandoNotifier(ref.watch(camionEntrandoRepoProvider)));

class CamionEntrandoNotifier extends StateNotifier<CamionEntrandoState> {
  final CamionEntrandoRepository _camionEntrandoRepository;
  CamionEntrandoNotifier(this._camionEntrandoRepository)
      : super(const CamionEntrandoState());

  void onPlacaChange(String value) {
    final placa = Placa.dirty(value);

    state = state.copyWith(
      placa: placa,
      isValid: Formz.validate(
        [
          placa,
          state.nombreChofer,
          state.numeroGuia,
          state.pesoTara,
        ],
      ),
    );
  }

  void onNumeroGuiaChange(String value) {
    final numeroGuia = NumeroGuia.dirty(value);

    state = state.copyWith(
      numeroGuia: numeroGuia,
      isValid: Formz.validate(
        [
          numeroGuia,
          state.nombreChofer,
          state.placa,
          state.pesoTara,
        ],
      ),
    );
  }

  void onChoferChange(String value) {
    final chofer = Chofer.dirty(value);

    state = state.copyWith(
      nombreChofer: chofer,
      isValid: Formz.validate(
        [
          state.placa,
          chofer,
          state.numeroGuia,
          state.pesoTara,
        ],
      ),
    );
  }

  void onPesoTaraChange(String value) {
    final pesoTara = Peso.dirty(value);

    state = state.copyWith(
      pesoTara: pesoTara,
      isValid: Formz.validate(
        [
          state.placa,
          state.nombreChofer,
          state.numeroGuia,
          pesoTara,
        ],
      ),
    );
  }

  void submitCamionEntrandoForm() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _camionEntrandoRepository.submitCamionEntrandoForm(
          numeroGuia: state.numeroGuia.value,
          placa: state.placa.value,
          nombrechofer: state.nombreChofer.value,
          pesoTara: state.pesoTara.toDouble()!);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on SubmitCamionEntrandoFormFailure catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
    }
  }
}
