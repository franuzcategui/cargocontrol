import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_dropdown.dart';
import '../controllers/ad_vessel_noti_controller.dart';

class BodegaSectionWidget extends ConsumerStatefulWidget {
  final int index;
  final TextEditingController productCtr;
  final TextEditingController varietyCtr;
  final TextEditingController tipoCtr;
  final TextEditingController originCtr;
  final TextEditingController cosechaCtr;
  final Widget weightWidget;
  final GlobalKey formKey;
  final VoidCallback onRemove;
  const BodegaSectionWidget({Key? key, required this.index, required this.productCtr, required this.varietyCtr, required this.tipoCtr, required this.originCtr, required this.cosechaCtr, required this.weightWidget, required this.formKey, required this.onRemove, }) : super(key: key);

  @override
  ConsumerState<BodegaSectionWidget> createState() => _BodegaSectionWidgetState();
}

class _BodegaSectionWidgetState extends ConsumerState<BodegaSectionWidget> {

  List<String> products = [

  ];

  List<String> varieties = [

  ];

  List<String> tipoList = [

  ];

  List<String> originList = [

  ];

  List<String> cosechaList = [

  ];

  List<ProductModel> allProducts = [

  ];

  ProductModel? selectedProduct;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  initialization()async{
    ref.read(adVesselNotiController).allProducts.forEach((product) {
      products.add(product.productsName);
      allProducts.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bodega #${widget.index+1}', style: getBoldStyle(color: context.textColor, fontSize: MyFonts.size14),),
                GestureDetector(
                    onTap: widget.onRemove,
                    child: Icon(Icons.cancel_outlined, size: 18.sp, color: context.errorColor,))
              ],
            ),
            SizedBox(height: 8.h,),
            CustomDropDown(
              ctr: widget.productCtr,
              list: products,
              labelText: 'Producto',
              onChange: (String val){
                allProducts.forEach((product) {
                  if(val == product.productsName){
                    selectedProduct = product;
                    setState(() {
                    });
                  }
                });
              },
            ),
            SizedBox(height: 10.h,),
            selectedProduct!= null ?
            Column(
              children: [
                CustomDropDown(ctr: widget.varietyCtr, list: selectedProduct!.varietyNames as List<String>, labelText: 'Variedad',),
                SizedBox(height: 10.h,),
                CustomDropDown(ctr: widget.tipoCtr, list: selectedProduct!.tipoNames as List<String>, labelText: 'Tipo',),
                SizedBox(height: 10.h,),
                CustomDropDown(ctr: widget.cosechaCtr, list: selectedProduct!.cosechaNames as List<String>, labelText: 'Cosecha',),
                SizedBox(height: 10.h,),
              ],
            ): SizedBox(),
            CustomDropDown(ctr: widget.originCtr, list: originList, labelText: 'Origen',),
            SizedBox(height: 10.h,),
            widget.weightWidget
          ],
        );
      },

    );
  }
}
