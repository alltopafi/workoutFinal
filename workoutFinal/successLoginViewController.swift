//
//  SuccessLoginViewController.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 9/24/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import UIKit

class successLoginViewController: UIViewController {

    
    var labelText: String = "nothing" 
    var buttonText: String = "Sign Out"
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var signoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Label.text = labelText
        signoutButton.setTitle(buttonText, for: UIControlState.normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
