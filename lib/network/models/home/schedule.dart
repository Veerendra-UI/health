class Schedule {
  Header header;
  List<ScheduleList> scheduleList;
  PagingInfo pagingInfo;

  Schedule({this.header, this.scheduleList, this.pagingInfo});

  Schedule.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['scheduleList'] != null) {
      scheduleList = new List<ScheduleList>();
      json['scheduleList'].forEach((v) {
        scheduleList.add(new ScheduleList.fromJson(v));
      });
    }
    pagingInfo = json['pagingInfo'] != null
        ? new PagingInfo.fromJson(json['pagingInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.scheduleList != null) {
      data['scheduleList'] = this.scheduleList.map((v) => v.toJson()).toList();
    }
    if (this.pagingInfo != null) {
      data['pagingInfo'] = this.pagingInfo.toJson();
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

class ScheduleList {
  Header header;
  String scheduleName;
  String firstName;
  String lastName;
  String displayName;
  int providerId;
  String providerName;
  int practiceId;
  int practiceLocationId;
  String practice;
  String appointmentStatus;
  String appointmentStartDate;
  String appointmentEndDate;
  int episodeAppointmentRequestId;
  Patient patient;
  Location location;
  int locationId;
  int dictationId;
  int dictationStatusId;
  String dictationStatus;
  String dictationStatusColor;
  bool hasGeneralComments;
  String appointmentType;
  String toDoListStatus;
  int episodeId;
  String lynxId;
  String caseType;
  String injuryType;
  String accidentDate;
  bool canDictate;
  bool canContinueDictation;
  String continueDictationMessage;
  String procedureName;
  int appointmentTypeId;
  int surgeryAssociatedRoles;
  int dictationTypeId;
  int nbrMemberId;
  bool isStatFile;
  bool isEnableStatFile;
  bool isCheckInEnabled;
  bool isCheckOutEnabled;
  bool isSuperBillEnabled;
  bool isVideoCallEnabled;
  String videoSessionId;
  bool dictationApproveRejectEnabled;

  ScheduleList(
      {this.header,
      this.scheduleName,
      this.firstName,
      this.lastName,
      this.displayName,
      this.providerId,
      this.providerName,
      this.practiceId,
      this.practiceLocationId,
      this.practice,
      this.appointmentStatus,
      this.appointmentStartDate,
      this.appointmentEndDate,
      this.episodeAppointmentRequestId,
      this.patient,
      this.location,
      this.locationId,
      this.dictationId,
      this.dictationStatusId,
      this.dictationStatus,
      this.dictationStatusColor,
      this.hasGeneralComments,
      this.appointmentType,
      this.toDoListStatus,
      this.episodeId,
      this.lynxId,
      this.caseType,
      this.injuryType,
      this.accidentDate,
      this.canDictate,
      this.canContinueDictation,
      this.continueDictationMessage,
      this.procedureName,
      this.appointmentTypeId,
      this.surgeryAssociatedRoles,
      this.dictationTypeId,
      this.nbrMemberId,
      this.isStatFile,
      this.isEnableStatFile,
      this.isCheckInEnabled,
      this.isCheckOutEnabled,
      this.isSuperBillEnabled,
      this.isVideoCallEnabled,
      this.videoSessionId,
      this.dictationApproveRejectEnabled});

  ScheduleList.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    scheduleName = json['scheduleName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayName = json['displayName'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    practiceId = json['practiceId'];
    practiceLocationId = json['practiceLocationId'];
    practice = json['practice'];
    appointmentStatus = json['appointmentStatus'];
    appointmentStartDate = json['appointmentStartDate'];
    appointmentEndDate = json['appointmentEndDate'];
    episodeAppointmentRequestId = json['episodeAppointmentRequestId'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    locationId = json['locationId'];
    dictationId = json['dictationId'];
    dictationStatusId = json['dictationStatusId'];
    dictationStatus = json['dictationStatus'];
    dictationStatusColor = json['dictationStatusColor'];
    hasGeneralComments = json['hasGeneralComments'];
    appointmentType = json['appointmentType'];
    toDoListStatus = json['toDoListStatus'];
    episodeId = json['episodeId'];
    lynxId = json['lynxId'];
    caseType = json['caseType'];
    injuryType = json['injuryType'];
    accidentDate = json['accidentDate'];
    canDictate = json['canDictate'];
    canContinueDictation = json['canContinueDictation'];
    continueDictationMessage = json['continueDictationMessage'];
    procedureName = json['procedureName'];
    appointmentTypeId = json['appointmentTypeId'];
    surgeryAssociatedRoles = json['surgeryAssociatedRoles'];
    dictationTypeId = json['dictationTypeId'];
    nbrMemberId = json['nbrMemberId'];
    isStatFile = json['isStatFile'];
    isEnableStatFile = json['isEnableStatFile'];
    isCheckInEnabled = json['isCheckInEnabled'];
    isCheckOutEnabled = json['isCheckOutEnabled'];
    isSuperBillEnabled = json['isSuperBillEnabled'];
    isVideoCallEnabled = json['isVideoCallEnabled'];
    videoSessionId = json['videoSessionId'];
    dictationApproveRejectEnabled = json['dictationApproveRejectEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    data['scheduleName'] = this.scheduleName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['displayName'] = this.displayName;
    data['providerId'] = this.providerId;
    data['providerName'] = this.providerName;
    data['practiceId'] = this.practiceId;
    data['practiceLocationId'] = this.practiceLocationId;
    data['practice'] = this.practice;
    data['appointmentStatus'] = this.appointmentStatus;
    data['appointmentStartDate'] = this.appointmentStartDate;
    data['appointmentEndDate'] = this.appointmentEndDate;
    data['episodeAppointmentRequestId'] = this.episodeAppointmentRequestId;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['locationId'] = this.locationId;
    data['dictationId'] = this.dictationId;
    data['dictationStatusId'] = this.dictationStatusId;
    data['dictationStatus'] = this.dictationStatus;
    data['dictationStatusColor'] = this.dictationStatusColor;
    data['hasGeneralComments'] = this.hasGeneralComments;
    data['appointmentType'] = this.appointmentType;
    data['toDoListStatus'] = this.toDoListStatus;
    data['episodeId'] = this.episodeId;
    data['lynxId'] = this.lynxId;
    data['caseType'] = this.caseType;
    data['injuryType'] = this.injuryType;
    data['accidentDate'] = this.accidentDate;
    data['canDictate'] = this.canDictate;
    data['canContinueDictation'] = this.canContinueDictation;
    data['continueDictationMessage'] = this.continueDictationMessage;
    data['procedureName'] = this.procedureName;
    data['appointmentTypeId'] = this.appointmentTypeId;
    data['surgeryAssociatedRoles'] = this.surgeryAssociatedRoles;
    data['dictationTypeId'] = this.dictationTypeId;
    data['nbrMemberId'] = this.nbrMemberId;
    data['isStatFile'] = this.isStatFile;
    data['isEnableStatFile'] = this.isEnableStatFile;
    data['isCheckInEnabled'] = this.isCheckInEnabled;
    data['isCheckOutEnabled'] = this.isCheckOutEnabled;
    data['isSuperBillEnabled'] = this.isSuperBillEnabled;
    data['isVideoCallEnabled'] = this.isVideoCallEnabled;
    data['videoSessionId'] = this.videoSessionId;
    data['dictationApproveRejectEnabled'] = this.dictationApproveRejectEnabled;
    return data;
  }
}

class Patient {
  Header header;
  int id;
  String firstName;
  String lastName;
  String middleName;
  String displayName;
  String sex;
  String dob;
  String maritalStatus;
  String race;
  String telephone;
  String city;
  String fullName;
  int age;
  String emailAddress;
  int memberId;
  String accountNumber;
  String phoneNumber;
  int episodePatietnId;
  String lynxId;
  String mrn;
  String addressLine1;
  String addressLine2;
  String state;
  String postalCode;
  String ssn;
  List<PatientPhones> patientPhones;
  int modifiedBy;
  String phonesXML;
  String loginName;
  String cellPhone;
  String workPhone;
  String homePhone;
  String extension;
  int eazyscriptspatientid;
  String suffix;
  String profilePhotoName;
  String providerName;

  Patient(
      {this.header,
      this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.displayName,
      this.sex,
      this.dob,
      this.maritalStatus,
      this.race,
      this.telephone,
      this.city,
      this.fullName,
      this.age,
      this.emailAddress,
      this.memberId,
      this.accountNumber,
      this.phoneNumber,
      this.episodePatietnId,
      this.lynxId,
      this.mrn,
      this.addressLine1,
      this.addressLine2,
      this.state,
      this.postalCode,
      this.ssn,
      this.patientPhones,
      this.modifiedBy,
      this.phonesXML,
      this.loginName,
      this.cellPhone,
      this.workPhone,
      this.homePhone,
      this.extension,
      this.eazyscriptspatientid,
      this.suffix,
      this.profilePhotoName,
      this.providerName});

  Patient.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    displayName = json['displayName'];
    sex = json['sex'];
    dob = json['dob'];
    maritalStatus = json['maritalStatus'];
    race = json['race'];
    telephone = json['telephone'];
    city = json['city'];
    fullName = json['fullName'];
    age = json['age'];
    emailAddress = json['emailAddress'];
    memberId = json['memberId'];
    accountNumber = json['accountNumber'];
    phoneNumber = json['phoneNumber'];
    episodePatietnId = json['episodePatietnId'];
    lynxId = json['lynxId'];
    mrn = json['mrn'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    state = json['state'];
    postalCode = json['postalCode'];
    ssn = json['ssn'];
    if (json['patientPhones'] != null) {
      patientPhones = new List<PatientPhones>();
      json['patientPhones'].forEach((v) {
        patientPhones.add(new PatientPhones.fromJson(v));
      });
    }
    modifiedBy = json['modifiedBy'];
    phonesXML = json['phonesXML'];
    loginName = json['loginName'];
    cellPhone = json['cellPhone'];
    workPhone = json['workPhone'];
    homePhone = json['homePhone'];
    extension = json['extension'];
    eazyscriptspatientid = json['eazyscriptspatientid'];
    suffix = json['suffix'];
    profilePhotoName = json['profilePhotoName'];
    providerName = json['providerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['displayName'] = this.displayName;
    data['sex'] = this.sex;
    data['dob'] = this.dob;
    data['maritalStatus'] = this.maritalStatus;
    data['race'] = this.race;
    data['telephone'] = this.telephone;
    data['city'] = this.city;
    data['fullName'] = this.fullName;
    data['age'] = this.age;
    data['emailAddress'] = this.emailAddress;
    data['memberId'] = this.memberId;
    data['accountNumber'] = this.accountNumber;
    data['phoneNumber'] = this.phoneNumber;
    data['episodePatietnId'] = this.episodePatietnId;
    data['lynxId'] = this.lynxId;
    data['mrn'] = this.mrn;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['ssn'] = this.ssn;
    if (this.patientPhones != null) {
      data['patientPhones'] =
          this.patientPhones.map((v) => v.toJson()).toList();
    }
    data['modifiedBy'] = this.modifiedBy;
    data['phonesXML'] = this.phonesXML;
    data['loginName'] = this.loginName;
    data['cellPhone'] = this.cellPhone;
    data['workPhone'] = this.workPhone;
    data['homePhone'] = this.homePhone;
    data['extension'] = this.extension;
    data['eazyscriptspatientid'] = this.eazyscriptspatientid;
    data['suffix'] = this.suffix;
    data['profilePhotoName'] = this.profilePhotoName;
    data['providerName'] = this.providerName;
    return data;
  }
}

class PatientPhones {
  int id;
  int phoneTypeId;
  String otherType;
  String phoneNumber;
  String phoneExtension;
  bool isPrimaryPhone;
  bool isPhoneEnabled;
  bool isTextEnabled;

  PatientPhones(
      {this.id,
      this.phoneTypeId,
      this.otherType,
      this.phoneNumber,
      this.phoneExtension,
      this.isPrimaryPhone,
      this.isPhoneEnabled,
      this.isTextEnabled});

  PatientPhones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneTypeId = json['phoneTypeId'];
    otherType = json['otherType'];
    phoneNumber = json['phoneNumber'];
    phoneExtension = json['phoneExtension'];
    isPrimaryPhone = json['isPrimaryPhone'];
    isPhoneEnabled = json['isPhoneEnabled'];
    isTextEnabled = json['isTextEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneTypeId'] = this.phoneTypeId;
    data['otherType'] = this.otherType;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneExtension'] = this.phoneExtension;
    data['isPrimaryPhone'] = this.isPrimaryPhone;
    data['isPhoneEnabled'] = this.isPhoneEnabled;
    data['isTextEnabled'] = this.isTextEnabled;
    return data;
  }
}

class Location {
  Header header;
  int id;
  String name;
  bool isActive;
  String createdDate;
  int createdBy;
  String modifiedDate;
  int modifiedBy;
  String address;
  String city;
  String state;
  String zipcode;
  String phoneNumber;
  String workPhone2;
  String fax;
  String image;
  int longitude;
  int lattitude;
  int locationTypeId;
  bool usingTransportation;
  int practiceLocationId;
  int providerId;
  int locationId;
  String locationName;
  int practiceId;
  String country;
  int distanceInMiles;

  Location(
      {this.header,
      this.id,
      this.name,
      this.isActive,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.address,
      this.city,
      this.state,
      this.zipcode,
      this.phoneNumber,
      this.workPhone2,
      this.fax,
      this.image,
      this.longitude,
      this.lattitude,
      this.locationTypeId,
      this.usingTransportation,
      this.practiceLocationId,
      this.providerId,
      this.locationId,
      this.locationName,
      this.practiceId,
      this.country,
      this.distanceInMiles});

  Location.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    phoneNumber = json['phoneNumber'];
    workPhone2 = json['workPhone2'];
    fax = json['fax'];
    image = json['image'];
    longitude = json['longitude'];
    lattitude = json['lattitude'];
    locationTypeId = json['locationTypeId'];
    usingTransportation = json['usingTransportation'];
    practiceLocationId = json['practiceLocationId'];
    providerId = json['providerId'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    practiceId = json['practiceId'];
    country = json['country'];
    distanceInMiles = json['distanceInMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['modifiedDate'] = this.modifiedDate;
    data['modifiedBy'] = this.modifiedBy;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['phoneNumber'] = this.phoneNumber;
    data['workPhone2'] = this.workPhone2;
    data['fax'] = this.fax;
    data['image'] = this.image;
    data['longitude'] = this.longitude;
    data['lattitude'] = this.lattitude;
    data['locationTypeId'] = this.locationTypeId;
    data['usingTransportation'] = this.usingTransportation;
    data['practiceLocationId'] = this.practiceLocationId;
    data['providerId'] = this.providerId;
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['practiceId'] = this.practiceId;
    data['country'] = this.country;
    data['distanceInMiles'] = this.distanceInMiles;
    return data;
  }
}

class PagingInfo {
  int totalItems;
  int itemsPerPage;
  int currentPage;

  PagingInfo({this.totalItems, this.itemsPerPage, this.currentPage});

  PagingInfo.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    itemsPerPage = json['itemsPerPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['itemsPerPage'] = this.itemsPerPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}
