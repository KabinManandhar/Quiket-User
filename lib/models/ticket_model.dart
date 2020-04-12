class TicketModel {
  int id;
  String name;
  String description;
  int price;
  int totalTicket;
  int maxTicket;
  int minTicket;
  int ticketType;
  int status;
  int eventId;
  int boughtTicket;

  TicketModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.totalTicket,
    this.maxTicket,
    this.minTicket,
    this.ticketType,
    this.status,
    this.eventId,
    this.boughtTicket,
  });

  TicketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    totalTicket = json['total_ticket'];
    maxTicket = json['max_ticket_allowed_per_person'];
    minTicket = json['min_ticket_allowed_per_person'];
    ticketType = json['ticket_type'];
    status = json['status'];
    eventId = json['event_id'];
    boughtTicket = json['bought_ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['total_ticket'] = this.totalTicket;
    data['max_ticket_allowed_per_person'] = this.maxTicket;
    data['min_ticket_allowed_per_person'] = this.minTicket;
    data['ticket_type'] = this.ticketType;
    data['status'] = this.status;
    data['event_id'] = this.eventId;
    data['bought_ticket'] = this.boughtTicket;
    return data;
  }
}
