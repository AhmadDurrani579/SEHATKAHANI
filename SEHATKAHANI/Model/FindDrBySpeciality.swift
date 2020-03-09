//
//  FindDrBySpeciality.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
struct DrSpeciality: Decodable {
    var success : Bool?
    var result : [DrSpecialityResults]
}

struct DrSpecialityResults: Decodable {
    var _id : String?
    var email : String?
    var speciality : String?
    var medno : String?
    var experience : String?
    var degree : String?
}


class FindDrBySpeciality: NSObject {

    func getDrbySpeciality(url: String, completion: @escaping (DrSpeciality) -> ()) {
        
        let jsonUrlString = APIManager.sharedInstance.baseUrl+url
        APIManager.sharedInstance.showHud()
        guard let url = URL(string: jsonUrlString) else { return }
        APIManager.sharedInstance.hideHud()
        var specialites: DrSpeciality!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(DrSpeciality.self, from: data)
                specialites = courses
                //                print(courses.announcements.first?.announcement_description)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
//                APIManager.sharedInstance.customPOP(message: "Authentication Required Please LogIn Again.")
                return
            }
            completion(specialites)
            }.resume()
    }
    
    func getAllDoctor(url: String, completion: @escaping (DBName) -> ()) {
        let jsonUrlString = APIManager.sharedInstance.baseUrl+url
        guard let url = URL(string: jsonUrlString) else { return }
        var specialites: DBName!
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                return
            }
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
            }
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(DBName.self, from: data)
                specialites = courses
                //                print(courses.announcements.first?.announcement_description)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                //                APIManager.sharedInstance.customPOP(message: "Authentication Required Please LogIn Again.")
                return
            }
            completion(specialites)
            }.resume()
    }
}
