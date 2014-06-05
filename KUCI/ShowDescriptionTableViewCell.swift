//
//  ShowDescriptionTableViewCell.swift
//  KUCI
//
//  Created by Nealon Young on 6/4/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

class ShowDescriptionTableViewCell : UITableViewCell {
    @IBOutlet var textView: UITextView
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)  {
        textView.textColor = UIColor.redColor()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}