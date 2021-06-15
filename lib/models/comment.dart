class Note {
  String? fromId;
  String? fromName;
  String? comment;
  String? dateTime;
  String? docId;

  Note({
    this.fromId,
    this.fromName,
    this.comment,
    this.dateTime,
    this.docId,
  });

  Note.fromJson(Map<String, dynamic> json) {
    fromId = json['fromId'];
    fromName = json['fromName'];
    comment = json['comment'];
    dateTime = json['dateTime'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromId'] = this.fromId;
    data['fromName'] = this.fromName;
    data['comment'] = this.comment;
    data['dateTime'] = this.dateTime;
    data['docId'] = this.docId;
    return data;
  }
}
