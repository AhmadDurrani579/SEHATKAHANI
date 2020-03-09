//
//  Singelton.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class Singelton: NSObject {

      static let sharedInstance = Singelton()

    func getDateFromServerString(serverDate : String) -> Date {
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
       // myDateFormatter.timeZone = TimeZone(abbreviation: "PKT");
        let mySelectedDate: Date = myDateFormatter.date(from: serverDate)!
        let date = Calendar.current.date(byAdding: .hour, value: 5, to: mySelectedDate)
        return date!;
    }
    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat

        return dateFormatter.string(from: dt!)
    }



    

}
