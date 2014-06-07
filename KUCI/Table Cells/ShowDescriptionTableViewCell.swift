.//
//  ShowDescriptionTableViewCell.swift
//  KUCI
//
//  Created by Nealon Young on 6/4/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

class ShowDescriptionTableViewCell : UITableViewCell {
    @IBOutlet var descriptionLabel: UILabel
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the max layout width of the multi-line labels to their calculated width after auto layout has run
        descriptionLabel.preferredMaxLayoutWidth = descriptionLabel.frame.width
        
        self.layoutIfNeeded()
    }
}
