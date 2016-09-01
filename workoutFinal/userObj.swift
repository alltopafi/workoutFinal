//
//  userObj.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 9/1/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import Foundation

class userObj: NSObject {
    
    var FNAME: String?
    var LNAME: String?
    var EMAIL: String?
    var USERNAME: String?
    var PASSWORD: String?
    var WEIGHT: Int?
    var HEIGHT: Int?

    
    override init() {
        
    }
    
    init(FNAME: String, LNAME: String, EMAIL: String, USERNAME: String, PASSWORD: String, WEIGHT: Int, HEIGHT: Int ){
        
        self.FNAME = FNAME
        self.LNAME = LNAME
        self.EMAIL = EMAIL
        self.USERNAME = USERNAME
        self.PASSWORD = PASSWORD
        self.WEIGHT = WEIGHT
        self.HEIGHT = HEIGHT
        
    }
    
    
    
    
}
