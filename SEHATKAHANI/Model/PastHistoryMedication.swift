//
//  PastHistoryMedication.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

struct AllMedicaton: Decodable {
    var success : Bool?
    var result : [MedicationResult]
}

struct SingleMedication: Decodable {
    var success : Bool?
    var result : MedicationResult
}

struct MedicationResult: Decodable {
    var __v: Int?
    var key: String?
    var Comments: String?
    var Dosage: String?
    var Name: String?
    var PatientId: String?
    var Response: String?
    var _id: String?
}



class PastHistoryMedication : NSObject {
    
    
    
    func addMedicationHistory(parameterDictionary: [String: Any],  completion: @escaping (SingleMedication) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_disease")
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
            var medication: SingleMedication!
            if error != nil {
                print(error)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(SingleMedication.self, from: data!)
                print(courses)
                medication = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(medication)
            }.resume()
    }

    func drCard(parameterDictionary: [String: Any], url: String) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+url)
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
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? NSDictionary
                print(courses)
          
//                medication = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            }.resume()
    }
    
    
    
    func allMedication(parameterDictionary: [String: Any],  completion: @escaping (FamilyHis) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_disease")
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
            var medication: FamilyHis!
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
                medication = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(medication)
            }.resume()
    }
    
}




















