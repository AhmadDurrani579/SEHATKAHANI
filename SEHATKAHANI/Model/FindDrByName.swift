//
//  FindDrByName.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 19/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

struct DrByName: Decodable {
    var success : Bool?
    var result : [DrByNameResults]
}

struct DrByNameResults: Decodable {
    var _id : String?
//    var UserId: DoctorBData1
    var doctor: DoctorData
    var email : String?
    var isOnline : String?
    var name: DrName
    var photo: DrPhoto
   
}
struct DrName: Decodable {
    var first : String?
    var last : String?
}
struct DrPhoto: Decodable {
    var url : String?
}
struct DoctorData: Decodable {
    var speciality : String?
    var UserId : String?
    var experience : String?
    var experiencemonths : String?
}


struct Consultation: Decodable {
    var success : Bool?
    var consul : String?
    var message : String?

}

struct DBName: Decodable {
    var success : Bool?
    var result : [DBNameResults1]
}

struct DBNameFindByName: Decodable {
    var success : Bool?
    var result : [DBNameFindByNameDBResult]
}
struct DBNameFindByNameDBResult: Decodable {

     var doctor : DoctorDetail
     var name: DrName
     var photo: DrPhoto
     var key : String?
     var _id : String?
     var email : String?
     var address : String?
     var city : String?
     var contactno : String?
     var country : String?
     var dob : String?
     var gender : String?
     var martialstatus : String?
     var DeviceAccessToken : String?
     var isOnline : String?
     var isPatient : Bool?
     var isDoctor : Bool?
     var url : String?
     var public_id : String?


}
struct DoctorDetail: Decodable {
    
    var key : String?
    var slug : String?
    var email : String?
    var speciality : String?
    var experience : String?
    var experiencemonths : String?
    var degree : String?
    var awards : String?
    var workaddress : String?
    var workno : String?
    var workplace : String?
    var timeslot : String?
     init?(timeslot: String) {
        self.timeslot = timeslot
    }
    var fee1 : String?
    init?(fee1: String) {
        self.fee1 = fee1
    }
    var isPublic : Bool?
    init?(isPublic: Bool) {
        self.isPublic = isPublic
    }
}

struct DBNameResults1: Decodable {
    var _id : String?
    var speciality : String?
    var UserId: DoctorBData1
    var email : String?
    var isOnline : String?
    var ConsultationId : String?

    var experience : String?
    var experiencemonths : String?
    
}
struct DBName1: Decodable {
    var first : String?
    var last : String?
}
struct DBPhoto1: Decodable {
    var url : String?
}
struct DoctorBData1: Decodable {
    var isOnline : String?
    var _id : String?
    var key : String?
    var photo: DBPhoto1
    var name: DBName1
}



class FindDrByName: NSObject {
    
    
    func getDrbyname(url: String, parameterDictionary: [String: Any],  completion: @escaping (DrByName) -> ()) {
        APIManager.sharedInstance.showHud()
        let Url = String(format: APIManager.sharedInstance.baseUrl+url)
        APIManager.sharedInstance.hideHud()
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        
        let configuration : URLSessionConfiguration = URLSessionConfiguration.default
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        
        

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        APIManager.sharedInstance.showHud()
        let session : URLSession   = URLSession.init(configuration: configuration)
        session.dataTask(with: request) { (data, response, error) in
            APIManager.sharedInstance.hideHud()
            var activity: DrByName!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(DrByName.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    
    func getConsultation(url: String, parameterDictionary: [String: Any],  completion: @escaping (Consultation) -> ()) {
        
        let Url = String(format:url)
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        
        let configuration : URLSessionConfiguration = URLSessionConfiguration.default
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        APIManager.sharedInstance.showHud()
        let session : URLSession   = URLSession.init(configuration: configuration)
        session.dataTask(with: request) { (data, response, error) in
             APIManager.sharedInstance.showHud()
            var activity: Consultation!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(Consultation.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    

    func getDrbySpeciality(url: String, parameterDictionary: [String: Any],  completion: @escaping (DBName) -> ()) {
        
       
        let Url = String(format: APIManager.sharedInstance.baseUrl+url)
       
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ios App", forHTTPHeaderField: "User-Agent")
        request.httpShouldHandleCookies = false
        
        let configuration : URLSessionConfiguration = URLSessionConfiguration.default
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never

        let session : URLSession   = URLSession.init(configuration: configuration)
        
    
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
//        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            var activity: DBName!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            do {
                let courses = try JSONDecoder().decode(DBName.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
}






















