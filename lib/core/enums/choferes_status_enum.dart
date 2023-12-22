
enum ChoferesStatusEnum{
  portEntered('portEntered'),
  available('available'),
  portLeft('portLeft'),
  industryUnloaded('industryUnloaded'),
  industryEntered('industryEntered');


  const ChoferesStatusEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertChoferesStatusEnum on String{
  ChoferesStatusEnum toChoferesStatusEnum(){
    switch(this){
      case 'portEntered':
        return ChoferesStatusEnum.portEntered;
      case 'portLeft':
        return ChoferesStatusEnum.portLeft;
      case 'industryUnloaded':
        return ChoferesStatusEnum.industryUnloaded;
      case 'industryEntered':
        return ChoferesStatusEnum.industryEntered;
      case 'available':
        return ChoferesStatusEnum.available;
      default:
        return ChoferesStatusEnum.available;
    }
  }
}