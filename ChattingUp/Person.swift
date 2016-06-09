//
//  Person.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/4/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JSONHelper

struct Person: Deserializable {
    var userId = 0
    var userName = ""
    var nombre = ""
    
    init(data: [String: AnyObject]) {
        userId <-- data["userId"]
        userName <-- data["userName"]
        nombre <-- data["nombre"]
    }
}