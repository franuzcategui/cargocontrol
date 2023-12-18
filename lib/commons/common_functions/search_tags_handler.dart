
Map<String, dynamic> userSearchTagsHandler({
  required String name,
  required String email,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if(name != ''){
    name.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if(email != ""){
    email.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }


  return searchTags;
}


Map<String, dynamic> vesselSearchTags({
  required String name,
  required String shipperName,
  required String unlcode,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if(name != ''){
    name.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if(shipperName != ""){
    shipperName.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if(unlcode != ""){
    unlcode.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }


  return searchTags;
}



Map<String, dynamic> choferesSearchTagsHandler({
  required String name,
  required String choferNationalId,

}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if(name != ''){
    name.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if(choferNationalId != ""){
    choferNationalId.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }


  return searchTags;
}





