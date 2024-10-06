class GetListEventResponse {
  final bool? status;
  final int? statusCode;
  final List<Datum>? data;
  final Meta? meta;

  GetListEventResponse({
    this.status,
    this.statusCode,
    this.data,
    this.meta,
  });

  GetListEventResponse copyWith({
    bool? status,
    int? statusCode,
    List<Datum>? data,
    Meta? meta,
  }) =>
      GetListEventResponse(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory GetListEventResponse.fromJson(Map<String, dynamic> json) => GetListEventResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  final String? id;
  final int? eventId;
  final String? name;
  final String? description;
  final String? location;
  final int? capacity;
  final String? category;
  final DateTime? date;
  final String? banner;
  final List<TicketType>? ticketTypes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Datum({
    this.id,
    this.eventId,
    this.name,
    this.description,
    this.location,
    this.capacity,
    this.category,
    this.date,
    this.banner,
    this.ticketTypes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Datum copyWith({
    String? id,
    int? eventId,
    String? name,
    String? description,
    String? location,
    int? capacity,
    String? category,
    DateTime? date,
    String? banner,
    List<TicketType>? ticketTypes,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Datum(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        capacity: capacity ?? this.capacity,
        category: category ?? this.category,
        date: date ?? this.date,
        banner: banner ?? this.banner,
        ticketTypes: ticketTypes ?? this.ticketTypes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        eventId: json["eventId"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        capacity: json["capacity"],
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        banner: json["banner"],
        ticketTypes: json["ticketTypes"] == null ? [] : List<TicketType>.from(json["ticketTypes"]!.map((x) => TicketType.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventId": eventId,
        "name": name,
        "description": description,
        "location": location,
        "capacity": capacity,
        "category": category,
        "date": date?.toIso8601String(),
        "banner": banner,
        "ticketTypes": ticketTypes == null ? [] : List<dynamic>.from(ticketTypes!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class TicketType {
  final String? type;
  final int? price;
  final int? columnSize;
  final int? rowSize;
  final String? metadataUrl;

  TicketType({
    this.type,
    this.price,
    this.columnSize,
    this.rowSize,
    this.metadataUrl,
  });

  TicketType copyWith({
    String? type,
    int? price,
    int? columnSize,
    int? rowSize,
    String? metadataUrl,
  }) =>
      TicketType(
        type: type ?? this.type,
        price: price ?? this.price,
        columnSize: columnSize ?? this.columnSize,
        rowSize: rowSize ?? this.rowSize,
        metadataUrl: metadataUrl ?? this.metadataUrl,
      );

  factory TicketType.fromJson(Map<String, dynamic> json) => TicketType(
        type: json["type"],
        price: json["price"],
        columnSize: json["columnSize"],
        rowSize: json["rowSize"],
        metadataUrl: json["metadataUrl"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "columnSize": columnSize,
        "rowSize": rowSize,
        "metadataUrl": metadataUrl,
      };
}

class Meta {
  final int? page;
  final int? take;
  final int? itemCount;
  final int? pageCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  Meta({
    this.page,
    this.take,
    this.itemCount,
    this.pageCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  Meta copyWith({
    int? page,
    int? take,
    int? itemCount,
    int? pageCount,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) =>
      Meta(
        page: page ?? this.page,
        take: take ?? this.take,
        itemCount: itemCount ?? this.itemCount,
        pageCount: pageCount ?? this.pageCount,
        hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
        hasNextPage: hasNextPage ?? this.hasNextPage,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        take: json["take"],
        itemCount: json["itemCount"],
        pageCount: json["pageCount"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "take": take,
        "itemCount": itemCount,
        "pageCount": pageCount,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
      };
}
