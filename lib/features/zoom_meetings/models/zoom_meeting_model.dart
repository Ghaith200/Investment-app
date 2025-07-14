class ZoomMeetingModel {
  final String topic;
  final String agenda;
  final String joinUrl;

  ZoomMeetingModel({
    required this.topic,
    required this.agenda,
    required this.joinUrl,
  });

  factory ZoomMeetingModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ZoomMeetingModel(
      topic: data['topic'],
      agenda: data['agenda'],
      joinUrl: data['zoom_join_url'],
    );
  }
}
