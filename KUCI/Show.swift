//
//  Show.swift
//  KUCI
//
//  Created by Nealon Young on 6/2/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import Foundation

@objc class Show : NSObject {
    
    var title: String
    var host: String
    var information: String
    var time: String
    
    init(title: String, host: String, information: String, time: String) {
        self.title = title;
        self.host = host
        self.information = information
        self.time = time
    }
    
    class func sample() -> Show {
        return Show(title: "Test show", host: "Neal Young", information: "Cool show", time: "10:00-12:00")
    }
}
