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
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        titleLabel.font = UIFont.semiboldApplicationFont(16.0)
        hostLabel.font = UIFont.semiboldApplicationFont(15.0)
        timeLabel.font = UIFont.applicationFont(16.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the max layout width of the multi-line labels to their calculated width after auto layout has run
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.width
        hostLabel.preferredMaxLayoutWidth = hostLabel.frame.width
        
        self.layoutIfNeeded()
    }
}
