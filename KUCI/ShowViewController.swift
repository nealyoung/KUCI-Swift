//
//  ShowViewController.swift
//  KUCI
//
//  Created by Nealon Young on 6/3/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

class ShowViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView
    var show: Show?
    
    init(show: Show) {
        self.show = show
        super.init(nibName: nil, bundle: nil)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        title = show?.title
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        switch(section) {
        case 1:
            return "Info"
        default:
            return "Links"
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        if (indexPath.section == 0) {
            var cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as UITableViewCell
            
            switch(indexPath.row) {
            case 0:
                cell.textLabel.text = "Title"
                cell.detailTextLabel.text = show?.title
            case 1:
                cell.textLabel.text = "Host"
                cell.detailTextLabel.text = show?.host
            default:
                cell.textLabel.text = "Time"
                cell.detailTextLabel.text = show?.time
            }
            
            return cell
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("showDescriptionCell", forIndexPath: indexPath) as ShowDescriptionTableViewCell
            cell.descriptionLabel.text = show?.information
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return cell
        }
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        var view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 24.0))
        var label = UILabel(frame: CGRect(x: 15.0, y: 0.0, width: 280.0, height: 24.0))
        label.textColor = UIColor.whiteColor();
        label.font = UIFont.semiboldApplicationFont(15.0)
        label.text = tableView.dataSource.tableView!(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        
        return view;
    }
    
    var showDescriptionTableViewMetricsCell: ShowDescriptionTableViewCell?
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if (indexPath.section == 0) {
            return tableView.rowHeight
        }
        
        if showDescriptionTableViewMetricsCell == nil {
            showDescriptionTableViewMetricsCell = tableView.dequeueReusableCellWithIdentifier("showDescriptionCell") as? ShowDescriptionTableViewCell
        }
        
        showDescriptionTableViewMetricsCell!.bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 9999.0)
        showDescriptionTableViewMetricsCell!.descriptionLabel.text = show?.information

        showDescriptionTableViewMetricsCell!.setNeedsLayout()
        showDescriptionTableViewMetricsCell!.layoutIfNeeded()
        
        var height = showDescriptionTableViewMetricsCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        // Add 1 to the height to account for the row separator
        return max(height + 1.0, tableView.rowHeight)
    }
}
