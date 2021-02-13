//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit



  struct setBoarder {
    let view : UIView?
    let width : CGFloat?
    let color : UIColor?
    
    @discardableResult  init(view: UIView, width: CGFloat , color : UIColor ) {
        self.view = view
        self.width  = width
        self.color  = color
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
        
        

    }
}

enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case TQLogin = 0,
    TQSignup,
    TQForgetPassword ,
    TQSkip
}

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""
var SELECTUSER = ""

let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL

let APPID  =  "9B701345-7241-41B8-8FE6-ADF7A6854B6E"



//  API Contant

let BASE_URL  =  "http://3.135.160.209/"
let ROOT_URLFORSOCKET = "http://3.135.160.209:3000"; // DEV SERVER

let SIGNUP = BASE_URL + "signup/register"
let LOGIN = BASE_URL + "signup/login"
let FORGOTPASSWORD =  BASE_URL + "signup/forgot"
let CHECKCODE =  BASE_URL + "signup/checkcode"
let UPDATEPASSWORD = BASE_URL + "signup/resetpassword"
let CHANGEPASSWORD = BASE_URL + "userapi/changepasswordupdate"


let ADDINTEREST = BASE_URL + "interest/plusinterest"
let ALLINTEREST = BASE_URL + "interest/interests"
let UPDATEINTEREST = BASE_URL + "interest/update"
let HEALTHGOAL = BASE_URL + "userapi/healthgoal"
let GETALLUSERDETAIL = BASE_URL + "userapi/user"
let ADDFOODTODAY = BASE_URL + "userapi/foodtoday"
let ADDKITCHEN = BASE_URL + "userapi/kitchen"
let ADDEXERCISE = BASE_URL + "userapi/updateexercise"
let FEELINGTODAY = BASE_URL + "userapi/feelingtoday"
let WATERTODAY = BASE_URL + "userapi/watertoday"
let HEALTGOAL = BASE_URL + "userapi/goalupdate"
let RELATIONSHIP = BASE_URL + "userapi/relationship"
let MEDICALINFORMATION = BASE_URL + "userapi/medicalinformation"
let USERHEALTHINFO = BASE_URL + "userapi/userhealths"
let ADDSLEEP = BASE_URL + "userapi/sleep"
let GETKITCHEN = BASE_URL + "userapi/getkitchen"

let GETFOOD = BASE_URL + "userapi/getfood"
let PROFILEUPDATE = BASE_URL + "userapi/userpicture"
let DELTEITEM = BASE_URL + "userapi/deletedata"
let UPDATEPROFILE = BASE_URL + "userapi/updateprofile"
let GETEXERCISE = BASE_URL + "userapi/getexercise"
let HEALTHINFOUPDATE = BASE_URL + "userapi/healthinformation"
let DELETEACCOUNT = BASE_URL + "userapi/deleteAccount"
let GETWATER = BASE_URL + "userapi/getwater"
let SUBSCRIBE = BASE_URL + "userapi/subscribe"
let GET_APPOINTMENT = BASE_URL + "sync/getAppointments"
let DO_APPOINTMENT = BASE_URL + "sync/doAppointments"
let COACH_PROFILE = BASE_URL + "userapi/coachprofile"
let PACKAGES = BASE_URL + "userapi/package"
let COACHSLOT = BASE_URL + "userapi/getCoachSlot"
let FAQ = BASE_URL + "userapi/faqs"
let ALLNotification = BASE_URL + "userapi/getAllNotification"
let UPDATEAPPOINTMENT = BASE_URL + "userapi/updateappointment"



let UPLOADPICTURE = BASE_URL + "userapi/uploadpicture"













//weak var localUserData: UserInformation!


let kUserNameRequiredLength: Int = 3
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 6
let kUserNameRequiredLengthForPhone: Int = 9
let kValidationMessageMissingInputPhone : String = "Please give the proper phone Number"

let KValidationPassword : String = "Password must be greater 2 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kValidationEmailEmpty : String = "email can't be blank"
let kValidationPasswordEmpty : String = "Password can't be blank"
let kValidationPhoneNumEmpty : String = "Phone Number can't be blank"

let kUpdateTokenMessage: String = "user does not exists"
let KMessageTitle: String = "Health Care"
let KChoseCategory: String = "Choose Category"

let CURRENT_DEVICE = UIDevice.current
let KIDNumberValidat : String = "Id Number can't be blank"
let KIMAGeSELECT : String = "Please Select the image"

let kValidationNameInput: String = "Please Enter the first  name"
let kValidationNameInputCharacter : String = "First Name must be alphabet characters.\n"
let kValidationConfirmPasswordEmpty : String = "Confirm Password can't be blank"
let KPasswordMismatch : String = "Password mismatch"



let kValidationCardNumInput: String = "Card Number can't be blank"
let kValidationCardHolderNameInput: String = "Card Holder Name can't be blank"
let kValidationCardHolderNameInputCharacter : String = "Card Holder Name must be alphabet characters.\n"
let kValidationCardExpiryDate : String = "Expiry date can't be blank"
let kValidationCardCcvNum : String = "Ccv Number  can't be blank"
weak var localUserData: UserObjectInfo!



let MAIN                           = UIStoryboard(name: "Main", bundle: nil)
let HOME                           = UIStoryboard(name: "Home", bundle: nil)


struct VCIdentifier {
//   User ViewControllers
    static let KINTOVC = "BLIntoViewController"
    static let kForgotPasswordController = "GSForgotPasswordVC"
    static let KHCLogin = "HCLoginVC"
    static let KDMSIGNUPSelection = "GSSignUpSelectionVC"
    static let KDashboardVC = "HCDashboardVC"
    static let KHCCHATLISt = "HCChatListVC"
    static let KHCInterentListVC = "HCInterestListVC"
    static let KHCSelectGOal = "HCSelectGoalVC"
    static let KHCSTARTVC = "HCStartVC"
    static let NEXTPAGER = "HCNextPagerVC"

    
    
    
//    static let kEmployeeChatVC = "EmployeeChatViewController"
//    static let kEmployeeEditProfile = "EmployeeEditProfile"
//    static let kEmployeeNotification = "EmployeeNotification"
}



//

let kUserId                 : String = "user_id"
let kFirstName              : String = "firstname"
let kLastName               : String = "lastname"
let KFullName               : String = "fullname"
let KPhoneNum               : String = "phoneNumber"

let kEmail                  : String = "email"
let kPassword               : String = "password"

let kConfirmPassword        : String = "confirmPassword"
let KNewPassword               : String = "newPassword"
let KIdNumver               : String = "idNumber"

let KType                   : String  = "type"
let KCategory                   : String  = "category"
let KCountry                 : String  = "country"
let KCity                : String  = "city"
let KCompany                : String  = "company"



let KCODE                    : String = "code"
let KRESENTCODE              : String = "code"

let kSocialId               : String = "social_id"
let kProfileImage           : String = "profile_image"
let kSignupType             : String = "signup_type"
let kLatitude               : String = "latitute"
let kLongitude              : String = "longitude"
let kDevice                  : String = "device"
let KDeviceID                  : String = "deviceid"



let kDeviceTOken              : String = "deviceToken"
let KImageFileName                : String = "profilePicture.png"
let KImagePropertyName                : String = "propertyPicture.png"



let KImageParam                : String = "profilePicture"



let KADDRESS              : String = "address"

let KImageIDCARDName               : String = "idNumberPicture.png"
let KImageIDCardParam                : String = "idNumberPicture"

let KDeviceType                  : String = "iOS"
let KProductName                 : String  = "productName"
let KProductCategory                 : String  = "productCategory"
let KProductAddress                : String  = "productLocalisation"
let KProductDescription                 : String  = "productDescription"
let KProductPrice                 : String  = "productPrice"
let KProductImage                 : String  = "productImages"
let KProductID                 : String  = "productId"
let KSentOfferPrice                : String  = "price"

let KProductfavourite                 : String  = "favourite"
let KFavouriteBadge                 : String  = "Badge"
let KFavouriteCount                : String  = "favouriteItemCount"
let KExpiryDate                : String  = "userCardExpiry"
let KCardHolderName                : String  = "userCardHolderName"
let KUserCardNumber                : String  = "userCardNumber"
let KCardCVVNum                : String  = "userCardCsv"
let KOfferSENT                : String  = "offerSent"
let KUPDATEPROFILE                : String  = "updateProfile"

let KACCEPTOFFER                : String  = "acceptOffer"
let KREJECTOFFER                : String  = "rejectOffer"
let KNEWOFFER                : String  = "newOffer"

let KStatus                : String  = "status"
let KOfferSendUserId                : String  = "offerSenderUserId"

let KOFFERId                 : String  = "offerId"
let KCONFIRMATIONMESSAGE                 : String  = "Garage Sale is working with Services  provider to confirm your Order "




