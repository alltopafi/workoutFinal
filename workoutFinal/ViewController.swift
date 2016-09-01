//
//  ViewController.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 8/30/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet var passwordField: UIView!
        
    @IBAction func loginButton(_ sender: AnyObject) {
    }
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func validateUserWithPass(username: String, password: String) -> Boolean
{
    return false
}

}

