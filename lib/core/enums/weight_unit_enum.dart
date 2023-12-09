enum WeightUnitEnum{
  Kg('Kg'),
  Lb('Lb');


  const WeightUnitEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  WeightUnitEnum toWeightUnitEnum(){
    switch(this){
      case 'Kg':
        return WeightUnitEnum.Kg;
      case 'Lb':
        return WeightUnitEnum.Lb;
      default:
        return WeightUnitEnum.Lb;
    }
  }
}