//
//  MedicationModel.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
struct AllMedications: Decodable {
    var success : Bool?
    var result : [MedicationsResult]
}

struct SingleMedications: Decodable {
    var success : Bool?
    var result : MedicationsResult
}

struct MedicationsResult: Decodable {
    var __v: Int?
    var key: String?
    var Disease: String?
    var Treatment: Bool?
    var PatientId: String?
    var Response: String?
    var _id: String?
}


struct GetAllMedication: Decodable {
    var success : Bool?
    var result  : [GetSingleMedicationA]
}
struct GetSingleMedicationA : Decodable  {
     var _id :  String?
     var key : String?
     var Comments : String?
     var Dosage : String?
     var Name : String?
     var PatientId : String?
     var Response : String?
    
}


class MedicationModel: NSObject {
    
    func addMadicationData(parameterDictionary: [String: Any],  completion: @escaping (SingleMedications) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_medication")
        guard let serviceUrl = URL(string: Url) else { return }
        APIManager.sharedInstance.showHud()
        var request = URLRequest(url: serviceUrl)
        APIManager.sharedInstance.hideHud()
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            var activity: SingleMedications!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(SingleMedications.self, from: data!)
                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    
    func allMedications(parameterDictionary: [String: Any],  completion: @escaping (GetAllMedication) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_medication")
        guard let serviceUrl = URL(string: Url) else { return }
        APIManager.sharedInstance.showHud()
        var request = URLRequest(url: serviceUrl)
        APIManager.sharedInstance.hideHud()
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            var allActivities: GetAllMedication!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(GetAllMedication.self, from: data!)
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
