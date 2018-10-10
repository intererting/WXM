import 'package:wxm/vm/main/common_model.dart';

class CommodityInfo extends HttpResult<List<CommodityData>> {
  CommodityInfo.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['data'] != null) {
      data = new List<CommodityData>();
      json['data'].forEach((v) {
        data.add(new CommodityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    data['resultCount'] = this.resultCount;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommodityData {
  int commodityId;
  String commodityName;
  String commodityLogoUrl;
  String commodityImgUrl;
  String commodityUrl;
  String commodityTypeId;
  String introduction;
  double feeOld;
  double feeNow;
  String numberUnit;
  String priceUnit;
  String standard;
  int purchaseScores;
  int exchangeScores;
  int scoreFlag;
  String approvalNumber;
  String recipe;
  String efficacy;
  String suitPeople;
  String useMethod;
  String others;
  int topFlag;
  int recommendFlag;
  String useFlag;
  String remarks;
  String addUserId;
  String updUserId;
  String addTime;
  String updTime;
  String saleNumbers;
  String appraiseScore;
  String appraiseNum;

  CommodityData(
      {this.commodityId,
      this.commodityName,
      this.commodityLogoUrl,
      this.commodityImgUrl,
      this.commodityUrl,
      this.commodityTypeId,
      this.introduction,
      this.feeOld,
      this.feeNow,
      this.numberUnit,
      this.priceUnit,
      this.standard,
      this.purchaseScores,
      this.exchangeScores,
      this.scoreFlag,
      this.approvalNumber,
      this.recipe,
      this.efficacy,
      this.suitPeople,
      this.useMethod,
      this.others,
      this.topFlag,
      this.recommendFlag,
      this.useFlag,
      this.remarks,
      this.addUserId,
      this.updUserId,
      this.addTime,
      this.updTime,
      this.saleNumbers,
      this.appraiseScore,
      this.appraiseNum});

  CommodityData.fromJson(Map<String, dynamic> json) {
    commodityId = json['commodityId'];
    commodityName = json['commodityName'];
    commodityLogoUrl = json['commodityLogoUrl'];
    commodityImgUrl = json['commodityImgUrl'];
    commodityUrl = json['commodityUrl'];
    commodityTypeId = json['commodityTypeId'];
    introduction = json['introduction'];
    feeOld = json['feeOld'];
    feeNow = json['feeNow'];
    numberUnit = json['numberUnit'];
    priceUnit = json['priceUnit'];
    standard = json['standard'];
    purchaseScores = json['purchaseScores'];
    exchangeScores = json['exchangeScores'];
    scoreFlag = json['scoreFlag'];
    approvalNumber = json['approvalNumber'];
    recipe = json['recipe'];
    efficacy = json['efficacy'];
    suitPeople = json['suitPeople'];
    useMethod = json['useMethod'];
    others = json['others'];
    topFlag = json['topFlag'];
    recommendFlag = json['recommendFlag'];
    useFlag = json['useFlag'];
    remarks = json['remarks'];
    addUserId = json['addUserId'];
    updUserId = json['updUserId'];
    addTime = json['addTime'];
    updTime = json['updTime'];
    saleNumbers = json['saleNumbers'];
    appraiseScore = json['appraiseScore'];
    appraiseNum = json['appraiseNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodityId'] = this.commodityId;
    data['commodityName'] = this.commodityName;
    data['commodityLogoUrl'] = this.commodityLogoUrl;
    data['commodityImgUrl'] = this.commodityImgUrl;
    data['commodityUrl'] = this.commodityUrl;
    data['commodityTypeId'] = this.commodityTypeId;
    data['introduction'] = this.introduction;
    data['feeOld'] = this.feeOld;
    data['feeNow'] = this.feeNow;
    data['numberUnit'] = this.numberUnit;
    data['priceUnit'] = this.priceUnit;
    data['standard'] = this.standard;
    data['purchaseScores'] = this.purchaseScores;
    data['exchangeScores'] = this.exchangeScores;
    data['scoreFlag'] = this.scoreFlag;
    data['approvalNumber'] = this.approvalNumber;
    data['recipe'] = this.recipe;
    data['efficacy'] = this.efficacy;
    data['suitPeople'] = this.suitPeople;
    data['useMethod'] = this.useMethod;
    data['others'] = this.others;
    data['topFlag'] = this.topFlag;
    data['recommendFlag'] = this.recommendFlag;
    data['useFlag'] = this.useFlag;
    data['remarks'] = this.remarks;
    data['addUserId'] = this.addUserId;
    data['updUserId'] = this.updUserId;
    data['addTime'] = this.addTime;
    data['updTime'] = this.updTime;
    data['saleNumbers'] = this.saleNumbers;
    data['appraiseScore'] = this.appraiseScore;
    data['appraiseNum'] = this.appraiseNum;
    return data;
  }
}
