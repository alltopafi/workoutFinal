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
       if(usernameField.text == "" || passwordField.text == "")
        {
            print("userObjList is missing")
       }else{parseJSON()
        }
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
        let requestURL: NSURL = NSURL(string: "http://98.253.68.160/getuserspost.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        
        urlRequest.httpMethod="POST"
        let postString = "username=\(usernameField.text!)&password=\(passwordField.text!)"
        urlRequest.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary //[String: AnyObject]
                
                    var something: NSMutableArray
                        something = jsonResult.mutableArrayValue(forKey: "USERS")
                    let fname = something.mutableArrayValue(forKey: "FNAME")
                    let lname = something.mutableArrayValue(forKey: "LNAME")
                    let email = something.mutableArrayValue(forKey: "EMAIL")
                    let uname = something.mutableArrayValue(forKey: "USERNAME")
                    let password = something.mutableArrayValue(forKey: "PASSWORD")
                    let weight = something.mutableArrayValue(forKey: "WEIGHT")
                    let height = something.mutableArrayValue(forKey: "HEIGHT")

                    for i in 0..<something.count {
                            let usrHelp = userObj(FNAME: fname[i] as! String,
                                                  LNAME: lname[i] as! String,
                                                  EMAIL: email[i] as! String,
                                                  USERNAME: uname[i] as! String,
                                                  PASSWORD: password[i] as! String,
                                                  WEIGHT: weight[i] as! String,
                                                  HEIGHT: height[i] as! String)
                        
                            self.primaryUserArray.add(usrHelp)
                    }
                    if(self.primaryUserArray.count == 1){
                        //go to next screen
                    }else{
                        //there was an error no user was found http status code != 200
                    }
                } catch let error as NSError {
                    print(error)
                  }
            }else{
                //there was an error with connecting to the server
            }
        }//end of task
            task.resume()
    }//end of parse json method
    
    
}
