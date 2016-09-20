//
//  userObj.swift
//  workoutFinal
//
//  Created by Jesse Alltop on 9/1/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import Foundation

class userObj: NSObject {
    
    var FNAME: String
    var LNAME: String
    var EMAIL: String
    var USERNAME: String
    var PASSWORD: String
    var WEIGHT: Int
    var HEIGHT: Int

    
    override init() {
        self.FNAME = ""
        self.LNAME = ""
        self.EMAIL = ""
        self.USERNAME = ""
        self.PASSWORD = ""
        self.WEIGHT = 0
        self.HEIGHT = 0
    }
    
    init(FNAME: String, LNAME: String, EMAIL: String, USERNAME: String, PASSWORD: String, WEIGHT: String, HEIGHT: String ){
        
        self.FNAME = FNAME
        self.LNAME = LNAME
        self.EMAIL = EMAIL
        self.USERNAME = USERNAME
        self.PASSWORD = PASSWORD
        self.WEIGHT = Int(WEIGHT)!
        self.HEIGHT = Int(HEIGHT)!
        
    }
    
    override var description: String {
        return "FNAME: \(FNAME), LNAME: \(LNAME), EMAIL: \(EMAIL), USERNAME: \(USERNAME), PASSWORD: \(PASSWORD), WEIGHT: \(WEIGHT), HEIGHT: \(HEIGHT)"
        
    }
    
    
}
