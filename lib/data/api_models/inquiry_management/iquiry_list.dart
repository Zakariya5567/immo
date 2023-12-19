class InquiryResponse {
  List<Data>? data;
  bool? error;
  String? message;

  InquiryResponse({this.data, this.error, this.message});

  InquiryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  int? propertyId;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? message;

  Data(
      this.id,
        this.title,
        this.propertyId,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.message);

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    propertyId = json['property_id'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['property_id'] = propertyId;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['message'] = message;
    return data;
  }
}
