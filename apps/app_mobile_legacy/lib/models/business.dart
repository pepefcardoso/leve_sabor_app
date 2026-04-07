import 'package:my_app/models/address.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/models/contact.dart';
import 'package:my_app/models/cooking_style.dart';
import 'package:my_app/models/diet.dart';
import 'package:my_app/models/image.dart';
import 'package:my_app/models/opening_hours.dart';
import 'package:my_app/models/ratings_info.dart';

class Business {
  final int? id;
  final String? name;
  final String? description;
  final Category? category;
  final List<Diet>? diets;
  final Address? address;
  final Contact? contact;
  final List<OpeningHours>? openingHours;
  final List<CookingStyle>? cookingStyles;
  final List<Image>? images;
  final bool? favorite;
  final bool? openNow;
  final String? logoUrl;
  final RatingsInfo? ratingsInfo;
  final int? userId;

  const Business({
    this.id,
    this.name,
    this.description,
    this.category,
    this.diets,
    this.address,
    this.contact,
    this.openingHours,
    this.cookingStyles,
    this.images,
    this.favorite,
    this.openNow,
    this.logoUrl,
    this.ratingsInfo,
    this.userId,
  });

  Business.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        category = json['category'] != null ? Category.fromJson(json['category']) : null,
        diets = json['diets'] != null ? (json['diets'] as List).map((e) => Diet.fromJson(e)).toList() : null,
        address = json['address'] != null ? Address.fromJson(json['address']) : null,
        contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null,
        openingHours = json['opening_hours'] != null ? (json['opening_hours'] as List).map((e) => OpeningHours.fromJson(e)).toList() : null,
        cookingStyles = json['cooking_styles'] != null ? (json['cooking_styles'] as List).map((e) => CookingStyle.fromJson(e)).toList() : null,
        images = json['images'] != null ? (json['images'] as List).map((e) => Image.fromJson(e)).toList() : null,
        favorite = json['favorite'],
        openNow = json['open_now'],
        logoUrl = json['logo_url'],
        ratingsInfo = json['ratings_info'] != null ? RatingsInfo.fromJson(json['ratings_info']) : null,
        userId = json['user_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category?.toJson(),
        'diets': diets?.map((e) => e.toJson()).toList(),
        'address': address?.toJson(),
        'contact': contact?.toJson(),
        'opening_hours': openingHours?.map((e) => e.toJson()).toList(),
        'cooking_styles': cookingStyles?.map((e) => e.toJson()).toList(),
        'images': images?.map((e) => e.toJson()).toList(),
        'favorite': favorite,
        'open_now': openNow,
        'logo_url': logoUrl,
        'ratings_info': ratingsInfo?.toJson(),
        'user_id': userId,
      };
}
