//
//  PhysicalHistoryModel.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

struct AllPhysicalActivities: Decodable {
    var success : Bool?
    var result : [ActivityResult]
}

struct SinglePhysicalActivity: Decodable {
    var success : Bool?
    var result : ActivityResult
}

struct ActivityResult: Decodable {
    var __v: Int?
    var key: String?
    var Frequency: String?
    var Name: String?
    var type: String?
    var PatientId: String?
    var Response: String?
    var _id: String?
}



class PhysicalHistoryModel : NSObject {
    
    
    
    func addPhysicalActivity(parameterDictionary: [String: Any],  completion: @escaping (SinglePhysicalActivity) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_physical")
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
            var activity: SinglePhysicalActivity!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(SinglePhysicalActivity.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    
    func allPhysicalActivity(parameterDictionary: [String: Any],  completion: @escaping (AllPhysicalActivities) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_physical")
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
            var allActivities: AllPhysicalActivities!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(AllPhysicalActivities.self, from: data!)
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

