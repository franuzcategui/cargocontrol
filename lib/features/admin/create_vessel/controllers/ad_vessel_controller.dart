import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/features/admin/create_vessel/data/apis/ad_vessel_apis.dart';
import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../core/enums/weight_unit_enum.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';

final adVesselProvider = StateNotifierProvider<AdVesselController, bool>((ref) {
  final adVesselApi = ref.watch(adVesselApiProvider);
  return AdVesselController(datasource:  adVesselApi, );
});

final fetchCurrentVesselsProvider = StreamProvider((ref) {
  final categoryPrdr = ref.watch(adVesselProvider.notifier);
  return categoryPrdr.getCurrentVesselStream();
});


class AdVesselController extends StateNotifier<bool> {
  final AdVesselApisImplements _datasource;

  AdVesselController({required AdVesselApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> createVessel({
    required String vesselName,
    required String procedencia,
    required String shipper,
    required String unCode,
    required DateTime portDate,
    required int numberOfWines,
    required WeightUnitEnum weightUnitEnum,
    required List<VesselCargoModel> bogedaModels,
    required double totalCargoWeight,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final String vesselId = const Uuid().v4();
    VesselModel vesselModel = VesselModel(
        vesselId: vesselId,
        isFinishedUnloading: false,
        vesselName: vesselName,
        exitPort: '',
        entryPort: procedencia,
        shipper: shipper,
        unlcode: unCode,
        totalCargoWeight: totalCargoWeight,
        numberOfCargos: bogedaModels.length,
        cargoModels: bogedaModels,
        cargoUnloadedWeight: 0.0,
        entryDate: portDate,
        exitDate: DateTime.now(),
        searchTags: vesselSearchTags(unlcode: unCode, shipperName: shipper ,name: vesselName)
    );
    final result = await _datasource.createVessel(vesselModel: vesselModel);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
    }, (r) {
      state = false;
      Navigator.pushNamed(context, AppRoutes.registrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Vessel Created!');
    });
    state = false;
  }


  Stream<VesselModel> getCurrentVesselStream() {
    return _datasource.getCurrentVesselStream();
  }




  Future productsUpload()async{
    ProductModel productModel = ProductModel(
      productsName: 'Arroz en cáscara',
      cosechaNames: cosechas,
      productId: const Uuid().v4(),
      tipoNames: tipos,
      varietyNames: varieties
    );

    await _datasource.uploadProduct(productModel:  productModel);
  }


  Future originsUpload()async{
    OriginModel originModel = OriginModel(originNames: origins);
    await _datasource.uploadOrigins(originModel:  originModel);
  }


  Future uploadAllData()async{
    await Future.wait([
      productsUpload(),
      originsUpload(),
    ]);
  }


  // All Data
  List<String> products = [
    'Arroz en cáscara'
  ];

  List<String> tipos = [
    'Grano largo'
  ];

  List<String> origins = [
    'Estados Unidos',
    'Argentina',
    'Brasil',
    'Uruguay',
    'Paraguay',
    'Tailandia',
  ];

  List<String> varieties = [
    'Olimar',
    'Irga 424',
    'Merin',
    'Gurí',
    'Híbrido',
    'Combinación',
    'Convencional',
    'IP',
  ];

  List<String> cosechas = [
    'Vieja',
    'Nueva',
    'Mezcla',
  ];

}
