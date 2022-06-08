class LiveStream {
  final int userId;
  final String numberCode;
  final String channelName;

  LiveStream({
    required this.userId,
    required this.numberCode,
    required this.channelName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'numberCode': numberCode,
      'channelId': channelName,
    };
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      userId: map['userId'],
      numberCode: map['numberCode'] ?? '',
      channelName: map['channelName'] ?? '',
    );
  }
}
