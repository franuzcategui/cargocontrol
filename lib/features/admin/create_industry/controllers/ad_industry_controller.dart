import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cargocontrol/models/industry_models/industry_guide_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/ad_industry_apis.dart';

final adIndustryProvider = StateNotifierProvider<AdIndustryController, bool>((ref) {
  final adIndustryApi = ref.watch(adIndustryApiProvider);
  return AdIndustryController(datasource:  adIndustryApi, );
});

final fetchCurrentVesselIndustries = StreamProvider.family((ref,String vesselId) {
  final industryProvider = ref.watch(adIndustryProvider.notifier);
  return industryProvider.getAllIndustrySubModels(vesselId: vesselId);
});

final fetchgetAllIndustryNamesStream = StreamProvider((ref) {
  final industryProvider = ref.watch(adIndustryProvider.notifier);
  return industryProvider.getAllIndustriesStream();
});


class AdIndustryController extends StateNotifier<bool> {
  final AdIndustryApisImplements _datasource;

  AdIndustryController({required AdIndustryApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> createIndustryGuideModel({
    required List<IndustrySubModel> industrySubModels,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.createIndustryGuideModel(industrySubModels: industrySubModels);
    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
    }, (r) {
      state = false;
      Navigator.pushNamed(context, AppRoutes.registrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Industry Created!');
    });

    state = false;
  }

  Future industriesUpload()async{
    industriesModels.forEach((industriesModel) async{
      await _datasource.uploadIndustries(industryModell:  industriesModel);
    });
  }

  Stream<List<IndustrySubModel>> getAllIndustrySubModels({required String vesselId}) {
    return _datasource.getAllIndustrySubModels(vesselId: vesselId);
  }

  Stream<List<IndustriesModel>> getAllIndustriesStream() {
    return _datasource.getAllIndustriesStream();
  }

  List<IndustriesModel> industriesModels = const[
    IndustriesModel(industryId: '3-004-061893', industryName: 'Cooperativa de Productores Independientes de Liberia'),
    IndustriesModel(industryId: '3-101-046884', industryName: 'Corporacion Arrocera Costa Rica S.A'),
    IndustriesModel(industryId: '3-101-017062', industryName: 'Derivados De Maiz Alimenticio S.A'),
    IndustriesModel(industryId: '3-101-002551', industryName: 'El Pelón De La Bajura S.A'),
  ];
}
