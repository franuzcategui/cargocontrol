import 'package:cargocontrol/common_widgets/cargo_card.dart';
import 'package:cargocontrol/common_widgets/loading_sheet.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/features/choferes/controller/choferes_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/assets_manager.dart';

@override
class AdChoferesList extends ConsumerStatefulWidget {
  const AdChoferesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdChoferesListState();
}

class _AdChoferesListState extends ConsumerState<AdChoferesList> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: context.errorColor,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.deleteArrowIcon,
                      color: Colors.white.withOpacity(0.5),
                      width: 25.w,
                      height: 25.h,
                    ),
                    Image.asset(
                      AppAssets.deleteIcon,
                      color: Colors.white,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ],
                ),
              ),
              child: const CargoCard(
                  topLeftText: "ID 123456",
                  topRightText: "Viajes 0",
                  titleText: "Intento- 0.0",
                  bottomLeftText: "Deficit 0.0",
                  bottomRightText:
                  "Retraso Promedio : 0.0"),

            );

          }),
    );
  }
}
