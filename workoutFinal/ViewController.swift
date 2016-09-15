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
        
//        let requestURL: NSURL = NSURL(string: "http://workoutapptesting.ddns.net/getusers.php")!
//      let requestURL: NSURL = NSURL(string: "http://localhost/getusers.php")!
      let requestURL: NSURL = NSURL(string: "http://98.253.68.160/getusers.php")!
        var userNamesArray = [String]()
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared()
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                //var jsonResult: AnyObject
                
                do{
                    
                   // jsonResult = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                    
                    var jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    
                    
                    if let users = jsonResult["USER"] as? [String: AnyObject] {
                        if let userNames = users["USERNAME"] {

                            for i in 0..<userNames.count{
                                let usrnm = userNames[i] as! String
                                print(usrnm)
                                userNamesArray.append(usrnm)
                                
                            }
                        
                        
                        }
                    }
                    
                    
                        
                    print(jsonResult)

                
                    
                    
                    

                    

       
                    } catch let error as NSError {
                        print(error)
                        
                    }
                    
                    
                }
            }
        
        task.resume()

        
        
    }
    
    
}
