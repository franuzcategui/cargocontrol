enum ViajesTypeEnum{
  all('all'),
  inProgress('inProgress'),
  completed('completed');


  const ViajesTypeEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  ViajesTypeEnum toViajesTypeEnum(){
    switch(this){
      case 'all':
        return ViajesTypeEnum.all;
      case 'inProgress':
        return ViajesTypeEnum.inProgress;
      case 'completed':
        return ViajesTypeEnum.completed;
      default:
        return ViajesTypeEnum.completed;
    }
  }
}