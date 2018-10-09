import 'package:wxm/vm/main/common_model.dart';

class AdInfo extends HttpResult<List<AdData>> {
  AdInfo.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['data'] != null) {
      data = new List<AdData>();
      json['data'].forEach((v) {
        data.add(new AdData.fromJson(v));
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

class AdData {
  String adId;
  String imgUrl;
  String linkUrl;
  String adInfo;
  String linkType;
  String adType;

  AdData(
      {this.adId,
      this.imgUrl,
      this.linkUrl,
      this.adInfo,
      this.linkType,
      this.adType});

  AdData.fromJson(Map<String, dynamic> json) {
    adId = json['adId'];
    imgUrl = json['imgUrl'];
    linkUrl = json['linkUrl'];
    adInfo = json['adInfo'];
    linkType = json['linkType'];
    adType = json['adType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adId'] = this.adId;
    data['imgUrl'] = this.imgUrl;
    data['linkUrl'] = this.linkUrl;
    data['adInfo'] = this.adInfo;
    data['linkType'] = this.linkType;
    data['adType'] = this.adType;
    return data;
  }
}
