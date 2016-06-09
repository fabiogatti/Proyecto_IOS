//
//  ViewMessages.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/7/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JSONHelper


class ViewMessages: UIViewController{
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    static var messages = [Message]()
    static var userId:Int = 0
    static var friendId:Int = 0
    static var friendName:String = ""
    private var db:DataBaseManager = DataBaseManager()
    static var dbMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dir = "http://10.5.99.70:8191/rest/messages/" + String(ViewMessages.friendId) + "/" + String(ViewMessages.userId)
        Alamofire.request(.GET, dir).responseJSON { response in
            
            self.navigationController!.navigationBar.topItem!.title = /*"Message: " + */ViewMessages.friendName
            

            
            if let JSON = response.result.value {
                ViewMessages.messages <-- JSON
                for message in ViewMessages.messages{
                    self.db.addMessage(message.userFrom, userTo: message.userTo, message: message.message, date: message.date)
                }
                
            }
            
            ViewMessages.dbMessages = self.db.getMessages(ViewMessages.userId,userTo:ViewMessages.friendId)
            var tempMessages = [Message]()
            tempMessages = self.db.getMessages(ViewMessages.friendId,userTo:ViewMessages.userId)
            for message in tempMessages{
                ViewMessages.dbMessages.append(message)
            }
            
            self.tableView(self.tableView,numberOfRowsInSection: ViewMessages.messages.count)
            self.viewWillAppear(true)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        ViewMessages.dbMessages.sortInPlace { (element1, element2) -> Bool in
            return element1.messageId < element2.messageId
        }
        
        
        if(ViewMessages.dbMessages [indexPath.row].userFrom == ViewMessages.friendId){
            let cell:CustomMessageCell1 = tableView.dequeueReusableCellWithIdentifier("CustomCell1", forIndexPath:indexPath) as! CustomMessageCell1
            cell.messageLabel!.text = ViewMessages.dbMessages [indexPath.row].message
            return cell
        }
        else{
            let cell:CustomMessageCell2 = tableView.dequeueReusableCellWithIdentifier("CustomCell2", forIndexPath:indexPath) as! CustomMessageCell2
            cell.messageLabel!.text = ViewMessages.dbMessages [indexPath.row].message
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewMessages.dbMessages.count;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func sendMessage(sender: AnyObject) {
        if(textView.text!==""){
            return
        }
        
        let parameters =
        [
            "from": ViewMessages.userId,
            "to": ViewMessages.friendId,
            "text": textView.text!
        ]
        Alamofire.request(.POST, "http://10.5.99.70:8191/rest/messages", parameters: parameters as? [String : AnyObject], encoding: .JSON).responseJSON { response in
        }
        
        let date = NSDate()
        db.addMessage(ViewMessages.userId, userTo: ViewMessages.friendId, message: textView.text!, date: String(date))
        
        //Refresh dbmessages data
        ViewMessages.dbMessages = self.db.getMessages(ViewMessages.userId,userTo:ViewMessages.friendId)
        var tempMessages = [Message]()
        tempMessages = self.db.getMessages(ViewMessages.friendId,userTo:ViewMessages.userId)
        for message in tempMessages{
            ViewMessages.dbMessages.append(message)
        }
        //ViewMessages.dbMessages.append(Message(userFrom:ViewMessages.userId, userTo: ViewMessages.friendId, message: textView.text!, date: String(date)))
        
        self.viewWillAppear(true)
        
        textView.text! = ""
    }
}