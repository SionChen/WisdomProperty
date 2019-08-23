

class RemoteDoorListModel{
  final String name;
  final String channelId;
  final Map<String,dynamic> operate;
  String type;
  RemoteDoorListModel(
    {this.name,
    this.channelId,
    this.operate,
    this.type,
    });
  factory RemoteDoorListModel.fromJson(Map<String,dynamic> json){
    return RemoteDoorListModel(
      name:json['name'], 
      channelId:json['channel_id'], 
      operate:json['operate'], 
      type:json['type'],
    );
  }
}