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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom_ticket'] = this.nomTicket;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    // data['created_at'] = this.createdAt;
    return data;
  }
}
