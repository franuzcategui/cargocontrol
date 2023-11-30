enum AccountTypeEnum{
  admin('admin'),
  company('company'),
  coordinator('coordinator');


  const AccountTypeEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  AccountTypeEnum toAccountTypeEnum(){
    switch(this){
      case 'admin':
        return AccountTypeEnum.admin;
      case 'company':
        return AccountTypeEnum.company;
      case 'coordinator':
        return AccountTypeEnum.coordinator;
      default:
        return AccountTypeEnum.coordinator;
    }
  }
}