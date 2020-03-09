//
//  SKAppointment.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import ObjectMapper
class SKAppointment: NSObject , Mappable{


    internal let KPatientID: String = "PatientId"
    internal let KDoctorId: String = "DoctorId"
    internal let KAppointmetnTime: String = "AppointmentTime"
    internal let KAppointmetnEndTime: String = "AppointmentEndTime"
    internal let KCOnsultantId: String = "ConsultationId"
    internal let KDescription: String = "Description"



    open var PatientId: String?
     open var DoctorId: String?

    open var AppointmentTime: String?
    open var AppointmentEndTime: String?
    open var ConsultationId: String?
    open var Description: String?


    required public init?(map: Map){

    }

    open func mapping(map: Map) {



         self.PatientId <- map[KPatientID]
         self.DoctorId <- map[KDoctorId]
         self.AppointmentTime <- map[KAppointmetnTime]
         self.AppointmentEndTime <- map[KAppointmetnEndTime]
         self.ConsultationId <- map[KCOnsultantId]
         self.Description <- map[KDescription]


    }

    open func dictionaryRepresentation() -> [String : AnyObject] {

        var dictionary: [String : AnyObject ] = [ : ]

        if self.PatientId != nil {
            dictionary.updateValue(self.PatientId! as AnyObject, forKey: KPatientID)
        }
        if self.DoctorId != nil {
            dictionary.updateValue(self.DoctorId! as AnyObject, forKey: KDoctorId)
        }
        if self.AppointmentTime != nil {
            dictionary.updateValue(self.AppointmentTime! as AnyObject, forKey: KAppointmetnTime)
        }
        if self.AppointmentEndTime != nil {
            dictionary.updateValue(self.AppointmentEndTime! as AnyObject, forKey: KAppointmetnEndTime)
        }
        if self.ConsultationId != nil {
            dictionary.updateValue(self.ConsultationId! as AnyObject, forKey: KCOnsultantId)
        }
        if self.Description != nil {
            dictionary.updateValue(self.Description! as AnyObject, forKey: KDescription)
        }
        return dictionary;
    }



    

}
