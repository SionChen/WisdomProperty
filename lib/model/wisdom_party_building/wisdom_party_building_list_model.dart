


class  WisdomPartyBuildingListModel{
  final int id;
  final String notice;
  final String title;
  final String body;
  final int userId;
  final String createdAt;
  final String updateAt;
  WisdomPartyBuildingListModel(
    {this.id,
    this.notice,
    this.title,
    this.body,
    this.userId,
    this.createdAt,
    this.updateAt}
  );
  factory WisdomPartyBuildingListModel.fromJson(Map<String,dynamic> json){
    return WisdomPartyBuildingListModel(
      id:json['id'],
      notice:json['notice'],
      title:json['title'],
      body:json['body'],
      userId:json['user_id'],
      createdAt:json['created_at'],
      updateAt:json['update_at'],
    );
  }
}