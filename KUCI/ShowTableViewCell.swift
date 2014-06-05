//
//  ShowTableViewCell.swift
//  KUCI
//
//  Created by Nealon Young on 6/3/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

class ShowTableViewCell : UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var hostLabel: UILabel
    @IBOutlet var timeLabel: UILabel

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the max layout width of the multi-line labels to their calculated width after auto layout has run
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.width
        hostLabel.preferredMaxLayoutWidth = hostLabel.frame.width
        
        self.layoutIfNeeded()
    }
}
