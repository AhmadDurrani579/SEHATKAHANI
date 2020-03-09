//
//  FamilyHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

struct FamilyHis: Decodable {
    var success : Bool?
    var result : [Result]
}

struct AddHis: Decodable {
    var success : Bool?
    var result : Result
}

struct Result: Decodable {
    var __v: Int?
    var key: String?
    var Relation: String?
    var Disease: String?
    var PatientId: String?
    var Response: String?
    var _id: String?
}



class FamilyHistoryCard : NSObject {
    
    func addfamilyHistory(parameterDictionary: [String: Any],  completion: @escaping (AddHis) -> ()) {
      
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_family")
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
            var historry: AddHis!
            if error != nil {
                print(error)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(AddHis.self, from: data!)
                print(courses)
                historry = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(historry)
            }.resume()
    }
    
    func allfamilyHistory(parameterDictionary: [String: Any],  completion: @escaping (FamilyHis) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_family")
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
            var historry: FamilyHis!
            if error != nil {
                print(error)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(FamilyHis.self, from: data!)
                print(courses)
                historry = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(historry)
            }.resume()
    }
    
}






























