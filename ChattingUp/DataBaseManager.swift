//
//  DataBaseManager.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/8/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class DataBaseManager {
    
    private var db:Connection
    
    private var messages:Table
    private var idColumn:Expression<Int>
    private var userFromColumn:Expression<Int>
    private var userToColumn:Expression<Int>
    private var messageColumn:Expression<String>
    private var dateColumn:Expression<String>
    
 
    init(){
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        db = try! Connection("\(path)/db.sqlite3")
        
        messages = Table("message")
        idColumn = Expression<Int>("id")
        userFromColumn = Expression<Int>("userFrom")
        userToColumn = Expression<Int>("userTo")
        messageColumn = Expression<String>("message")
        dateColumn = Expression<String>("date")
        
        
        //try! db.run(tasks.drop(ifExists: true))
        try! db.run(messages.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: PrimaryKey.Autoincrement)
            t.column(userFromColumn)
            t.column(userToColumn)
            t.column(messageColumn)
            t.column(dateColumn)
            })
    }
    
    func addMessage(userFrom:Int, userTo:Int, message:String, date:String) {
        try! db.run(messages.insert(userFromColumn <- userFrom, userToColumn <- userTo, messageColumn <- message, dateColumn <- date))
    }
    
    func getMessages(userFrom:Int, userTo:Int) -> [Message]{
        //let query = tasks.limit(offset: id)
        //let task = Array(try! db.prepare(query))[0]
        
        var messagesArray = [Message]()
        for row in try! db.prepare("SELECT id, message, date FROM message WHERE userFrom="+String(userFrom)+" and userTo="+String(userTo)){
            debugPrint("Valor de row[0]: ",row[0]!)
            messagesArray.append(Message(messageId:Int(String(row[0]!))!,userFrom:userFrom, userTo:userTo, message:String(row[1]!), date:String(row[2]!)))
        }
        
        return messagesArray
    }

    func count() -> Int {
        return db.scalar(messages.count)
    }
    
}