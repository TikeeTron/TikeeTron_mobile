class EventDetailEntity {
  final String? id;
  final int? eventId;
  final Organizer? organizer;
  final String? name;
  final String? description;
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final dynamic metadataUrl;
  final String? banner;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TicketTypeDetail>? ticketTypes;

  EventDetailEntity({
    this.id,
    this.eventId,
    this.organizer,
    this.name,
    this.description,
    this.category,
    this.startDate,
    this.endDate,
    this.location,
    this.metadataUrl,
    this.banner,
    this.createdAt,
    this.updatedAt,
    this.ticketTypes,
  });

  EventDetailEntity copyWith({
    String? id,
    int? eventId,
    Organizer? organizer,
    String? name,
    String? description,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    dynamic metadataUrl,
    String? banner,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TicketTypeDetail>? ticketTypes,
  }) =>
      EventDetailEntity(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        organizer: organizer ?? this.organizer,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        location: location ?? this.location,
        metadataUrl: metadataUrl ?? this.metadataUrl,
        banner: banner ?? this.banner,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ticketTypes: ticketTypes ?? this.ticketTypes,
      );

  factory EventDetailEntity.fromJson(Map<String, dynamic> json) => EventDetailEntity(
        id: json["_id"],
        eventId: json["eventId"],
        organizer: json["organizer"] == null ? null : Organizer.fromJson(json["organizer"]),
        name: json["name"],
        description: json["description"],
        category: json["category"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        location: json["location"],
        metadataUrl: json["metadataUrl"],
        banner: json["banner"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        ticketTypes: json["ticketTypes"] == null ? [] : List<TicketTypeDetail>.from(json["ticketTypes"]!.map((x) => TicketTypeDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventId": eventId,
        "organizer": organizer?.toJson(),
        "name": name,
        "description": description,
        "category": category,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "location": location,
        "metadataUrl": metadataUrl,
        "banner": banner,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "ticketTypes": ticketTypes == null ? [] : List<dynamic>.from(ticketTypes!.map((x) => x.toJson())),
      };
}

class Organizer {
  final String? id;
  final String? address;
  final String? name;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Organizer({
    this.id,
    this.address,
    this.name,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Organizer copyWith({
    String? id,
    String? address,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Organizer(
        id: id ?? this.id,
        address: address ?? this.address,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["_id"],
        address: json["address"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "name": name,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class TicketTypeDetail {
  final String? name;
  final String? description;
  final int? price;
  final int? capacity;
  final DateTime? startDate;
  final DateTime? endDate;

  TicketTypeDetail({
    this.name,
    this.description,
    this.price,
    this.capacity,
    this.startDate,
    this.endDate,
  });

  TicketTypeDetail copyWith({
    String? name,
    String? description,
    int? price,
    int? capacity,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      TicketTypeDetail(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        capacity: capacity ?? this.capacity,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory TicketTypeDetail.fromJson(Map<String, dynamic> json) => TicketTypeDetail(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        capacity: json["capacity"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "capacity": capacity,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}
