import 'package:cargocontrol/features/choferes/controller/add_choferes_state.dart';
import 'package:cargocontrol/features/choferes/services/choferes_repository.dart';
import 'package:cargocontrol/utils/form_validators/chofer.dart';
import 'package:cargocontrol/utils/form_validators/id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final choferesRepoProvider =
    Provider<ChoferesRepository>((_) => ChoferesRepository());

final choferesProvider =
    StateNotifierProvider<AddChoferresController, ChoferesState>(
        (ref) => AddChoferresController(ref.watch(choferesRepoProvider)));

class AddChoferresController extends StateNotifier<ChoferesState> {
  final ChoferesRepository _choferesRepository;
  AddChoferresController(this._choferesRepository)
      : super(const ChoferesState());

  void onIdChange(String value) {
    final id = Id.dirty(value);

    state = state.copyWith(
      id: id,
      isValid: Formz.validate(
        [
          id,
          state.nombreChofer,
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
          state.id,
          chofer,
        ],
      ),
    );
  }

  void addChofer() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _choferesRepository.addChofer(
        nombrechofer: state.nombreChofer.value,
        id: state.id.value,
      );
      state = state.copyWith(status: FormzSubmissionStatus.success);
      state = state.copyWith(
          status: FormzSubmissionStatus.initial,
          nombreChofer: Chofer.pure(),
          id: Id.pure());
    } on AddChoferFormFailure catch (e) {
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.code);
      state = state.copyWith(
          status: FormzSubmissionStatus.initial,
          nombreChofer: Chofer.pure(),
          id: Id.pure());
    }
  }
}
