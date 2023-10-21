// To parse this JSON data, do
//
//     final savTicket = savTicketFromJson(jsonString);

import 'dart:convert';

SavTicket savTicketFromJson(String str) => SavTicket.fromJson(json.decode(str));

String savTicketToJson(SavTicket data) => json.encode(data.toJson());

class SavTicket {
    int? id;
    int? clientId;
    String? idCase;
    String? type;
    int? technicienId;
    int? soustraitantId;
    String? description;
    String? debit;
    String? status;
    String? serviceActivity;
    int? affectedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? planificationDate;
    Client? client;

    SavTicket({
        this.id,
        this.clientId,
        this.idCase,
        this.type,
        this.technicienId,
        this.soustraitantId,
        this.description,
        this.debit,
        this.status,
        this.serviceActivity,
        this.affectedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.planificationDate,
        this.client,
    });

    factory SavTicket.fromJson(Map<String, dynamic> json) => SavTicket(
        id: json["id"],
        clientId: json["client_id"],
        idCase: json["id_case"],
        type: json["type"],
        technicienId: json["technicien_id"],
        soustraitantId: json["soustraitant_id"],
        description: json["description"],
        debit: json["debit"],
        status: json["status"],
        serviceActivity: json["service_activity"],
        affectedBy: json["affected_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        planificationDate: json["planification_date"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "id_case": idCase,
        "type": type,
        "technicien_id": technicienId,
        "soustraitant_id": soustraitantId,
        "description": description,
        "debit": debit,
        "status": status,
        "service_activity": serviceActivity,
        "affected_by": affectedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "planification_date": planificationDate,
        "client": client?.toJson(),
    };
}

class Client {
    int? id;
    String? uuid;
    String? type;
    String? name;
    String? clientId;
    String? address;
    String? lat;
    String? lng;
    int? cityId;
    int? plaqueId;
    String? phoneNo;
    String? debit;
    String? sip;
    dynamic technicienId;
    String? status;
    String? statusSav;
    int? createdBy;
    dynamic cause;
    int? promoteur;
    dynamic phaseOne;
    dynamic phaseTwo;
    dynamic phaseThree;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? flagged;
    dynamic controlerClientId;

    Client({
        this.id,
        this.uuid,
        this.type,
        this.name,
        this.clientId,
        this.address,
        this.lat,
        this.lng,
        this.cityId,
        this.plaqueId,
        this.phoneNo,
        this.debit,
        this.sip,
        this.technicienId,
        this.status,
        this.statusSav,
        this.createdBy,
        this.cause,
        this.promoteur,
        this.phaseOne,
        this.phaseTwo,
        this.phaseThree,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.flagged,
        this.controlerClientId,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        uuid: json["uuid"],
        type: json["type"],
        name: json["name"],
        clientId: json["client_id"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        cityId: json["city_id"],
        plaqueId: json["plaque_id"],
        phoneNo: json["phone_no"],
        debit: json["debit"],
        sip: json["sip"],
        technicienId: json["technicien_id"],
        status: json["status"],
        statusSav: json["statusSav"],
        createdBy: json["created_by"],
        cause: json["cause"],
        promoteur: json["promoteur"],
        phaseOne: json["phase_one"],
        phaseTwo: json["phase_two"],
        phaseThree: json["phase_three"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        flagged: json["flagged"],
        controlerClientId: json["controler_client_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "type": type,
        "name": name,
        "client_id": clientId,
        "address": address,
        "lat": lat,
        "lng": lng,
        "city_id": cityId,
        "plaque_id": plaqueId,
        "phone_no": phoneNo,
        "debit": debit,
        "sip": sip,
        "technicien_id": technicienId,
        "status": status,
        "statusSav": statusSav,
        "created_by": createdBy,
        "cause": cause,
        "promoteur": promoteur,
        "phase_one": phaseOne,
        "phase_two": phaseTwo,
        "phase_three": phaseThree,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "flagged": flagged,
        "controler_client_id": controlerClientId,
    };
}
