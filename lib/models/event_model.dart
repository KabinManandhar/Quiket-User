class EventModel {
  int id;
  String name;
  String description;
  String venue;
  String category;
  String type;
  String picture;
  int status;
  String startDatetime;
  String endDatetime;
  int organizerId;
  String organizerName;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.venue,
    this.category,
    this.type,
    this.picture,
    this.status,
    this.startDatetime,
    this.endDatetime,
    this.organizerId,
    this.organizerName,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    venue = json['venue'];
    category = json['category'];
    type = json['type'];
    picture = json['picture'];
    status = json['status'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    organizerId = json['organizer_id'];
    organizerName = json['organizer_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['venue'] = this.venue;
    data['category'] = this.category;
    data['type'] = this.type;
    data['status'] = this.status;
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['organizer_id'] = this.organizerId;
    data['organizer_name'] = this.organizerName;
    data['picture'] = this.picture;

    return data;
  }
}
