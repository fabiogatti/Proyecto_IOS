//
//  ViewFiles.swift
//  ChattingUp
//
//  Created by Estudiantes on 6/8/16.
//  Copyright © 2016 Estudiantes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JSONHelper


class ViewFiles: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    static var people = [Person]()
    static var userId:Int = 0
    var imagePickerController = UIImagePickerController()
    
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
        let cell:CustomFileCell1 = tableView.dequeueReusableCellWithIdentifier("CustomCell3", forIndexPath:indexPath) as! CustomFileCell1
        cell.uploadButton!.titleLabel?.text = contacts.people [indexPath.row].nombre
        
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
    
    
    @IBAction func uploadFile(sender: AnyObject){
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: { imageP in
            
        })
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        /*Alamofire.upload(<#T##URLRequest: URLRequestConvertible##URLRequestConvertible#>, multipartFormData: <#T##MultipartFormData -> Void#>, encodingCompletion: <#T##(Manager.MultipartFormDataEncodingResult -> Void)?##(Manager.MultipartFormDataEncodingResult -> Void)?##Manager.MultipartFormDataEncodingResult -> Void#>)
        Alamofire.upload(
            //.POST,
            URLRequest:"http://10.5.99.70:8191/rest/messages/", // http://httpbin.org/post
            multipartFormData: { multipartFormData in
                //multipartFormData.appendBodyPart(fileURL: imagePathUrl!, name: "photo")
                multipartFormData.appendBodyPart(data: selectedImage, name: "file")
                /*multipartFormData.appendBodyPart(fileURL: videoPathUrl!, name: "video")
                multipartFormData.appendBodyPart(data: Constants.AuthKey.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"authKey")
                multipartFormData.appendBodyPart(data: "\(16)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"idUserChallenge")
                multipartFormData.appendBodyPart(data: "comment".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"comment")
                multipartFormData.appendBodyPart(data:"\(0.00)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"latitude")
                multipartFormData.appendBodyPart(data:"\(0.00)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"longitude")
                multipartFormData.appendBodyPart(data:"India".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"location")*/
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { request, response, JSON, error in
                        
                        
                    }
                case .Failure(let encodingError): break
                    
                }
            }
        )*/
    }
    
}
