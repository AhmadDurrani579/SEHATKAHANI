//
//  MOMessage.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 29/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class MOMessage: NSObject {
    var message : JSQMessage?
    var senderID : String?
 
    init(message: JSQMessage?,senderID: String?)
    {
        self.message = message
        self.senderID = senderID

    }

}
