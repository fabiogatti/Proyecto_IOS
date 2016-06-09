//
//  ViewController.swift
//  ChattingUp
//
//  Created by Estudiantes on 1/06/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import UIKit
import Alamofire
import JSONHelper

class ViewController: UIViewController {

    
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var people = [Person]()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     let dir = "http://10.5.99.70:8191/rest/contacts/" + textfield.text!
     Alamofire.request(.GET, dir).responseJSON { response in
     print(response.request)  // original URL request
     print(response.response) // URL response
     print(response.data)     // server data
     print(response.result)   // result of response serialization
     
     if let JSON = response.result.value {
        print("JSON: \(JSON)")
        self.people <-- JSON
        if(response.result.isFailure){
            let alert = UIAlertView()
            alert.title = "Not a valid ID"
            alert.message = "Please enter a valid ID"
            alert.addButtonWithTitle("Ok")
            alert.show()
            return
        }
        }
        contacts.people = self.people
        contacts.userId = Int(self.textfield.text!)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

