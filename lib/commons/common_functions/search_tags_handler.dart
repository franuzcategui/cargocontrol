
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



