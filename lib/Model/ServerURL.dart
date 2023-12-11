class ServerURL {
  // static String token = "http://122.182.18.201/CaretrakME/MApp/";
  static String token = "http://255.255.255.0/CaretrakME/MApp/";

  //  static String baseurl = "http://uat.yungtrepreneur.com/HCAPI/api/ExternalAPI/";
  static String baseurl =
      "http://lims.yungtrepreneur.com/HCAPI/api/ExternalAPI/";

  static String serviceDataURL =
      "http://lims.yungtrepreneur.com/HCAPI/api/ExternalAPI/GetServiceDetails?VenueNo=2&VenueBranchNo=2";

  // static String serviceDataURL = "http://uat.yungtrepreneur.com/HCAPI/api/ExternalAPI/GetServiceDetails?VenueNo=2&VenueBranchNo=2";
  getUrl(RequestType RequestTypes) {
    switch (RequestTypes) {
      case RequestType.Login:
        return baseurl + RequestType.Login.name;
      case RequestType.GetReferralDetails:
        return baseurl + RequestType.GetReferralDetails.name;
      case RequestType.token:
        return token + RequestType.token.name;
      case RequestType.LoadAppointment:
        return baseurl + RequestType.LoadAppointment.name;
      case RequestType.InsertBooking:
        return baseurl + RequestType.InsertBooking.name;
      case RequestType.GetServiceDetails:
        return baseurl + RequestType.GetServiceDetails.name;
      case RequestType.AddNewTest:
        return baseurl + RequestType.AddNewTest.name;
      case RequestType.DeleteServiceTest:
        return baseurl + RequestType.DeleteServiceTest.name;
      case RequestType.LocationUpdate:
        return baseurl + RequestType.LocationUpdate.name;
      case RequestType.UploadTrfImage:
        return baseurl + RequestType.UploadTrfImage.name;
      case RequestType.UploadPrescription:
        return baseurl + RequestType.UploadPrescription.name;
      case RequestType.GetSampleWiseService:
        return baseurl + RequestType.GetSampleWiseService.name;
      case RequestType.ValidatePrePrintedBarcode:
        return baseurl + RequestType.ValidatePrePrintedBarcode.name;
      case RequestType.InsertAppointmentAndRequest:
        return baseurl + RequestType.InsertAppointmentAndRequest.name;
      case RequestType.UpdatePatientStatus:
        return baseurl + RequestType.UpdatePatientStatus.name;
      case RequestType.ArchivePatientSearch:
        return baseurl + RequestType.ArchivePatientSearch.name;
      case RequestType.GetOnlinePaymentInfo:
        return baseurl + RequestType.GetOnlinePaymentInfo.name;
      case RequestType.InsertPayment:
        return baseurl + RequestType.InsertPayment.name;
      case RequestType.UpdateRiderStatus:
        return baseurl + RequestType.UpdateRiderStatus.name;
      case RequestType.SignOut:
        return baseurl + RequestType.SignOut.name;
      case RequestType.GetLiveLocation:
        return baseurl + RequestType.GetLiveLocation.name;
      case RequestType.GetArchivePatientDetails:
        return baseurl + RequestType.GetArchivePatientDetails.name;
      case RequestType.serviceData:
        return serviceDataURL;
    }
  }
}

enum RequestType {
  token,

  Login,

  LoadAppointment,

  InsertBooking,

  GetReferralDetails,

  GetServiceDetails,

  AddNewTest,

  DeleteServiceTest,

  LocationUpdate,

  UploadTrfImage,

  GetSampleWiseService,

  ValidatePrePrintedBarcode,

  InsertAppointmentAndRequest,

  UpdatePatientStatus,

  ArchivePatientSearch,

  GetOnlinePaymentInfo,

  InsertPayment,

  UpdateRiderStatus,

  SignOut,

  GetArchivePatientDetails,

  serviceData,

  UploadPrescription,
  GetLiveLocation
}
