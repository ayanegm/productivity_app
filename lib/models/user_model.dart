class UserModel{

  final String name;
  final String email;
  final String bio;
  final String uid;
  UserModel({required this.uid, required this.name, required this.email, required this.bio});
  
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(name: map['name'], email: map['email'], bio: map['bio'], uid: map['uid']);

  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'bio':bio,
      'uid':uid
    };
  }
}