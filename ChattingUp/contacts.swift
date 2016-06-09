//
//  contacts.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/4/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JSONHelper


class contacts: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    static var people = [Person]()
    static var userId:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let seconds = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.tableView(self.tableView,numberOfRowsInSection: contacts.people.count)
            
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:customViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath:indexPath) as! customViewCell
        cell.nameLabel!.text = contacts.people [indexPath.row].nombre
        cell.descLabel!.text = contacts.people [indexPath.row].userName
        cell.idLabel!.text = String(contacts.people [indexPath.row].userId)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.people.count;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        ViewMessages.userId = contacts.userId
        ViewMessages.friendId = contacts.people[self.tableView.indexPathForSelectedRow!.row].userId
        ViewMessages.friendName = contacts.people[self.tableView.indexPathForSelectedRow!.row].userName
    }
}
