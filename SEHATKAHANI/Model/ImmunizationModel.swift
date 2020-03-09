//
//  ImmunizationModel.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
struct AllImmunization: Decodable {
    var success : Bool?
    var result : [ImmunizationResult]
}

struct SingleImmunization: Decodable {
    var success : Bool?
    var result : ImmunizationResult
}

struct ImmunizationResult: Decodable {
    var __v: Int?
    var key: String?
    var Boosterfrequency: String?
    var Boostertype: String?
    var Vaccination: String?
    var Booster: Bool?
    var PatientId: String?
    var Response: String?
    var _id: String?
}



class ImmunizationModel : NSObject {
    
    func addImmunization(parameterDictionary: [String: Any],  completion: @escaping (SingleImmunization) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_immunization")
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            var activity: SingleImmunization!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(SingleImmunization.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    
    func allImmunization(parameterDictionary: [String: Any],  completion: @escaping (AllImmunization) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_immunization")
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            var allActivities: AllImmunization!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(AllImmunization.self, from: data!)
                print(courses)
                allActivities = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(allActivities)
            }.resume()
    }
    
}
