class DraftModel {
  String? subject;
  String? sender;
  String? receiver;
  String? date;
  String? snippet;
  bool? readStatus;
  Annotations? annotations;

  DraftModel({
    this.subject,
    this.sender,
    this.receiver,
    this.date,
    this.snippet,
    this.readStatus,
    this.annotations,
  });
}

class Annotations {
  // Define any additional properties or methods for the Annotations class if needed
}
