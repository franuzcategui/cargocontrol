import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  final Widget? loadingType;
  const LoadingWidget({Key? key, this.color, this.size, this.loadingType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loadingType?? SpinKitThreeBounce(
        color:color?? Theme.of(context).colorScheme.onPrimary,
        size: size??20.0.h,
      ),
    );
  }
}
