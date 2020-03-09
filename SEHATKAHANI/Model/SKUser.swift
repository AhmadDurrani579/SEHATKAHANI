//
//  SKUser.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 27/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import ObjectMapper
class SKUser: NSObject  ,Mappable {


    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kBCUserIDKey: String = "_id"
    internal let kBCPhoneKey: String = "phone"
    internal let kBCNameKey: String = "name"


     internal let kBCKey: String = "key"
     internal let kBEmailKey: String = "email"
    internal let kBCStateKey: String = "state"
    internal let kBWeightKey: String = "weight"
    internal let kBIsOnlineKey: String = "isOnline"
    internal let kBDoctorKey: String = "isDoctor"
    internal let kBPhotoKey: String = "photo"
    
    internal let kBAddressKey: String = "address"
    internal let kBCityKey: String = "city"
    internal let kBContactnoKey: String = "contactno"
//    internal let kBCounrtryKey: String = "country"
    internal let kBDobKey: String = "dob"
    internal let kBGenderKey: String = "gender"
    internal let kBMartialstatusKey: String = "martialstatus"
    internal let kBAvatarKey: String = "photo"




//    "state": "Punjab",
//    "weight": 99,
//    "updatedBy": "5a5dca737b4e5b3d4c4797ff",
//    "isOnline": "Offline",
//    "isPatient": true,

    open var id: String?
    open var phoneNumber: String?
    open var key: String?
    open var email: String?
    open var name: [String : Any]?
    open var userPhoto: [String : Any]?

    open var state: String?
    open var weight: String?
    open var isOnline: String?
    open var isDoctor: Bool?
    
    open var address: String?
    open var city: String?
    open var contactno: String?
//    open var country: String?
    open var dob: String?
    open var gender: String?
    open var martialstatus: String?
    open var avatarUrl: [String : Any]?
 
    required public init?(map: Map){

    }

    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    open func mapping(map: Map) {

        self.id <- map[kBCUserIDKey]
        self.phoneNumber <- map[kBCPhoneKey]
        self.name <- map[kBCNameKey]
        self.key <- map[kBCKey]
        self.email <- map[kBEmailKey]
        self.avatarUrl <- map[kBAvatarKey]


        self.address <- map[kBAddressKey]
        self.city <- map[kBCityKey]
        self.contactno <- map[kBContactnoKey]
//        self.country <- map[kBCounrtryKey]
        self.dob <- map[kBDobKey]
        self.gender <- map[kBGenderKey]
        self.martialstatus <- map[kBMartialstatusKey]

        self.state <- map[kBCStateKey]
        self.weight <- map[kBWeightKey]
        self.isOnline <- map[kBIsOnlineKey]
        self.isDoctor <- map[kBDoctorKey]
        self.userPhoto <- map[kBPhotoKey]
    }

    open func dictionaryRepresentation() -> [String : AnyObject] {

        var dictionary: [String : AnyObject ] = [ : ]
        if self.id != nil {
            dictionary.updateValue(self.id! as AnyObject, forKey: kBCUserIDKey)
        }
        if self.phoneNumber != nil {
            dictionary.updateValue(self.phoneNumber! as AnyObject, forKey: kBCPhoneKey)
        }
        if self.name != nil {
            dictionary.updateValue(self.name as AnyObject, forKey: kBCNameKey)
        }
        if self.userPhoto != nil {
            dictionary.updateValue(self.userPhoto as AnyObject, forKey: kBPhotoKey)
        }
        if self.key != nil {
            dictionary.updateValue(self.key as AnyObject, forKey: kBCKey)
        }
        if self.email != nil {
            dictionary.updateValue(self.email as AnyObject, forKey: kBEmailKey)
        }

        if self.state != nil {
            dictionary.updateValue(self.state as AnyObject, forKey: kBCStateKey)
        }
        if self.weight != nil {
            dictionary.updateValue(self.weight as AnyObject, forKey: kBWeightKey)
        }
        if self.isOnline != nil {
            dictionary.updateValue(self.isOnline as AnyObject, forKey: kBIsOnlineKey)
        }
        if self.isDoctor != nil {
            dictionary.updateValue(self.isDoctor as AnyObject, forKey: kBDoctorKey)
        }
        
        if self.address != nil {
            dictionary.updateValue(self.key as AnyObject, forKey: kBAddressKey)
        }
       
        if self.city != nil {
            dictionary.updateValue(self.email as AnyObject, forKey: kBCityKey)
        }
        if self.contactno != nil {
            dictionary.updateValue(self.state as AnyObject, forKey: kBContactnoKey)
        }
//        if self.country != nil {
//            dictionary.updateValue(self.weight as AnyObject, forKey: kBCounrtryKey)
//        }
        if self.dob != nil {
            dictionary.updateValue(self.isOnline as AnyObject, forKey: kBDobKey)
        }
        if self.gender != nil {
            dictionary.updateValue(self.isDoctor as AnyObject, forKey: kBGenderKey)
        }
        if self.martialstatus != nil {
            dictionary.updateValue(self.key as AnyObject, forKey: kBMartialstatusKey)
        }
        if self.avatarUrl != nil {
            dictionary.updateValue(self.avatarUrl as AnyObject, forKey: kBAvatarKey)
        }
        return dictionary;
    }
}
