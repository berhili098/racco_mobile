class TicketOrange {
  String? nomTicket;
  String? lat;
  String? lang;
  // String? createdAt;

  TicketOrange({this.nomTicket, this.lat, this.lang});

  TicketOrange.fromJson(Map<String, dynamic> json) {
    nomTicket = json['nom_ticket'];
    lat = json['lat'];
    lang = json['lang'];
    // createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom_ticket'] = nomTicket;
    data['lat'] = lat;
    data['lang'] = lang;
    // data['created_at'] = this.createdAt;
    return data;
  }
}
