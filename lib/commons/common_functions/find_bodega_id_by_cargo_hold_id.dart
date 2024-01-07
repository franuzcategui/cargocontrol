import '../../models/vessel_models/vessel_cargo_model.dart';

int findCargoIndexById(List<VesselCargoModel> cargoList, String cargoId) {
  for (int i = 0; i < cargoList.length; i++) {
    if (cargoList[i].cargoId == cargoId) {
      // Adding 1 to match your requirement (index + 1)
      return i + 1;
    }
  }
  // Return -1 if the cargoId is not found in the list
  return -1;
}