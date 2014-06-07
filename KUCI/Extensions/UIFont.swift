//
//  UIFont.swift
//  KUCI
//
//  Created by Nealon Young on 6/3/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func applicationFont(size: Float) -> UIFont {
        return UIFont(name: "SourceSansPro-Regular", size: size)
    }
    
    class func semiboldApplicationFont(size: Float) -> UIFont {
        return UIFont(name: "SourceSansPro-Semibold", size: size)
    }
    
    class func boldApplicationFont(size: Float) -> UIFont {
        return UIFont(name: "SourceSansPro-Bold", size: size)
    }
}
