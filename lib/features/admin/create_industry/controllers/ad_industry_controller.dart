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
import '../data/apis/ad_industry_apis.dart';

final adIndustryProvider = StateNotifierProvider<AdIndustryController, bool>((ref) {
  final adIndustryApi = ref.watch(adIndustryApiProvider);
  return AdIndustryController(datasource:  adIndustryApi, );
});

// final fetchAllIndustrysProvider = StreamProvider((ref) {
//   final categoryPrdr = ref.watch(adIndustryProvider.notifier);
//   return categoryPrdr.getIndustrysList();
// });


class AdIndustryController extends StateNotifier<bool> {
  final AdIndustryApisImplements _datasource;

  AdIndustryController({required AdIndustryApisImplements datasource,})
      : _datasource = datasource,
        super(false);
  //
  // Future<void> createIndustry({
  //   required String vesselName,
  //   required String procedencia,
  //   required String shipper,
  //   required String unCode,
  //   required DateTime portDate,
  //   required int numberOfWines,
  //   required WeightUnitEnum weightUnitEnum,
  //   required List<IndustryCargoModel> bogedaModels,
  //   required double totalCargoWeight,
  //   required WidgetRef ref,
  //   required BuildContext context,
  // }) async {
  //   state = true;
  //   DateTime createdAt = DateTime.now();
  //   final String vesselId = const Uuid().v4();
  //   IndustryModel vesselModel = IndustryModel(
  //       vesselId: vesselId,
  //       vesselName: vesselName,
  //       exitPort: procedencia,
  //       entryPort: '',
  //       shipper: shipper,
  //       unlcode: unCode,
  //       totalCargoWeight: totalCargoWeight,
  //       numberOfCargos: bogedaModels.length,
  //       cargoModels: bogedaModels,
  //       cargoUnloadedWeight: 0.0,
  //       entryDate: DateTime.now(),
  //       exitDate: portDate,
  //       searchTags: vesselSearchTags(unlcode: unCode, shipperName: shipper ,name: vesselName)
  //   );
  //   final result = await _datasource.createIndustry(vesselModel: vesselModel);
  //
  //   result.fold((l) {
  //     state = false;
  //     showSnackBar(context: context, content: l.message);
  //   }, (r) {
  //     state = false;
  //     Navigator.pushNamed(context, AppRoutes.registrationSuccessFullScreen);
  //     showSnackBar(context: context, content: 'Industry Created!');
  //   });
  //   state = false;
  // }
  //
  //
  // Stream<List<IndustryModel>> getIndustrysList() {
  //   return _datasource.getIndustrysList();
  // }
  //
  //
  // Future productsUpload()async{
  //   ProductModel productModel = ProductModel(
  //     productsName: 'Arroz en cáscara',
  //     cosechaNames: cosechas,
  //     productId: const Uuid().v4(),
  //     tipoNames: tipos,
  //     varietyNames: varieties
  //   );
  //
  //   await _datasource.uploadProduct(productModel:  productModel);
  // }
  //
  //
  // Future originsUpload()async{
  //   OriginModel originModel = OriginModel(originNames: origins);
  //   await _datasource.uploadOrigins(originModel:  originModel);
  // }
  //
  //
  // Future uploadAllData()async{
  //   await Future.wait([
  //     productsUpload(),
  //     originsUpload(),
  //   ]);
  // }
  //
  //
  // // All Data
  // List<String> products = [
  //   'Arroz en cáscara'
  // ];
  //
  // List<String> tipos = [
  //   'Grano largo'
  // ];
  //
  // List<String> origins = [
  //   'Estados Unidos',
  //   'Argentina',
  //   'Brasil',
  //   'Uruguay',
  //   'Paraguay',
  //   'Tailandia',
  // ];
  //
  // List<String> varieties = [
  //   'Olimar',
  //   'Irga 424',
  //   'Merin',
  //   'Gurí',
  //   'Híbrido',
  //   'Combinación',
  //   'Convencional',
  //   'IP',
  // ];
  //
  // List<String> cosechas = [
  //   'Vieja',
  //   'Nueva',
  //   'Mezcla',
  // ];

}
