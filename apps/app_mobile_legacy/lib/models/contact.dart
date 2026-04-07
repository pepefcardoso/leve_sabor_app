import 'package:my_app/models/phone.dart';

class Contact {
  final int? id;
  final String? email;
  final String? website;
  final String? facebook;
  final String? instagram;
  final String? ifood;
  final List<Phone>? phones;
  final int? businessId;

  const Contact({
    this.id,
    this.email,
    this.website,
    this.facebook,
    this.instagram,
    this.ifood,
    this.phones,
    this.businessId,
  });

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        website = json['website'],
        facebook = json['facebook'],
        instagram = json['instagram'],
        ifood = json['ifood'],
        phones = json['phones'] != null ? (json['phones'] as List).map((i) => Phone.fromJson(i)).toList() : null,
        businessId = json['business_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'website': website,
        'facebook': facebook,
        'instagram': instagram,
        'ifood': ifood,
        'phones': phones?.map((e) => e.toJson()).toList(),
        'business_id': businessId,
      };
}
