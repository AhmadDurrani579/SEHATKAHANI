//
//  APIManager.swift
//  PakArmy
//
//  Created by M Zia Ur Rehman Ch. on 27/07/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//


import Foundation
import CoreData
import Alamofire
import SwiftyJSON
import SVProgressHUD

struct APIKey {
    static let KGoogleAPIKey = "AIzaSyAN0icHW5F4iWKk8evPSmaO7jIDDf8vxcI"

}

enum SKUserType {
    case patient
    case doctor
    case unknownUser
    func getCallTypeStr() -> String {
        switch self {
        case .patient:
            return "Patient"
        case .doctor:
            return "Doctor"
        case .unknownUser:
            return "ios failure"
        }
    }
}

enum SKCallType {
    case audio
    case video
    case unknown
    func getCallTypeStr() -> String {
        switch self {
        case .audio:
            return "audio"
        case .video:
            return "video"
        case .unknown:
            return "ios failure"
        }
    }
}

struct SKUserDefaultKeys {
    static let LOGGED_IN_USER = "loggedInUser"
    static let API_TOKEN      = "apiToken"
    static let PHONE_NUMBER   = "phoneNumber"
}

class APIManager {
    static let sharedInstance = APIManager()
    let baseUrl = "https://stage.sehatkahani.com"
    let mainWindow = UIApplication.shared.windows.first
//    var lang: String!
    private init(){
        
    }
    var key: String!
 
    func isfirst(lang: Bool)  {
        UserDefaults.standard.set(lang, forKey: "fnumber")
    }
    
    func isfirstGet() -> Bool {
        if let lang =  UserDefaults.standard.object(forKey: "fnumber") {
            return lang as! Bool
        }
        return false
    }
 
    func isdr(dr: Bool)  {
        UserDefaults.standard.set(dr, forKey: "dr")
    }
    
    func getisdr() -> Bool {
        if let dr =  UserDefaults.standard.object(forKey: "dr") {
            return dr as! Bool
        }
        return false
    }
    
    func isSocial(social: Bool)  {
        UserDefaults.standard.set(social, forKey: "social")
    }
    
    func geIsSocial() -> Bool {
        if let social =  UserDefaults.standard.object(forKey: "social") {
            return social as! Bool
        }
        return false
    }
    
    
    func setEmail(email: String)  {
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    func getEmail() -> String {
        if let email =  UserDefaults.standard.object(forKey: "email") {
            return email as! String
        }
        return ""
    }
    
    func setToken(token: String)  {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String {
        if let token =  UserDefaults.standard.object(forKey: "token") {
            return token as! String
        }
        return ""
    }

    func setId(id: String)  {
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    func getId() -> String {
        if let id =  UserDefaults.standard.object(forKey: "id") {
            return id as! String
        }
        return ""
    }
    
    
    func setName(name: String)  {
        UserDefaults.standard.set(name, forKey: "name")
    }
    func getName() -> String {
        if let name =  UserDefaults.standard.object(forKey: "name") {
            return name as! String
        }
        return ""
    }

     //MARK : - custom Funcation


    func showHud() -> Void {
        DispatchQueue.main.async {
            SVProgressHUD.show();
        }
    }
    func hideHud() -> Void {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss();
        }
    }
    func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    class func saveInUserDefault(object : Any , Key : String) -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(object, forKey: Key)
        userDefaults.synchronize();
        debugPrint("defaults savedString: \(userDefaults.value(forKey: Key))")
    }

    class func getUserDefault(key : String) -> Any {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key) as Any;
    }

    class func getBoolUserDefault(key : String) -> Bool {
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: key) {
            return value as? Bool ?? true
        } else {
            return false
        }
    }

    class func MakeStatusBarWhite() {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    class func MakeStatusBarBlack() {
        UIApplication.shared.statusBarStyle = .default
    }

    

    
//    func fetch(customUrl: String ,onCompletion:@escaping (JSON) -> Void){
//
//
//        let url = NSURL(string: customUrl)
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "GET"
//        //        request.setValue("custom_collections", forHTTPHeaderField: "custom_collections")
//
//        Alamofire.request(request as URLRequest).responseJSON(){ (response) in
//
//            switch response.result {
//            case .success(let data):
//                //                print("\(data)")
//                _ = data
//                let response = JSON(response.value as! NSDictionary)
//                onCompletion(response)
//
//            case .failure(let error):
//                print("There is an error : \(error as NSError)")
//                onCompletion(JSON.null)
//
//            }
//        }
//    }


//    func customAlert(viewcontroller: UIViewController, message: String) {
//
//        let attributedString = NSAttributedString(string: "ALERT", attributes: [
//            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), //your font here
//            NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.007843137255, green: 0.6039215686, blue: 0.7960784314, alpha: 1)
//            ])
//        let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
//        alert.setValue(attributedString, forKey: "attributedTitle")
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//        alert.view.tintColor = #colorLiteral(red: 0.007843137255, green: 0.6039215686, blue: 0.7960784314, alpha: 1)
//        viewcontroller.present(alert, animated: true, completion: nil)
//    }
//
    func customAlert(viewcontroller: UIViewController, message: String) {
        
        DispatchQueue.main.async {
       
            let attributedString = NSAttributedString(string: "Sehat Kahani", attributes: [
                NSFontAttributeName:UIFont(
                    name: "Lato",
                    size: 14.0)!, //your font here//
                //            NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.007843137255, green: 0.6039215686, blue: 0.7960784314, alpha: 1)
                ])
            let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.view.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            viewcontroller.present(alert, animated: true, completion: nil)
            
        }
        
        

    }




    static func showAlertView(message: String) {
        // Alert user that some fields are missing.
        let alert = UIAlertController(title: "Sehat Kahani", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        if let vc = UIApplication.topViewController(){
                vc.present(alert, animated: true, completion: nil)
            }
    }

    func saveLoggedInUser(user: SKUser) {
        let userDict = user.dictionaryRepresentation()
        APIManager.saveInUserDefault(object: userDict as Any, Key: SKUserDefaultKeys.LOGGED_IN_USER)
    }

    func getLoggedInUser() -> SKUser? {
        var user: SKUser? = nil
        if let userDict = APIManager.getUserDefault(key: SKUserDefaultKeys.LOGGED_IN_USER) as? [String: AnyObject] {
            user = SKUser(JSON: userDict)
        }
        return user
    }
    func resetLoggedInUser() -> Void {
        APIManager.saveInUserDefault(object: "" as Any, Key: SKUserDefaultKeys.LOGGED_IN_USER)
        SKSocketConnection.socketSharedConnection.disconnectSocketCurrentSession()
    }


      //MARK : - Calling Funcation

    static func POST(url: String,
                     parameters: [String: AnyObject],
                     authenticate: Bool = true,
                     callback: @escaping (String?, JSON?)->Void) {

        //  var finalParams = parameters
        //        if authenticate {
        //            // Send phone number and API token with each POST request which requires authentication.
        //            let phoneNumber = BCUtility.getUserDefault(key: BCUserDefaultKeys.PHONE_NUMBER) as? String ?? ""
        //            let apiToken = BCUtility.getUserDefault(key: BCUserDefaultKeys.API_TOKEN) as? String ?? ""
        //            finalParams["phone"] = phoneNumber as AnyObject
        //            finalParams["apiToken"] = apiToken as AnyObject
        //        }
        // Remove any existing overlays and show the new loading overlay so that they don't overlap.
        //        SwiftOverlays.removeAllBlockingOverlays()
        //        SwiftOverlays.showBlockingWaitOverlay()
//         BCUtility.showProgressHud()
        // Send POST request.

        APIManager.sharedInstance.showHud()

        print ("url : \(url)")
        print ("parameters : \(parameters)")

        Alamofire.request(url, method: .post, parameters: parameters).validate().responseJSON { response in
             APIManager.sharedInstance.hideHud()
            if let responseData = response.result.value {
                let json = JSON(responseData)
                print("\n*** Response received for API:\n\(url) \n\nResponse JSON:\n \(json)")
                callback(nil, json)
            } else {
                callback("Failed to unwrap response", nil)
            }
        }
    }

    static func GET(url: String,
                    parameters: [String: AnyObject],
                    authenticate: Bool = true,
                    callback: @escaping (String?, JSON?)->Void) {
        let finalParams : [String : Any] = parameters
        // Show loading overlay.
        //        SwiftOverlays.showBlockingWaitOverlay()
        // BCUtility.showProgressHud()

        // Send POST request.
        APIManager.sharedInstance.showHud()
        Alamofire.request(url, method: .get, parameters: finalParams).validate().responseJSON { response in
            APIManager.sharedInstance.hideHud()
            // Response received. Hide loading overlay.
            //   SwiftOverlays.removeAllBlockingOverlays()
            // BCUtility.hideProgressHud()
            if let responseData = response.result.value {
                let json = JSON(responseData)
                print("\n*** Response received for API:\n\(url) \n\nResponse JSON:\n \(json)")
                callback(nil, json)
            } else {
                callback("Failed to unwrap response", nil)
            }
        }
    }
    
}


//@IBDesignable class BottomAlignedLabel: UILabel {
//    override func drawText(in rect: CGRect) {
//        if let stringText = text {
//            let stringTextAsNSString = stringText as NSString
//            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
//                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                                                    attributes: [NSAttributedStringKey.font: font],
//                                                                    context: nil).size
//            super.drawText(in: CGRect(x:0,y: rect.size.height - labelStringSize.height, width: self.frame.width, height: ceil(labelStringSize.height)))
//        } else {
//            super.drawText(in: rect)
//        }
//    }
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.clear.cgColor
//    }
//}
//
//













