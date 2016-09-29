//
//  NewUserViewController.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 9/27/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//
import Foundation
import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confpass: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    
    
    var primaryUserArray: NSMutableArray = NSMutableArray()

    @IBAction func createAccountBtn(_ sender: AnyObject) {
        
        if(validate()){
            createUser()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func validate() -> Bool {
        if(self.fname.text == "" ||
            self.lname.text == "" ||
            self.email.text == "" ||
            self.uname.text == "" ||
            self.pass.text == "" ||
            self.confpass.text == "" ||
            self.weight.text == "" ||
            self.height.text == "" ){
            //some field was left blank
            let alertController = UIAlertController(title: "Error", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return false
        }

        if(self.pass.text != self.confpass.text){
            let alertController = UIAlertController(title: "Error", message: "Password's must match.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    func createUser() {
        let requestURL: NSURL = NSURL(string: "http://52.42.86.96//createuserspost.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        
        urlRequest.httpMethod="POST"
        let postString = "fname=\(fname.text!)&lname=\(lname.text!)&email=\(email.text!)&username=\(uname.text!)&password=\(pass.text!)&weight=\(weight.text!)&height=\(height.text!)"
        print(postString)
        
        
        
        urlRequest.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                    //parsing the response
                    do {
                        //converting resonse to NSDictionary
                        let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        //parsing the json
                        if let parseJSON = myJSON {
                            
                            //creating a string
                            var msg : String!
                            
                            //getting the json response
                            msg = parseJSON["status"] as! String?
                            
                            if(msg == "Success"){
                                //user was created
                           
                                let usrHelper = userObj(FNAME: self.fname.text!,
                                                            LNAME: self.lname.text!,
                                                            EMAIL: self.email.text!,
                                                            USERNAME: self.uname.text!,
                                                            PASSWORD: self.pass.text!,
                                                            WEIGHT: self.weight.text!,
                                                            HEIGHT: self.height.text!)
                                
                                self.primaryUserArray.add(usrHelper)
                                
                                
                                DispatchQueue.main.sync {
                                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "successLoginViewController") as! successLoginViewController
                                    controller.labelText = "Welcome "+(self.primaryUserArray[0] as!userObj).FNAME
                                    
                                    controller.buttonText = "Not "+(self.primaryUserArray[0] as! userObj).FNAME+"? Sign Out"
                                    self.present(controller, animated: true, completion: nil)
                                
                                
                                }
                                }else{
                                //user was not created
                                DispatchQueue.main.sync(execute: {
                                    let alertController = UIAlertController(title: "Error", message: "Username is already taken.", preferredStyle: UIAlertControllerStyle.alert)
                                    let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                })
                            }
                            
                            
                        }
                    } catch {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fname.resignFirstResponder()
        lname.resignFirstResponder()
        email.resignFirstResponder()
        uname.resignFirstResponder()
        pass.resignFirstResponder()
        confpass.resignFirstResponder()
        weight.resignFirstResponder()
        height.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
