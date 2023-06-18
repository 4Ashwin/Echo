// To parse this JSON data, do
//
//     final mail = mailFromJson(jsonString);

import 'dart:convert';

List<Mail> mailFromJson(String str) => List<Mail>.from(json.decode(str).map((x) => Mail.fromJson(x)));

String mailToJson(List<Mail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mail {
    String? subject;
    String? sender;
    String? receiver;
    String? date;
    String? snippet;
    Annotations? annotations;

    Mail({
        this.subject,
        this.sender,
        this.receiver,
        this.date,
        this.snippet,
        this.annotations,
    });

    Mail copyWith({
        String? subject,
        String? sender,
        String? receiver,
        String? date,
        String? snippet,
        Annotations? annotations,
    }) => 
        Mail(
            subject: subject ?? this.subject,
            sender: sender ?? this.sender,
            receiver: receiver ?? this.receiver,
            date: date ?? this.date,
            snippet: snippet ?? this.snippet,
            annotations: annotations ?? this.annotations,
        );

    factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        subject: json["subject"],
        sender: json["sender"],
        receiver: json["receiver"],
        date: json["date"],
        snippet: json["snippet"],
        annotations: json["annotations"] == null ? null : Annotations.fromJson(json["annotations"]),
    );

    Map<String, dynamic> toJson() => {
        "subject": subject,
        "sender": sender,
        "receiver": receiver,
        "date": date,
        "snippet": snippet,
        "annotations": annotations?.toJson(),
    };
}

class Annotations {
    Date? subject;
    Date? sender;
    Date? receiver;
    Date? date;
    Date? snippet;

    Annotations({
        this.subject,
        this.sender,
        this.receiver,
        this.date,
        this.snippet,
    });

    Annotations copyWith({
        Date? subject,
        Date? sender,
        Date? receiver,
        Date? date,
        Date? snippet,
    }) => 
        Annotations(
            subject: subject ?? this.subject,
            sender: sender ?? this.sender,
            receiver: receiver ?? this.receiver,
            date: date ?? this.date,
            snippet: snippet ?? this.snippet,
        );

    factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
        subject: json["subject"] == null ? null : Date.fromJson(json["subject"]),
        sender: json["sender"] == null ? null : Date.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : Date.fromJson(json["receiver"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        snippet: json["snippet"] == null ? null : Date.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "subject": subject?.toJson(),
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "date": date?.toJson(),
        "snippet": snippet?.toJson(),
    };
}

class Date {
    String? type;
    String? description;

    Date({
        this.type,
        this.description,
    });

    Date copyWith({
        String? type,
        String? description,
    }) => 
        Date(
            type: type ?? this.type,
            description: description ?? this.description,
        );

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: json["type"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
    };
}
