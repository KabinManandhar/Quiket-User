class OrderModel {
  int id;
  int ticketId;
  int userId;
  int status;
  String qrCode;
  String createdAt;
  String updatedAt;
  String userName;
  String ticketName;
  String eventName;
  int eventId;

  OrderModel({
    this.id,
    this.ticketId,
    this.userId,
    this.eventId,
    this.status,
    this.qrCode,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.ticketName,
    this.eventName,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    status = json['status'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['User Name'];
    ticketName = json['Ticket Name'];
    eventName = json['Event Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['event_id'] = this.eventId;
    data['status'] = this.status;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['User Name'] = this.userName;
    data['Ticket Name'] = this.ticketName;
    data['Event Name'] = this.eventName;
    return data;
  }
}
