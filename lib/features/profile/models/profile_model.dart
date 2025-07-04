class ProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? country;
  final String? gender;
  final String? birthDate;
  final String? type;
  final String? title;
  final String? profileImage;
  final String? bio;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.gender,
    this.birthDate,
    this.type,
    this.title,
    this.profileImage,
    this.bio,
  });

  factory ProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ProfileModel();
    
    return ProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birth_date'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      profileImage: json['profile_image'] as String?,
      bio: json['bio'] as String?,
    );
  }
}
