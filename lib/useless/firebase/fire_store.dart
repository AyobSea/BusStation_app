class profile {
  
  String? uid;
  String? username;
  String? firstname;
  String? lastname;
  String? street;
  

  profile(
      {this.uid,
      this.username,
      this.firstname,
      this.lastname,
      this.street,
      });

  factory profile.fromMap(map) {
    return profile(
      uid: map['uid'],
      username: map['username'],
      firstname: map['first name'],
      lastname: map['last name'],
      street: map['street'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'first name': firstname,
      'last name': lastname,
      'street': street,
    };
  }
}
