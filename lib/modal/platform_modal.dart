class PlatformModal
{
  late String name, phone, chatConversation, profile, date, time;
  int? id;

  PlatformModal({ this.id,
    required this.name,
    required this.phone,
    required this.chatConversation,
    required this.profile,
    required this.date,
    required this.time,});

  factory PlatformModal.fromMap(Map m1) {
    return PlatformModal(
      id: m1['id'],
      name: m1['name'],
      phone: m1['phone'],
      chatConversation: m1['chatConversation'],
      profile: m1['profile'],
      date: m1['date'],
      time: m1['time'],
    );
  }

  Map<String, dynamic> toMap(PlatformModal user) {
    return {
      'name': user.name,
      'phone': user.phone,
      'chatConversation': user.chatConversation,
      'profile': user.profile,
      'date': user.date,
      'time': user.time,
    };
  }
}