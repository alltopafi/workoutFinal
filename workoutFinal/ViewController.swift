//
//  ViewController.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 8/30/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import Foundation
import UIKit



class ViewController: UIViewController, URLSessionDataDelegate, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var primaryUserArray: NSMutableArray = NSMutableArray()
    var data : NSMutableData = NSMutableData()
    
    @IBAction func createAccountButton(_ sender: AnyObject) {
      
    }
    @IBAction func loginButton(_ sender: AnyObject) {
        if(usernameField.text == "" || passwordField.text == "")
        {
            print("userObjList is missing")
                let alertController = UIAlertController(title: "Error", message: "Must enter Username and Password fields.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
       }else{
            parseJSON()
            print("parsing has finished here")
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
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    var something: NSMutableArray
                        something = (jsonResult as AnyObject).mutableArrayValue(forKey: "USERS")
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
                        print("we made it")
                        
                    }else{
                        //there was an error no user was found
                        DispatchQueue.main.sync(execute: {
                            let alertController = UIAlertController(title: "Error", message: "Either Username or password is invalid.", preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        })
                    }
                } catch let error as NSError {
                    print(error)
                  }
            }else{
                //there was an error with connecting to the server
                print("we did not make it")
                DispatchQueue.main.sync(execute: {
                    let alertController = UIAlertController(title: "Error", message: "Connection error\nPlease try again.", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                })
            }
        }//end of task
            task.resume()
        
    }//end of parse json method
}
