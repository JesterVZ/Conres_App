class ClaimMessage{
  String? claim_message_id;
  String? date;
  String? claim_id;
  String? user_type;
  String? user_id;
  String? user_name;
  String? message;
  ClaimFile? data;
  String? claims_status_id;
  bool? isOwn;

  ClaimMessage({
    required this.claim_message_id,
    required this.claim_id,
    required this.date,
    required this.data,
    required this.claims_status_id,
    required this.message,
    required this.user_id,
    required this.user_name,
    required this.user_type,
    this.isOwn
  });

  factory ClaimMessage.fromMap(Map<dynamic, dynamic> map){
    return ClaimMessage(
      claim_message_id: map['claim_message_id'], 
      claim_id: map['claim_id'], 
      date: map['date'], 
      data: map['attachments'] != null ? ClaimFile.fromMap(map['attachments'][0]) : null, 
      claims_status_id: map['claims_status_id'], 
      message: map['text'], 
      user_id: map['user_id'], 
      user_name: map['user_name'], 
      user_type: map['user_type']);
  }
}

class ClaimFile{
  String? document_name;
  String? filename;
  String? file_href_mail;
  String? href;
  String? thumb;

  ClaimFile({
    required this.document_name,
    required this.filename,
    required this.file_href_mail,
    required this.href,
    required this.thumb
  });

  factory ClaimFile.fromMap(Map<dynamic, dynamic> map){
    return ClaimFile(
      document_name: map['document_name'], 
      filename: map['filename'], 
      file_href_mail: map['file_href_mail'], 
      href: map['href'],
      thumb: null);
  }
}