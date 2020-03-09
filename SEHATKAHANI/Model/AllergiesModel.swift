//
//  AllergiesModel.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
import UIKit
struct Aller: Decodable {
    var success : Bool?
    var result : [Results1]
}

struct AddAller: Decodable {
    var success : Bool?
    var NewAllergy : Results1
}

struct Results1: Decodable {
    var __v: Int?
    var key: String?
    var Notes: String?
    var Reaction: String?
    var type: String?
    var PatientId: String?
    var Response: String?
    var _id: String?
}



class AllergiesModel : NSObject {
    
    func getAllAllergies(parameterDictionary: [String: Any], completion: @escaping (AddAller) -> ()) {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/add_allergy")
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
                var allergies: AddAller!
                if error != nil {
                    print(error)
                    return
                }
                if let response = response {
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse.statusCode)
                }
                
                do {
                    let courses = try JSONDecoder().decode(AddAller.self, from: data!)
                    print(courses)
                    allergies = courses
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                    return
                }
                completion(allergies)
                }.resume()
    }
    
    func viewAllergies(parameterDictionary: [String: Any], activityIndicator: UIActivityIndicatorView,  completion: @escaping (Aller) -> ()) {
        
        activityIndicator.startAnimating()
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/history/get_allergy")
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
            var allergies: Aller!
            if error != nil {
                print(error)
                activityIndicator.stopAnimating()
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(Aller.self, from: data!)
//                print(courses)
                DispatchQueue.main.async {
                  activityIndicator.stopAnimating()
                }
                allergies = courses
            } catch let jsonErr {
                activityIndicator.stopAnimating()
                print("Error serializing json:", jsonErr)
                return
            }
            completion(allergies)
            }.resume()
    }
    
}
























