
class CaseOrderModel{
  final int caseId;//id
  final String title;//文章标题
  final String prior;//中
  final String status;//状态
  final String creater;//创建人
  final String dealer;//处理人
  final String pointDealer;//指派处理人
  final String createdAt;//创建时间
  final String updatedAt;//更新时间
  final int towho;//指派处理人
  final int who;//当前id
  final int isNew;//是否是新的
  final String name;//联系人姓名
  final String phone;//电话
  final String pics;//图片
  final List<String> picBigs;//大图
  CaseOrderModel(
    {this.caseId,
    this.title,
    this.prior,
    this.status,
    this.creater,
    this.dealer,
    this.pointDealer,
    this.createdAt,
    this.updatedAt,
    this.towho,
    this.who,
    this.isNew,
    this.name,
    this.phone,
    this.pics,
    this.picBigs,}
  );
  factory CaseOrderModel.fromJson(Map<String,dynamic> json){
    return CaseOrderModel(
      caseId:json['case_id'],
      title:json['title'],
      prior:json['prior'],
      status:json['status'],
      creater:json['creater'],
      dealer:json['dealer'],
      pointDealer:json['pointDealer'],
      createdAt:json['created_at'],
      updatedAt:json['updated_at'],
      towho:json['towho'],
      who:json['who'],
      isNew:json['is_new'],
      name:json['name'],
      phone:json['phone'],
      pics:json ['pics'],
      picBigs:json['picBigs'],
    );
  }
}