class Phone {
  final int? id;
  final String? number;
  final bool? whatsapp;
  final int? contactId;

  const Phone({
    this.id,
    this.number,
    this.whatsapp,
    this.contactId,
  });

  Phone.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'],
        whatsapp = json['whatsapp'],
        contactId = json['contact_id'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'whatsapp': whatsapp,
      'contact_id': contactId,
    };
  }
}
