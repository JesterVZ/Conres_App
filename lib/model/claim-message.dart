class ClaimMessage{
  String? claim_message_id;
  String? date;
  String? claim_id;
  String? user_type;
  String? user_id;
  String? user_name;
  String? text;
  String? attachments;
  String? claims_status_id;

  ClaimMessage({
    required this.claim_message_id,
    required this.claim_id,
    required this.date,
    required this.attachments,
    required this.claims_status_id,
    required this.text,
    required this.user_id,
    required this.user_name,
    required this.user_type
  });

  factory ClaimMessage.fromMap(Map<dynamic, dynamic> map){
    return ClaimMessage(
      claim_message_id: map['claim_message_id'], 
      claim_id: map['claim_id'], 
      date: map['date'], 
      attachments: map['attachments'], 
      claims_status_id: map['claims_status_id'], 
      text: map['text'], 
      user_id: map['user_id'], 
      user_name: map['user_name'], 
      user_type: map['user_type']);
  }
}

class ClaimFile{

}