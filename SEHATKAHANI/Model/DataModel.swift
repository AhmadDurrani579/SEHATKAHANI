//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class GetPendingAppointment : Mappable {
    var success     : Bool?
    var result      : [GetPendingAppointmentObject]?
    var message     : String?
    var custom_response : [GetPendingAppointmentObject]?
    var customResponseObject : GetPendingAppointmentObject?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
        message <- map["message"]
        custom_response <- map["custom_response"]
        customResponseObject <- map["custom_response"]
    }
}

class GetPendingAppointmentObject : Mappable {
    var idOfDoctorOrPatient : String?
    var key : String?
    var timeslotId : String?
    var descriptionofAppointment : String?
    var appointmentTime : String?
    var appointmentEndTime : String?
    var appointmentDate : String?
    var startTime : String?
    var endTime : String?
    var Date : String?
    var Status: String?
    var patientId:    PatientId?
    var doctorID:    PatientId?
    var id : String?
    
    var user : User?
    var appointment_id : String?
    var consultation_id : String?
    var consultationId : String?
    var slot_id : String?
    var description : String?
    var status : String?
    var request_time: String?
    var appointment_start_time : String?
    var appointment_end_time : String?
    var AppointmentDate : String?
    
    var start_time: String?
    var end_time : String?
    var date_of : String?
//    var consultation_id : String?
  
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        idOfDoctorOrPatient <- map["_id"]
        key <- map["key"]
        timeslotId <- map["_id"]
        appointmentTime <- map["AppointmentTime"]
        appointmentEndTime <- map["AppointmentEndTime"]
        appointmentDate <- map["AppointmentDate"]
        descriptionofAppointment <- map["Description"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        Date <- map["Date"]
        Status <- map["Status"]
        patientId <- map["PatientId"]
        doctorID <- map["DoctorId"]
        
         user  <- map["user"]
         appointment_id   <- map["appointment_id"]
         consultation_id  <- map["consultation_id"]
         consultationId  <- map["ConsultationId"]
         slot_id   <- map["slot_id"]
         description   <- map["description"]
         status   <- map["status"]
         request_time <- map["request_time"]
         appointment_start_time  <- map["appointment_start_time"]
         appointment_end_time   <- map["appointment_end_time"]
         AppointmentDate   <- map["AppointmentDate"]
        
        start_time  <- map["start_time"]
        end_time   <- map["end_time"]
        date_of   <- map["date_of"]
        id   <- map["_id"]
        
        
    }
}


class User: Mappable {
    var user_id          : String?
    var photo_url        : String?
    var first_name       : String?
    var last_name        : String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        photo_url <- map["photo_url"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
    }
}




class PatientId : Mappable {
    var id : String?
    var patientKey : String?
    var email : String?
    var contactno : String?
    var dob : String?
    var gender : String?
    var height : String?
    var weight : Int?
    var martialstatus  : String?
    var bloodGroup : String?
    var patientPhotos:    PatientPhoto?
    var patientName:    PatientName?

    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        patientKey <- map["key"]
        email <- map["email"]
        contactno <- map["contactno"]
        dob <- map["dob"]
        gender <- map["gender"]
        height <- map["height"]
        martialstatus <- map["martialstatus"]
        weight <- map["weight"]
        patientPhotos <- map["photo"]
        patientName <- map["name"]
        bloodGroup <- map["bloodgroup"]
        id <- map["_id"]

    }
}


class PatientPhoto : Mappable {
    var secureUrl : String?
    var url : String?
    required init?(map: Map){
  
    }
    func mapping(map: Map) {
        secureUrl <- map["secure_url"]
        url <- map["url"]
    }
    
    
}

class PatientName : Mappable {
    var first : String?
    var last : String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        first <- map["first"]
        last <- map["last"]
    }
  
}

class  PatientSummary : Mappable {
    var success     : Bool?
    var result      : [PatientSummaryObject]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
    }
}

class PatientSummaryObject : Mappable {
    var name : String?
    var consultantionId : String?
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        name <- map["name"]
        consultantionId <- map["conId"]
    }
        
}

class GetPastDisease: Mappable {
    var success     : Bool?
    var allDisease : [GetPastDiseaseObject]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        allDisease <- map["result"]
        
    }
}

class GetPastDiseaseObject : Mappable {
    var Treatment : Bool?
    var Response : String?
    var PatientId : String?
    var Disease : String?
    var key : String?
    var _id : String?
    var Relation : String?
    var Comments  : String?
    var Dosage : String?
    var Name : String?

    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        Treatment <- map["Treatment"]
        Response <- map["Response"]
        PatientId <- map["PatientId"]
        Disease <- map["Disease"]
        key <- map["key"]
        _id <- map["_id"]
        Relation <- map["Relation"]
        Comments <- map["Comments"]
        Dosage <- map["Dosage"]
        Name <- map["Name"]

        
        
    }
    
}
class GetImmunization: Mappable {
    var success     : Bool?
    var immunization : [GetImmunizationObject]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        immunization <- map["result"]
        
    }
}


class GetImmunizationObject : Mappable {
    var Booster : Bool?
    var Boosterfrequency : String?
    var Boostertype : String?
    var key : String?
    var PatientId : String?
    var Response : String?
    var Vaccination : String?
    var idOfImunization : String?
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        Booster <- map["Booster"]
        Boosterfrequency <- map["Boosterfrequency"]
        Boostertype <- map["Boostertype"]
        key <- map["key"]
        PatientId <- map["PatientId"]
        Response <- map["Response"]
        Vaccination <- map["Vaccination"]
        idOfImunization <- map["_id"]
        
        
        
    }
    
}


class GetAllergy: Mappable {
    
    var success     : Bool?
    var allergy : [GetAllAllergyObject]?
    var result  : [GetAllAllergyObject]?
    var treatment : [GetAllAllergyObject]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        allergy <- map["prescription"]
        treatment <- map["result"]
        
    }
}

class GetAlleryObject : Mappable {
    var idOfPatient : String?
    var key : String?
    var Notes : String?
    var Reaction : String?
    var type : String?
    var type1 : String?
    var PatientId : String?
    var Response : String?
    var reason : String?
    var dateOfSurger : String?
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        idOfPatient <- map["_id"]
        key <- map["key"]
        Notes <- map["Notes"]
        Reaction <- map["Reaction"]
        type <- map["Type"]
        type1 <- map["type"]
        PatientId <- map["PatientId"]
        Response <- map["Response"]
        reason <- map["Reason"]
        dateOfSurger <- map["dateofsurgery"]
        
        
        
    }
    
}

class GetAllAllergyObject : Mappable {
    var idOfPatient : String?
    var key : String?
    var Notes : String?
    var Reaction : String?
    var type : String?
    var type1: String?
    var PatientId : String?
    var Response : String?
    var reason : String?
    var dateOfSurger : String?
    var comments: String?
    var name: String?
    var dosage: String?
    var Frequency: String?
    var disease: String?
    var relation: String?

    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        idOfPatient <- map["_id"]
        key <- map["key"]
        Notes <- map["Notes"]
        Reaction <- map["Reaction"]
        type <- map["Type"]
        type1 <- map["type"]
        PatientId <- map["PatientId"]
        Response <- map["Response"]
        reason <- map["Reason"]
        dateOfSurger <- map["dateofsurgery"]
        comments <- map["Comments"]
        name <- map["Name"]
        dosage <- map["Dosage"]
        Frequency <- map["Frequency"]
        disease <- map["Disease"]
        relation <- map["Relation"]
    }
    
}



class  ConsultationDetail : Mappable {
    var success     : Bool?
    var consultation      : ConsultationObject?
    var presCription : [PrescriptionObject]?
    var message: String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        consultation <- map["consultation"]
        presCription <- map["prescription"]
        message <- map["message"]
        
    }
}



class ConsultationObject : Mappable {
    var _id : String?
    var updatedAt : String?
    var createdAt : String?
    var key : String?
    var PatientId : String?
    var DoctorId : String?
    var Description : String?
    var Status : String?
    var endTime : String?
    var allowview : Bool?
    var Date : String?
    var Notes : String?
    var Summary : String?


    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        updatedAt <- map["updatedAt"]
        createdAt <- map["createdAt"]
        key <- map["key"]
        PatientId <- map["PatientId"]
        DoctorId <- map["DoctorId"]
        Description <- map["Description"]
        Status <- map["Status"]
        endTime <- map["endTime"]
        allowview <- map["allowview"]
        Date <- map["Date"]
        Notes <- map["Notes"]
        Summary <- map["Summary"]
    }
}

class PrescriptionObject : Mappable {
    var _id : String?
    var key : String?
    var consultationId : String?
    var PatientId : String?
    var DoctorId : String?
    var drugName : String?
    var dosage : String?
    var note : String?
    
    
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        consultationId <- map["consultationId"]
        PatientId <- map["PatientId"]
        DoctorId <- map["DoctorId"]
        drugName <- map["drugName"]
        dosage <- map["dosage"]
        note <- map["note"]
        
    }
    
}


class GetDoctorInfo   : Mappable {
    var success       : Bool?
    var userInfo      : UserProfileObject?
    var doctorInfo    : DoctorProfileObject?
    var user          : UserProfileObject?
    var message       : String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        userInfo <- map["User"]
        doctorInfo <- map["Doctor"]
        message <- map["message"]
        
    }
}



class ForumQuries   : Mappable {
    var success       : Bool?
    var result      : [UserProfileObject]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
        
    }
}


class UserProfileObject : Mappable {
    var _id : String?
    var key : String?
    var email : String?
    var gender : String?
    var height : String?
    var martialstatus : String?
    var city : String?
    var contactno : String?
    var contactno2 : String?
    var country : String?
    var dob : String?
    var state : String?
    var address : String?
    var patientPhotos:    PatientPhoto?
    var name : PatientName?
    var userId : ForumUserId?
    var question : String?
    var Category : String?
    var count: Int?
    var data: String?
    var weight : Int?
    var bloodgroup : String?
    
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        email <- map["email"]
        gender <- map["gender"]
        height <- map["height"]
        martialstatus <- map["martialstatus"]
        city <- map["city"]
        contactno <- map["contactno"]
        contactno2 <- map["contactno2"]
        country <- map["country"]
        dob <- map["dob"]
        state <- map["state"]
        address <- map["address"]
        patientPhotos <- map["photo"]
        name     <- map["name"]
        userId     <- map["UserId"]
        question <- map["Question"]
        Category <- map["Category"]
        count <- map["count"]
        data <- map["Date"]
        weight <- map["weight"]
        bloodgroup <- map["bloodgroup"]
    }
    
}




class ForumUserId : Mappable {
    var _id : String?
    var key : String?
    var patientPhotos:    PatientPhoto?
    var name : PatientName?
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        patientPhotos <- map["photo"]
        name     <- map["name"]
        
    }
    
}






class DoctorProfileObject : Mappable {
    var _id : String?
    var key : String?
    var consultationId : String?
    var PatientId : String?
    var DoctorId : String?
    var drugName : String?
    var dosage : String?
    var note : String?
    
    
    
    required init?(map: Map){
        //
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        consultationId <- map["consultationId"]
        PatientId <- map["PatientId"]
        DoctorId <- map["DoctorId"]
        drugName <- map["drugName"]
        dosage <- map["dosage"]
        note <- map["note"]
        
    }
    
}



class GetAllDoctorSlot: Mappable {
    var success     : Bool?
    var allSlot : [GetAllDoctorSlotObject]?
    var message     : String?
    var user: [String: AnyObject]?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        allSlot <- map["result"]
        message     <- map["message"]
        user <- map["user"]
 
    }
}

class GetAllDoctorSlotObject : Mappable {
    var _id : String?
    var key : String?
    var DoctorId : String?
    var status : String?
    var timestart : String?
    var timeend : String?
    var day  : String?
    var dateoftime : String?
    
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        DoctorId <- map["DoctorId"]
        status <- map["status"]
        timestart <- map["timestart"]
        timeend <- map["timeend"]
        day <- map["day"]
        dateoftime <- map["dateoftime"]
        
        
        
    }
    
}


class GetDoctorProfileResult: Mappable {
    var _id     : String?
    var key : String?
    var doctor  : GetDoctorProfileDoctor?
    var email: String?
    var address: String?
    var city : String?
    var contactno : String?
    var country: String?
    var dob     : String?
    var gender: String?
    var martialstatus: String?
    var state : String?
    var contactno2 : String?
    var isOnline: String?
    var isPatient : String?
    var isDoctor: String?
    var photo: PatientPhoto?
    var name : PatientName?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        doctor     <- map["doctor"]
        email <- map["email"]
        address <- map["address"]
        city     <- map["city"]
        contactno <- map["contactno"]
        country <- map["country"]
        dob     <- map["dob"]
        gender <- map["gender"]
        martialstatus <- map["martialstatus"]
        state     <- map["state"]
        contactno2 <- map["contactno2"]
        isOnline <- map["isOnline"]
        isPatient     <- map["isPatient"]
        isDoctor <- map["isDoctor"]
        photo <- map["photo"]
        name     <- map["name"]
    }
}




class GetDoctorProfile: Mappable {
    var success     : Bool?
    var result :  GetDoctorProfileResult?
    var message     : String?
    var favourite   : Bool?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        result <- map["result"]
        message     <- map["message"]
        favourite <- map["favourite"]
    }
}


class GetDoctorProfileDoctor: Mappable {
    var _id     : String?
    var email : String?
    var speciality  : String?
    var medno: String?
    var UserId: String?
    var experience : String?
    var experiencemonths : String?
    var degree: String?
    
    var awards     : String?
    var workaddress: String?
    var workno: String?
    var workplace : String?
    var fee2 : String?
    var fee1: String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        _id <- map["_id"]
        email <- map["email"]
        speciality     <- map["speciality"]
        medno <- map["medno"]
        UserId <- map["UserId"]
        experience     <- map["experience"]
        experiencemonths <- map["experiencemonths"]
        degree <- map["degree"]
        awards     <- map["awards"]
        workaddress <- map["workaddress"]
        workno <- map["workno"]
        workplace     <- map["workplace"]
        fee2 <- map["fee2"]
        fee2     <- map["fee2"]
    }
}


























