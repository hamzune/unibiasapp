// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.uuid,
    this.fullname,
    this.firstname,
    this.lastname,
    this.username,
    this.password,
    this.email,
    this.active,
    this.pic,
    this.roles,
    this.occupation,
    this.universityName,
    this.phone,
    this.address,
    this.socialNetworks,
    this.firstTime,
    this.website,
    this.language,
    this.timeZone,
    this.communication,
    this.emailSettings,
  });

  String uuid;
  String fullname;
  String firstname;
  String lastname;
  String username;
  String password;
  String email;
  int active;
  String pic;
  List<int> roles;
  String occupation;
  String universityName;
  String phone;
  Address address;
  SocialNetworks socialNetworks;
  int firstTime;
  String website;
  String language;
  String timeZone;
  Communication communication;
  EmailSettings emailSettings;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uuid: json["uuid"],
        fullname: json["fullname"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        active: json["active"],
        pic: json["pic"],
        // roles: List<int>.from(json["roles"].map((x) => x)),
        occupation: json["occupation"],
        universityName: json["universityName"],
        phone: json["phone"],
        // address: Address.fromJson(json["address"]),
        // socialNetworks: SocialNetworks.fromJson(json["socialNetworks"]),
        firstTime: json["firstTime"],
        website: json["website"],
        // language: json["language"],
        // timeZone: json["timeZone"],
        // communication: Communication.fromJson(json["communication"]),
        // emailSettings: EmailSettings.fromJson(json["emailSettings"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "fullname": fullname,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "active": active,
        "pic": pic,
        // "roles": List<dynamic>.from(roles.map((x) => x)),
        "occupation": occupation,
        "universityName": universityName,
        "phone": phone,
        // "address": address.toJson(),
        // "socialNetworks": socialNetworks.toJson(),
        "firstTime": firstTime,
        "website": website,
        // "language": language,
        // "timeZone": timeZone,
        // "communication": communication.toJson(),
        // "emailSettings": emailSettings.toJson(),
      };
}

class Address {
  Address({
    this.addressLine,
    this.city,
    this.state,
    this.postCode,
  });

  String addressLine;
  String city;
  String state;
  String postCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine: json["addressLine"],
        city: json["city"],
        state: json["state"],
        postCode: json["postCode"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine": addressLine,
        "city": city,
        "state": state,
        "postCode": postCode,
      };
}

class Communication {
  Communication({
    this.email,
    this.sms,
    this.phone,
  });

  bool email;
  bool sms;
  bool phone;

  factory Communication.fromJson(Map<String, dynamic> json) => Communication(
        email: json["email"],
        sms: json["sms"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "sms": sms,
        "phone": phone,
      };
}

class EmailSettings {
  EmailSettings({
    this.emailNotification,
    this.sendCopyToPersonalEmail,
    this.activityRelatesEmail,
    this.updatesFromKeenthemes,
  });

  bool emailNotification;
  bool sendCopyToPersonalEmail;
  ActivityRelatesEmail activityRelatesEmail;
  UpdatesFromKeenthemes updatesFromKeenthemes;

  factory EmailSettings.fromJson(Map<String, dynamic> json) => EmailSettings(
        emailNotification: json["emailNotification"],
        sendCopyToPersonalEmail: json["sendCopyToPersonalEmail"],
        activityRelatesEmail:
            ActivityRelatesEmail.fromJson(json["activityRelatesEmail"]),
        updatesFromKeenthemes:
            UpdatesFromKeenthemes.fromJson(json["updatesFromKeenthemes"]),
      );

  Map<String, dynamic> toJson() => {
        "emailNotification": emailNotification,
        "sendCopyToPersonalEmail": sendCopyToPersonalEmail,
        "activityRelatesEmail": activityRelatesEmail.toJson(),
        "updatesFromKeenthemes": updatesFromKeenthemes.toJson(),
      };
}

class ActivityRelatesEmail {
  ActivityRelatesEmail({
    this.youHaveNewNotifications,
    this.youAreSentADirectMessage,
    this.someoneAddsYouAsAsAConnection,
    this.uponNewOrder,
    this.newMembershipApproval,
    this.memberRegistration,
  });

  bool youHaveNewNotifications;
  bool youAreSentADirectMessage;
  bool someoneAddsYouAsAsAConnection;
  bool uponNewOrder;
  bool newMembershipApproval;
  bool memberRegistration;

  factory ActivityRelatesEmail.fromJson(Map<String, dynamic> json) =>
      ActivityRelatesEmail(
        youHaveNewNotifications: json["youHaveNewNotifications"],
        youAreSentADirectMessage: json["youAreSentADirectMessage"],
        someoneAddsYouAsAsAConnection: json["someoneAddsYouAsAsAConnection"],
        uponNewOrder: json["uponNewOrder"],
        newMembershipApproval: json["newMembershipApproval"],
        memberRegistration: json["memberRegistration"],
      );

  Map<String, dynamic> toJson() => {
        "youHaveNewNotifications": youHaveNewNotifications,
        "youAreSentADirectMessage": youAreSentADirectMessage,
        "someoneAddsYouAsAsAConnection": someoneAddsYouAsAsAConnection,
        "uponNewOrder": uponNewOrder,
        "newMembershipApproval": newMembershipApproval,
        "memberRegistration": memberRegistration,
      };
}

class UpdatesFromKeenthemes {
  UpdatesFromKeenthemes({
    this.newsAboutKeenthemesProductsAndFeatureUpdates,
    this.tipsOnGettingMoreOutOfKeen,
    this.thingsYouMissedSindeYouLastLoggedIntoKeen,
    this.newsAboutMetronicOnPartnerProductsAndOtherServices,
    this.tipsOnMetronicBusinessProducts,
  });

  bool newsAboutKeenthemesProductsAndFeatureUpdates;
  bool tipsOnGettingMoreOutOfKeen;
  bool thingsYouMissedSindeYouLastLoggedIntoKeen;
  bool newsAboutMetronicOnPartnerProductsAndOtherServices;
  bool tipsOnMetronicBusinessProducts;

  factory UpdatesFromKeenthemes.fromJson(Map<String, dynamic> json) =>
      UpdatesFromKeenthemes(
        newsAboutKeenthemesProductsAndFeatureUpdates:
            json["newsAboutKeenthemesProductsAndFeatureUpdates"],
        tipsOnGettingMoreOutOfKeen: json["tipsOnGettingMoreOutOfKeen"],
        thingsYouMissedSindeYouLastLoggedIntoKeen:
            json["thingsYouMissedSindeYouLastLoggedIntoKeen"],
        newsAboutMetronicOnPartnerProductsAndOtherServices:
            json["newsAboutMetronicOnPartnerProductsAndOtherServices"],
        tipsOnMetronicBusinessProducts: json["tipsOnMetronicBusinessProducts"],
      );

  Map<String, dynamic> toJson() => {
        "newsAboutKeenthemesProductsAndFeatureUpdates":
            newsAboutKeenthemesProductsAndFeatureUpdates,
        "tipsOnGettingMoreOutOfKeen": tipsOnGettingMoreOutOfKeen,
        "thingsYouMissedSindeYouLastLoggedIntoKeen":
            thingsYouMissedSindeYouLastLoggedIntoKeen,
        "newsAboutMetronicOnPartnerProductsAndOtherServices":
            newsAboutMetronicOnPartnerProductsAndOtherServices,
        "tipsOnMetronicBusinessProducts": tipsOnMetronicBusinessProducts,
      };
}

class SocialNetworks {
  SocialNetworks({
    this.linkedIn,
    this.facebook,
    this.twitter,
    this.instagram,
  });

  String linkedIn;
  String facebook;
  String twitter;
  String instagram;

  factory SocialNetworks.fromJson(Map<String, dynamic> json) => SocialNetworks(
        linkedIn: json["linkedIn"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "linkedIn": linkedIn,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
      };
}
