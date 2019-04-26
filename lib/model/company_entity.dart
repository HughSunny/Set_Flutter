
class CompanyEntity {
  String _id;
  String _name;
  String _statement;
  String _locationId;
  String _logoId;
  String _url;
  String _companyTypeId;
  String _industryId;
  String _companySizeId;
  String _address;
  String _lng;
  String _lat;
  String _contact;
  String _emailAddress;
  String _phoneNumber;
  Null _businessLicenseId;
  String _description;
  int _status;
  int _jobCount;
  String _processingRate;
  String _lastJobPublishedOn;
  String _industry;
  String _companySize;
  String _location;
  String _companyType;
  Null _followId;
  String _updatedOn;

  CompanyEntity(
      {String id,
        String name,
        String statement,
        String locationId,
        String logoId,
        String url,
        String companyTypeId,
        String industryId,
        String companySizeId,
        String address,
        String lng,
        String lat,
        String contact,
        String emailAddress,
        String phoneNumber,
        Null businessLicenseId,
        String description,
        int status,
        int jobCount,
        String processingRate,
        String lastJobPublishedOn,
        String industry,
        String companySize,
        String location,
        String companyType,
        Null followId,
        String updatedOn}) {
    this._id = id;
    this._name = name;
    this._statement = statement;
    this._locationId = locationId;
    this._logoId = logoId;
    this._url = url;
    this._companyTypeId = companyTypeId;
    this._industryId = industryId;
    this._companySizeId = companySizeId;
    this._address = address;
    this._lng = lng;
    this._lat = lat;
    this._contact = contact;
    this._emailAddress = emailAddress;
    this._phoneNumber = phoneNumber;
    this._businessLicenseId = businessLicenseId;
    this._description = description;
    this._status = status;
    this._jobCount = jobCount;
    this._processingRate = processingRate;
    this._lastJobPublishedOn = lastJobPublishedOn;
    this._industry = industry;
    this._companySize = companySize;
    this._location = location;
    this._companyType = companyType;
    this._followId = followId;
    this._updatedOn = updatedOn;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get statement => _statement;
  set statement(String statement) => _statement = statement;
  String get locationId => _locationId;
  set locationId(String locationId) => _locationId = locationId;
  String get logoId => _logoId;
  set logoId(String logoId) => _logoId = logoId;
  String get url => _url;
  set url(String url) => _url = url;
  String get companyTypeId => _companyTypeId;
  set companyTypeId(String companyTypeId) => _companyTypeId = companyTypeId;
  String get industryId => _industryId;
  set industryId(String industryId) => _industryId = industryId;
  String get companySizeId => _companySizeId;
  set companySizeId(String companySizeId) => _companySizeId = companySizeId;
  String get address => _address;
  set address(String address) => _address = address;
  String get lng => _lng;
  set lng(String lng) => _lng = lng;
  String get lat => _lat;
  set lat(String lat) => _lat = lat;
  String get contact => _contact;
  set contact(String contact) => _contact = contact;
  String get emailAddress => _emailAddress;
  set emailAddress(String emailAddress) => _emailAddress = emailAddress;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  Null get businessLicenseId => _businessLicenseId;
  set businessLicenseId(Null businessLicenseId) =>
      _businessLicenseId = businessLicenseId;
  String get description => _description;
  set description(String description) => _description = description;
  int get status => _status;
  set status(int status) => _status = status;
  int get jobCount => _jobCount;
  set jobCount(int jobCount) => _jobCount = jobCount;
  String get processingRate => _processingRate;
  set processingRate(String processingRate) => _processingRate = processingRate;
  String get lastJobPublishedOn => _lastJobPublishedOn;
  set lastJobPublishedOn(String lastJobPublishedOn) =>
      _lastJobPublishedOn = lastJobPublishedOn;
  String get industry => _industry;
  set industry(String industry) => _industry = industry;
  String get companySize => _companySize;
  set companySize(String companySize) => _companySize = companySize;
  String get location => _location;
  set location(String location) => _location = location;
  String get companyType => _companyType;
  set companyType(String companyType) => _companyType = companyType;
  Null get followId => _followId;
  set followId(Null followId) => _followId = followId;
  String get updatedOn => _updatedOn;
  set updatedOn(String updatedOn) => _updatedOn = updatedOn;

  CompanyEntity.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _statement = json['statement'];
    _locationId = json['locationId'];
    _logoId = json['logoId'];
    _url = json['url'];
    _companyTypeId = json['companyTypeId'];
    _industryId = json['industryId'];
    _companySizeId = json['companySizeId'];
    _address = json['address'];
    _lng = json['lng'];
    _lat = json['lat'];
    _contact = json['contact'];
    _emailAddress = json['emailAddress'];
    _phoneNumber = json['phoneNumber'];
    _businessLicenseId = json['businessLicenseId'];
    _description = json['description'];
    _status = json['status'];
    _jobCount = json['jobCount'];
    _processingRate = json['processingRate'];
    _lastJobPublishedOn = json['lastJobPublishedOn'];
    _industry = json['industry'];
    _companySize = json['companySize'];
    _location = json['location'];
    _companyType = json['companyType'];
    _followId = json['followId'];
    _updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['statement'] = this._statement;
    data['locationId'] = this._locationId;
    data['logoId'] = this._logoId;
    data['url'] = this._url;
    data['companyTypeId'] = this._companyTypeId;
    data['industryId'] = this._industryId;
    data['companySizeId'] = this._companySizeId;
    data['address'] = this._address;
    data['lng'] = this._lng;
    data['lat'] = this._lat;
    data['contact'] = this._contact;
    data['emailAddress'] = this._emailAddress;
    data['phoneNumber'] = this._phoneNumber;
    data['businessLicenseId'] = this._businessLicenseId;
    data['description'] = this._description;
    data['status'] = this._status;
    data['jobCount'] = this._jobCount;
    data['processingRate'] = this._processingRate;
    data['lastJobPublishedOn'] = this._lastJobPublishedOn;
    data['industry'] = this._industry;
    data['companySize'] = this._companySize;
    data['location'] = this._location;
    data['companyType'] = this._companyType;
    data['followId'] = this._followId;
    data['updatedOn'] = this._updatedOn;
    return data;
  }
}
