//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit


enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case Allergy = 0,
    SurgicalHistory
}

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""


let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL

let BASE_URL  =  "https://stage.sehatkahani.com/api/"

var MYQuery: Bool = false

//let BASE_URL  =  "http://adadigbomma.com/"

//LOCAL URL
//let BASE_URL = "http://192.168.1.192/whereapp/api/"


//let API_KEY = "jIbF3yQG0s/AliunDtw3yYfH5w1mzOk5MaTeXIU5ORI="

//service URLS

let GETPatientPrescription = BASE_URL + "MobileApp/consultation/get_consultation_details"
let GETPatientADDNotes = BASE_URL + "MobileApp/consultation/add_notes"
let GETPatientADDSumary = BASE_URL + "MobileApp/consultation/add_summary"
let GETPatientADPrescription = BASE_URL + "MobileApp/consultation/add_prescription"
let GET_NEXT_APPOINTMENT_DOCTOR = BASE_URL + "MobileApp/appointment/next_appointment_doctor"



let GET_PendingAppointment = BASE_URL + "MobileApp/appointment/get_pending_appointment_doctor"
let GET_CancelAppointmentDoctor = BASE_URL + "MobileApp/appointment/cancelAppointment"
let GET_Summary = BASE_URL + "MobileApp/history/get_summary"
let GET_SummaryDoctor = BASE_URL + "MobileApp/consultation/get_consultation_doctor_names"
let GET_ConsultantDetail = BASE_URL + "MobileApp/consultation/get_consultation_details"
let GET_Treatment = BASE_URL + "MobileApp/history/get_treatment"
let GET_PastDisease = BASE_URL + "MobileApp/history/get_disease"
let GET_PHYSICAL_ACTIVITY = BASE_URL + "MobileApp/history/get_physical"
let GET_Family = BASE_URL + "MobileApp/history/get_family"
let GET_Medication = BASE_URL + "MobileApp/history/get_medication"
let GET_SOCIAL_ACTIVITIES = BASE_URL + "MobileApp/history/get_social"
let ConsultationPatient = BASE_URL + "MobileApp/consultation/get_consulted_consultation_patient"
let OtherConsultationPatient = BASE_URL + "MobileApp/consultation/get_other_consultation_patient"
let GETALLAppointmentDoctor = BASE_URL + "MobileApp/appointment/get_all_appointment_doctor"
let GETALLDOCTORPROFILE = BASE_URL + "MobileApp/profile/get_doctor_profile"
let GETALLPATIENTPROFILE = BASE_URL + "MobileApp/profile/get_patient_profile"

let UPDATE_PATIENT_PROFILE = BASE_URL + "MobileApp/profile/update_patient_profile"

let GET_ALLERGIES_LIST = BASE_URL + "MobileApp/history/get_allergy"
let ADD_ALLERGY = BASE_URL + "MobileApp/history/add_allergy"
let ADD_CURRENT_MEDICATION = BASE_URL + "MobileApp/history/add_medication"
let ADD_SOCIAL_ACTIVITY = BASE_URL + "MobileApp/history/add_social"
let ADD_PHYSICAL_ACTIVITY = BASE_URL + "MobileApp/history/add_physical"

let EDIT_ALLERGY = BASE_URL + "MobileApp/history/edit_allergy"
let EDIT_SURGICAL = BASE_URL + "MobileApp/history/edit_treatment"
let EDIT_IMMUNIZATION = BASE_URL + "MobileApp/history/edit_immunization"
let EDIT_PAST_DISEASE = BASE_URL + "MobileApp/history/edit_disease"
let EDIT_FAMILY = BASE_URL + "MobileApp/history/edit_family"
let EDIT_CURRENT_MEDICATION = BASE_URL + "MobileApp/history/edit_medication"
let EDIT_PHYSICAL_ACTIVITY = BASE_URL + "MobileApp/history/edit_activity"
let EDIT_SOCIAL_ACTIVITY = BASE_URL + "MobileApp/history/edit_activity"



let DELETE_ALLERGY = BASE_URL + "MobileApp/history/delete_allergy"
let DELETE_IMMUNIZATION = BASE_URL + "MobileApp/history/delete_immunization"
let DELETE_DISEASE = BASE_URL + "MobileApp/history/delete_disease"
let DELETE_SURGICAL = BASE_URL + "MobileApp/history/delete_treatment"
let DELETE_FAMILY = BASE_URL + "MobileApp/history/delete_family"

let DELETE_CURRENT_MEDICATION = BASE_URL + "MobileApp/history/delete_medication"
let DELETE_SOCIAL_ACTIVITY =  BASE_URL + "MobileApp/history/delete_activity"
let DELETE_PHYSICAL_ACTIVITY =  BASE_URL + "MobileApp/history/delete_activity"





let ADD_DISEASE = BASE_URL + "MobileApp/history/add_disease"
let ADD_SURGICAL_HISTORY = BASE_URL + "MobileApp/history/add_treatment"
let ADD_IMMUNIZATION = BASE_URL + "MobileApp/history/add_immunization"
let ADD_FAMILY = BASE_URL + "MobileApp/history/add_family"




let GETImmunization = BASE_URL + "MobileApp/history/get_immunization"
let GETSLotsPerDay = BASE_URL + "MobileApp/slots/get_slots_per_day"
let ADDNewSLot = BASE_URL + "MobileApp/slots/add_slots"


let GET_PATIENT_ALL_CONSULTATION = BASE_URL + "MobileApp/consultation/get_consulted_consultation_patient"
let GET_PATIENT_ALL_CONSULTATION_DET = BASE_URL + "MobileApp/consultation/get_other_consultation_patient"
let GET_PATINET_UPCOMMING_APPOINTMENTS = BASE_URL + "MobileApp/appointment/get_pending_appointment_patient"
let GET_PAINT_MISSED_APPOINTMENTS = BASE_URL + "MobileApp/appointment/get_all_appointment_patient"

let VIEW_DOCTOR_PROFILE = BASE_URL + "MobileApp/appointment/view_doctor"

let ADD_TO_FAVOURITE = BASE_URL + "MobileApp/favourite/add_favourite_doctor"
let REMOVE_FROM_FAVOURITES = BASE_URL + "MobileApp/favourite/remove_favourite_doctor"
let IS_FAVOURITES = BASE_URL + "MobileApp/favourite/check_favourite_doctor"


let GET_APPOINTMENT = BASE_URL + "userAppointments"

let FORUM_GET_GUERY = BASE_URL + "MobileApp/forum/get_query"
let FORUM_GET_MY_GUERY = BASE_URL + "MobileApp/forum/get_my_query"
let FORUM_ASK_GUERY =  BASE_URL + "MobileApp/forum/ask_query"

let SIGNIN_WITH_GOOGLE = BASE_URL + "MobileApp/session/user_signin_google"
let SIGNIN_WITH_FACEBOOK = BASE_URL + "MobileApp/session/user_signin_facebook"

let SIGNIN_WITH_GOOGLE_AS_A_DOCTOR = BASE_URL + "MobileApp/session/user_signup_google_doctor"
let SIGNUP_WITH_GOOGLE =  BASE_URL +  "MobileApp/session/user_signup_google_patient"

let SIGNUP_WITH_FACEBOOK = BASE_URL + "MobileApp/session/user_signup_facebook_doctor"
let SIGNUP_WITH_FACRBOOK_AS_A_PATIENT = BASE_URL + "MobileApp/session/user_signup_facebook_patient"






let GETContestantDetail = BASE_URL + "App/getDetail"
let GETContestTantVideos = BASE_URL + "App/getvideos"
let FORGOT_Password = BASE_URL + "forgotpassword"
let CODE_SEND = BASE_URL + "verifycode"
let RESET_PASSWORD = BASE_URL + "resetpassword"



let GETContestTantPhotos = BASE_URL + "App/getphotos"
let GETMediaPhotosAndVideo = BASE_URL + "App/getmedia"
let GETVote = BASE_URL + "App/vote"
let PULLTHEVOTE = BASE_URL + "App/voteher"

let GETSOcial = BASE_URL + "App/getsocial"
let SOCIAL_LOGIN = BASE_URL + "sociallogin"
let ADIM_NEWS   = BASE_URL + "App/news"
let ADIM_TEAM   = BASE_URL + "App/team"
let ADIM_TV   = BASE_URL + "App/adimtv"




let VIDEO_SEEN = BASE_URL + "post_seen"
let NEW_POST = BASE_URL + "new_post"
let RESPOND_POST = BASE_URL + "respondPost"
let PROFILE = BASE_URL + "getProfile"
let MY_POSTS_RESPONSE = BASE_URL + "myPosts"
let UPDATE_PROFILE = BASE_URL + "updateProfile"
let UPDATE_PASSWORD = BASE_URL + "updatePassword"
let SAVE_PURCHASE = BASE_URL + "savePurchase"
let POST_HANDSHAKE = BASE_URL + "postHandShake"
let GET_CAT = BASE_URL + "getCategories"
let GET_USER_BUSINESS = BASE_URL + "getUserBusiness"
let ADD_NEW_BUSINESS = BASE_URL + "addNewBusiness"
let EDIT_USER_BUSINESS = BASE_URL + "editUserBusiness"
let ADD_SCHEDULE = BASE_URL + "addNewSchedule"
let GET_PROFILE = BASE_URL + "getProfile"
let EDIT_SCHEDULE = BASE_URL + "editSchedule"
let POST_COMMENT = BASE_URL + "postComment"
let GET_COMMENTS = BASE_URL + "getBusinessComments"
let DELETE_SCHEDULE = BASE_URL + "deleteSchedule"
let ENABLE_SCHEDULE = BASE_URL + "enableSchedule"
let UPLOAD_GALLERY = BASE_URL + "uploadGallery"
let DELETE_GALLERY = BASE_URL + "deleteGallery"
let RESETCODE = BASE_URL + "checkResetCode"
let Logout = BASE_URL  + "logout"
let ChnagePassword  = BASE_URL + "changePassword"



//var localUserData: UserData!
//var notificationType = "none"


let kUserNameRequiredLength: Int = 4
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 6
let KValidationPassword : String = "Password must be greater 6 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kUpdateTokenMessage: String = "user does not exists"



