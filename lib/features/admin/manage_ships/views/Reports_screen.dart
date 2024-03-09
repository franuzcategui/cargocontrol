import 'dart:io';

import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/custom_button.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/loading.dart';
import '../controllers/pdf_state.dart';
import '../controllers/select_color_notifier.dart';
import '../data/apis/pdf_api.dart';
import '../widgets/color_container.dart';
import '../widgets/download_option_button.dart';
import '../widgets/empty_container.dart';
import '../widgets/pdf_container.dart';
import '../widgets/pdg_format_four.dart';

class ReportScreen extends ConsumerStatefulWidget {
  final VesselModel vesselModel;
  final List<IndustrySubModel> allIndustriesModels;
  final List<ViajesModel> allViajesModel;
  const ReportScreen(
      {required this.allIndustriesModels,
      required this.allViajesModel,
      super.key,
      required this.vesselModel});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  late final invoice;
  bool loading = false;
  int selectedFile = 0;
  List<int> listColor = AppConstants.lisOfColor;

  late final SelectedColorNotifier selectedColorNotifier;

  @override
  void initState() {
    invoice = widget.vesselModel;
    selectedColorNotifier = ref.read(selectedColorProvider);
    onClicked();
    super.initState();
  }

  onClicked() async {
    final generatedFile = await ReportPDFFormat.generate(
      color: PdfColor.fromInt(listColor[0]),
      vesselModel: invoice,
      allIndustriesModels: widget.allIndustriesModels,
      allViajesModel: widget.allViajesModel,
    );
    ref.watch(pdfProvider.notifier).updatePdf(0, generatedFile);
  }

  @override
  Widget build(BuildContext context) {
    final pdfPro = ref.watch(pdfProvider);
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        title: Text('Informe del barco',
            style: getSemiBoldStyle(
                color: context.mainColor, fontSize: MyFonts.size20)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        pdfPro.generatedFile != null
                            ? PdfContainer(file: pdfPro.generatedFile!)
                            : EmptyContainer(
                                color: AppConstants.lisOfColor[
                                    selectedColorNotifier.selectedColorIndex]),
                        if (loading)
                          Center(
                              child: LoadingWidget(
                            size: 50.r,
                            color: context.mainColor,
                          ))
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 110.h,
                  //   width: double.infinity,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: listColor.length,
                  //     itemBuilder: (context, index) {
                  //       return ColorContainer(
                  //         color: Color(listColor[index]),
                  //         isSelected:
                  //         selectedColorNotifier.selectedColorIndex == index,
                  //         onTap: () async {
                  //           setState(() {
                  //             loading = true;
                  //           });
                  //           final selectedFileIndex = selectedFile;
                  //           final generatedFile = await
                  //           PdfFormatFour.generate(
                  //             color: PdfColor.fromInt(listColor[index]), vesselModel: invoice,
                  //           );
                  //           setState(() {
                  //             loading = false;
                  //             selectedColorNotifier.selectedColorIndex = index;
                  //           });
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              onPressed: () async {
                List<List<dynamic>> csvData = generateCsvData(widget.allViajesModel);
                //
                // // Write to CSV file
                // String csvContent = const ListToCsvConverter().convert(csvData);
                // File csvFile = File('viajes_table.csv');
                // csvFile.writeAsStringSync(csvContent);


                // Get the application's temporary directory
                Directory tempDir = await getTemporaryDirectory();
                String tempPath = tempDir.path;

                // Write to CSV file in the temporary directory
                File csvFile = File('$tempPath/viajes_table.csv');
                csvFile.writeAsStringSync(const ListToCsvConverter().convert(csvData));


                await Share.shareXFiles(
                  [XFile(ref.watch(pdfProvider).generatedFile!.path),XFile(csvFile.path)],
                  text: 'Vessel Report',
                );
              },
              buttonText: 'Share',
            ),
          )
        ],
      ),
    );
  }
}
