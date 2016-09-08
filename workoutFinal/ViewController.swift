//
//  ViewController.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 8/30/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import Foundation
import UIKit



class ViewController: UIViewController, URLSessionDataDelegate, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    var primaryUserArray: NSMutableArray = NSMutableArray()
    var data : NSMutableData = NSMutableData()
    
    
  
    @IBAction func loginButton(_ sender: AnyObject) {
       
        
//        if(usernameField.text == "" || passwordField.text == "")
//        {
//            print("userObjList is missing")
//        }else{
  
            
        parseJSON()
        
            
        }
        

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    func parseJSON() {
        
        
        debugPrint("parse json called")
        
        
        
        
        let requestURL: NSURL = NSURL(string: "http://98.253.68.160/getusers.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared()
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                var jsonResult: NSDictionary = NSDictionary()
               
                do{
                    
                    jsonResult = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                        
                    print(jsonResult)

                    
                
                    var userObjList: NSMutableArray
                    userObjList = jsonResult.mutableArrayValue(forKey: "USER")
                    
//                    let fnameList = userObjList.mutableArrayValue(forKey: "FNAME")
//                    let lnameList = userObjList.mutableArrayValue(forKey: "LNAME")
//                    let emailList = userObjList.mutableArrayValue(forKey: "EMAIL")
//                    let usernameList = userObjList.mutableArrayValue(forKey: "USERNAME")
//                    let passwordList = userObjList.mutableArrayValue(forKey: "PASSWORD")
//                    let weightList = userObjList.mutableArrayValue(forKey: "WEIGHT")
//                    let heightList = userObjList.mutableArrayValue(forKey: "HEIGHT")
//                    var userHelper = userObj()
                    

//                    print(fnameList.count)
                    
                    
                    
//                    for i in (0..<userObjList.count) {
//                        print(i)
//
//                        userHelper =  userObj(FNAME: fnameList[i] as! String,LNAME: lnameList[i] as! String,EMAIL: emailList[i] as! String,USERNAME: usernameList[i] as! String,PASSWORD: passwordList[i] as! String,WEIGHT: weightList[i] as! Int,HEIGHT: heightList[i] as! Int)
//                        
//                        self.primaryUserArray.add(userHelper)
//                        
//                        
//                        }
                    
                    
       
                    } catch let error as NSError {
                        print(error)
                        
                    }
                    
                    
                }
            }
        
        task.resume()

        
        
    }
    
    
    
    private static func usersFromJsonObject(json: [String: AnyObject]) -> userObj? {
        guard let
            firstName = json["FNAME"] as? String,
            lastName = json["LNAME"] as? String,
            email = json["EMAIL"] as? String,
            username = json["USERNAME"] as? String,
            password = json["PASSWORD"] as? String,
            weight = json["WEIGHT"] as? Int,
            height = json["HEIGHT"] as? Int else{
                
                //Don't have enough information ti construct a user
                return nil
        }
        return userObj(FNAME: firstName, LNAME: lastName, EMAIL: email, USERNAME: username, PASSWORD: password, WEIGHT: weight, HEIGHT: height)
    
    }
    
    
    
    
    
    
    
    
    
    
    
}

    
    
    
    

