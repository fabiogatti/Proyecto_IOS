//
//  Message.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/7/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JSONHelper

struct Message: Deserializable {
    var messageId = 0
    var userFrom = 0
    var userTo = 0
    var message = ""
    var date = ""
    
    init(data: [String: AnyObject]) {
        messageId <-- data["id"]
        userFrom <-- data["from"]
        userTo <-- data["to"]
        message <-- data["text"]
        date <-- data["date"]
    }
    
    init(userFrom:Int, userTo:Int, message:String, date:String){
        self.userFrom = userFrom
        self.userTo = userTo
        self.message = message
        self.date = date
    }
    
    init(messageId:Int, userFrom:Int, userTo:Int, message:String, date:String){
        self.messageId = messageId
        self.userFrom = userFrom
        self.userTo = userTo
        self.message = message
        self.date = date
    }
}