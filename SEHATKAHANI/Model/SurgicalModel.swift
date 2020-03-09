//
//  SurgicalModel.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

struct AllSurgaries: Decodable {
    var success : Bool?
    var result : [SurgeryResult]
}

struct SingleSurgery: Decodable {
    var success : Bool?
    var Result : SurgeryResult
}

struct SurgeryResult: Decodable {
    var __v: Int?
    var key: String?
    var dateofsurgery: String?
    var Reason: String?
    var type: String?
    var PatientId: String?
    var Response: String?
    var _id: String?
}

class SurgicalModel: NSObject {
    
    func addSurgeryData(parameterDictionary: [String: Any],  completion: @escaping (SingleSurgery) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_treatment")
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
            var activity: SingleSurgery!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(SingleSurgery.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    
    func allSurgeries(parameterDictionary: [String: Any],  completion: @escaping (AllSurgaries) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_treatment")
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
            var allActivities: AllSurgaries!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(AllSurgaries.self, from: data!)
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
