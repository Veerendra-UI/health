class Providers {
  Header header;
  List<ProviderList> providerList;

  Providers({this.header, this.providerList});

  Providers.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['providerList'] != null) {
      providerList = new List<ProviderList>();
      json['providerList'].forEach((v) {
        providerList.add(new ProviderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.providerList != null) {
      data['providerList'] = this.providerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String status;
  String statusCode;
  String statusMessage;

  Header({this.status, this.statusCode, this.statusMessage});

  Header.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}

class ProviderList {
  int providerId;
  String firstName;
  String lastName;
  String displayname;
  String suffix;

  ProviderList(
      {this.providerId,
      this.firstName,
      this.lastName,
      this.displayname,
      this.suffix});

  ProviderList.fromJson(Map<String, dynamic> json) {
    providerId = json['providerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayname = json['displayname'];
    suffix = json['suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerId'] = this.providerId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['displayname'] = this.displayname;
    data['suffix'] = this.suffix;
    return data;
  }

  @override
  String toString() {
    return 'ProviderList{providerId: $providerId, displayname: $displayname}';
  }

  @override
// TODO: implement props
  List<Object> get props => [
        this.providerId,
        this.displayname,
        this.firstName,
      ];
}
