class SyncTicketRequest {
  final int? ticketId;
  final int? eventId;
  final String? buyerAddress;
  final String? type;
  final int? price;
  final String? metadataUrl;

  SyncTicketRequest({
    this.ticketId,
    this.eventId,
    this.buyerAddress,
    this.type,
    this.price,
    this.metadataUrl,
  });

  SyncTicketRequest copyWith({
    int? ticketId,
    int? eventId,
    String? buyerAddress,
    String? type,
    int? price,
    String? metadataUrl,
  }) =>
      SyncTicketRequest(
        ticketId: ticketId ?? this.ticketId,
        eventId: eventId ?? this.eventId,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        type: type ?? this.type,
        price: price ?? this.price,
        metadataUrl: metadataUrl ?? this.metadataUrl,
      );

  factory SyncTicketRequest.fromJson(Map<String, dynamic> json) => SyncTicketRequest(
        ticketId: json["ticketId"],
        eventId: json["eventId"],
        buyerAddress: json["buyerAddress"],
        type: json["type"],
        price: json["price"],
        metadataUrl: json["metadataUrl"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "eventId": eventId,
        "buyerAddress": buyerAddress,
        "type": type,
        "price": price,
        "metadataUrl": metadataUrl,
      };
}
