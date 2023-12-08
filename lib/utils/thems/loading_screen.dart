import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../commons/common_imports/common_libs.dart';

class LoadingScreen extends StatelessWidget {
  final Color? color;
  final double? size;
  const LoadingScreen({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color:color?? Theme.of(context).colorScheme.onPrimary,
          size: size??20.0.h,
        ),
      ),
    );
  }
}