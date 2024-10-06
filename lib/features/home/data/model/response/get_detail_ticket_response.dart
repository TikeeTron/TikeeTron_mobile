class GetDetailTicketResponse {
  final String? id;
  final int? ticketId;
  final int? eventId;
  final String? buyerAddress;
  final String? type;
  final bool? isUsed;
  final int? price;
  final String? metadataUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final Event? event;
  final String? getDetailTicketResponseId;

  GetDetailTicketResponse({
    this.id,
    this.ticketId,
    this.eventId,
    this.buyerAddress,
    this.type,
    this.isUsed,
    this.price,
    this.metadataUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.event,
    this.getDetailTicketResponseId,
  });

  GetDetailTicketResponse copyWith({
    String? id,
    int? ticketId,
    int? eventId,
    String? buyerAddress,
    String? type,
    bool? isUsed,
    int? price,
    String? metadataUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    Event? event,
    String? getDetailTicketResponseId,
  }) =>
      GetDetailTicketResponse(
        id: id ?? this.id,
        ticketId: ticketId ?? this.ticketId,
        eventId: eventId ?? this.eventId,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        type: type ?? this.type,
        isUsed: isUsed ?? this.isUsed,
        price: price ?? this.price,
        metadataUrl: metadataUrl ?? this.metadataUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        event: event ?? this.event,
        getDetailTicketResponseId: getDetailTicketResponseId ?? this.getDetailTicketResponseId,
      );

  factory GetDetailTicketResponse.fromJson(Map<String, dynamic> json) => GetDetailTicketResponse(
        id: json["_id"],
        ticketId: json["ticketId"],
        eventId: json["eventId"],
        buyerAddress: json["buyerAddress"],
        type: json["type"],
        isUsed: json["isUsed"],
        price: json["price"],
        metadataUrl: json["metadataUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        getDetailTicketResponseId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ticketId": ticketId,
        "eventId": eventId,
        "buyerAddress": buyerAddress,
        "type": type,
        "isUsed": isUsed,
        "price": price,
        "metadataUrl": metadataUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "event": event?.toJson(),
        "id": getDetailTicketResponseId,
      };
}

class Event {
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
  final List<TicketType>? ticketTypes;

  Event({
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

  Event copyWith({
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
    List<TicketType>? ticketTypes,
  }) =>
      Event(
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

  factory Event.fromJson(Map<String, dynamic> json) => Event(
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
        ticketTypes: json["ticketTypes"] == null ? [] : List<TicketType>.from(json["ticketTypes"]!.map((x) => TicketType.fromJson(x))),
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

class TicketType {
  final String? name;
  final String? description;
  final int? price;
  final int? capacity;
  final DateTime? startDate;
  final DateTime? endDate;

  TicketType({
    this.name,
    this.description,
    this.price,
    this.capacity,
    this.startDate,
    this.endDate,
  });

  TicketType copyWith({
    String? name,
    String? description,
    int? price,
    int? capacity,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      TicketType(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        capacity: capacity ?? this.capacity,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory TicketType.fromJson(Map<String, dynamic> json) => TicketType(
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
