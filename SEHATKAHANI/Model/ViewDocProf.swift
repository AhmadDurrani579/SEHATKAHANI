//
//  ViewDocProf.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 25/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

// ["Speciality", "Qualification", "PMDC Licence", "Email", "Experience","Fee", "Organization"]

struct ViewDocPro: Decodable {
    var success : Bool?
    var result : DrProfileResults
}

struct DrProfileResults: Decodable {
    var _id : String?
    var doctor: ViewDoctor
    var email : String?
    var isOnline : String?
    var name: DrName
    var photo: DrPhoto

}
//struct DrName: Decodable {
//    var first : String?
//    var last : String?
//}
//struct DrPhoto: Decodable {
//    var url : String?
//}
struct ViewDoctor: Decodable {
    var _id: String?
    var speciality : String?
    var workplace : String?
    var experience : String?
    var experiencemonths : String?
    var UserId: String?
    var fee1: Int?
    var medno: String?
    var degree: String?
}


struct IsFavourite: Decodable {
    var success: Bool?
    var favourite: Bool?
}






class ViewDocProf: NSObject {

    
    func addtoFavourite(url: String, parameterDictionary: [String: Any]) {
        
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
//                if  let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? NSDictionary {
//                    print(json)
//                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            }.resume()
        
    }

    func checkIsFavourite(url: String, parameterDictionary: [String: Any],  completion: @escaping (IsFavourite) -> ()) {
        
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
            var activity: IsFavourite!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            
            do {
                let courses = try JSONDecoder().decode(IsFavourite.self, from: data!)
                //                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
    
    
    func getDrbyname(url: String, parameterDictionary: [String: Any],  completion: @escaping (ViewDocPro) -> ()) {

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
            var activity: ViewDocPro!
            if error != nil {
                print(error!)
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }

            do {
                let courses = try JSONDecoder().decode(ViewDocPro.self, from: data!)
//                print(courses)
                activity = courses
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                return
            }
            completion(activity)
            }.resume()
    }
}












