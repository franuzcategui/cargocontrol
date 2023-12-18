enum ViajesStatusEnum{
  portEntered('portEntered'),
  portLeft('portLeft'),
  industryLeft('industryLeft'),
  industryEntered('industryEntered');


  const ViajesStatusEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertViajesStatusEnum on String{
  ViajesStatusEnum toViajesStatusEnum(){
    switch(this){
      case 'portEntered':
        return ViajesStatusEnum.portEntered;
      case 'portLeft':
        return ViajesStatusEnum.portLeft;
      case 'industryLeft':
        return ViajesStatusEnum.industryLeft;
      case 'industryEntered':
        return ViajesStatusEnum.industryEntered;
      default:
        return ViajesStatusEnum.portEntered;
    }
  }
}