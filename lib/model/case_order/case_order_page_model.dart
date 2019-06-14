import 'package:giant_property/model/case_order/case_order_model.dart';

class CaseOrderPageModel {
  String homeTitle;/*类型 客户端自定义 M维修 、投诉C 巡更W*/
  final int currentPage;
  final List<CaseOrderModel> data;
  final int total;
  final int perPage;
  final CaseOrderModel caseOrder;
  String type;
  String typeIconImageString;
  CaseOrderPageModel({
    this.homeTitle,
    this.currentPage,
    this.data,
    this.total,
    this.perPage,
    this.caseOrder,
    this.type,
  }){//初始化之后
    
  }
  void setType(String value){
    type =value;
    if (type == 'M') {
      homeTitle = "待处理报修";
      typeIconImageString = "assets/images/warrantyIcon.png";
    }else if(type == 'C'){
      homeTitle = "待处理投诉";
      typeIconImageString = "assets/images/complaintsIcon.png";
    }else{
      typeIconImageString = "assets/images/watchmanIcon.png";
    }
  }
  List<CaseOrderModel>  _getDataList(List value){
    List<CaseOrderModel> list = [];
    value.forEach(( map){
      list.add(CaseOrderModel.fromJson(map));
    });
    return list;
  }
  
  factory CaseOrderPageModel.fromJson(Map<String,dynamic> json){
    return CaseOrderPageModel(
      homeTitle: json['homeTitle'],
      currentPage: json['current_page'],
      data: json['data'].map<CaseOrderModel>(( value){
        return CaseOrderModel.fromJson(value);
      }).toList()??[],
      //data: _getDataList(json['data']),
      total: json['total'],
      perPage: json['per_page'],
      caseOrder: CaseOrderModel.fromJson(json['case']??{}),
      type: json['type'],
    );
  }
}