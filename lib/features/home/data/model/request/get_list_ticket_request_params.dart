class GetListTicketRequestParams {
  final int? order;
  final int? page;
  final String? buyerAddress;
  final String? type;
  final int? take;
  final int? eventId;
  final String? periodBegin;
  final String? periodEnd;

  GetListTicketRequestParams({
    this.order,
    this.page,
    this.buyerAddress,
    this.type,
    this.take,
    this.eventId,
    this.periodBegin,
    this.periodEnd,
  });

  GetListTicketRequestParams copyWith({
    int? order,
    int? page,
    String? buyerAddress,
    String? type,
    int? take,
    int? eventId,
    String? periodBegin,
    String? periodEnd,
  }) =>
      GetListTicketRequestParams(
        order: order ?? this.order,
        page: page ?? this.page,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        type: type ?? this.type,
        take: take ?? this.take,
        eventId: eventId ?? this.eventId,
        periodBegin: periodBegin ?? this.periodBegin,
        periodEnd: periodEnd ?? this.periodEnd,
      );

  factory GetListTicketRequestParams.fromJson(Map<String, dynamic> json) => GetListTicketRequestParams(
        order: json["order"],
        page: json["page"],
        buyerAddress: json["buyerAddress"],
        type: json["type"],
        take: json["take"],
        eventId: json["eventId"],
        periodBegin: json["periodBegin"],
        periodEnd: json["periodEnd"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "page": page,
        "buyerAddress": buyerAddress,
        "type": type,
        "take": take,
        "eventId": eventId,
        "periodBegin": periodBegin,
        "periodEnd": periodEnd,
      };
}
