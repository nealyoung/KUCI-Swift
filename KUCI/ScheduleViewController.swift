//
//  ScheduleViewController.swift
//  KUCI
//
//  Created by Nealon Young on 6/2/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let donationURLString = "http://www.kuci.org/paypal/fund_drive/index.shtml"
    
    @IBOutlet var tableView: UITableView
    var schedule: Array<Array<Show>>
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        schedule = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(coder aDecoder: NSCoder!) {
        schedule = []
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
        
        var donateButton = UIBarButtonItem(title: "Donate", style: .Plain, target: self, action: "donateButtonPressed")
        navigationItem.leftBarButtonItem = donateButton
        
        var todayButton = UIBarButtonItem(title: "Today", style: .Plain, target: self, action: "todayButtonPressed")
        navigationItem.rightBarButtonItem = todayButton
        
        ScheduleParser.allShowsWithCompletion { (shows: Array<AnyObject>?) in
            self.schedule = shows as Array<Array<Show>>
            self.tableView.reloadData()
        }
    }
    
    // Actions
    
    func donateButtonPressed() {
        var donationURL = NSURL(string: donationURLString)
        UIApplication.sharedApplication().openURL(donationURL)
    }
    
    func todayButtonPressed() {
        var currentDay = NSCalendar.currentCalendar().components(.WeekdayCalendarUnit, fromDate: NSDate()).weekday
        
        // Set section to the appropriate section (Monday = 0, Sunday = 6)
        switch (currentDay) {
        case 1:
            currentDay = 6;
        case 2:
            currentDay = 0;
        case 3:
            currentDay = 1;
        case 4:
            currentDay = 2;
        case 5:
            currentDay = 3;
        case 6:
            currentDay = 4;
        case 7:
            currentDay = 5;
        default:
            break
        }
        
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: currentDay), atScrollPosition: .Top, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var showViewController = segue.destinationViewController as ShowViewController
        var selectedIndexPath = tableView.indexPathForSelectedRow()
        showViewController.show = self.schedule[selectedIndexPath.section][selectedIndexPath.row]
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return schedule.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return days[section]
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return schedule[section].count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var show = schedule[indexPath.section][indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("showCell", forIndexPath: indexPath) as ShowTableViewCell
        cell.titleLabel.text = show.title
        cell.hostLabel.text = show.host
        cell.timeLabel.text = show.time
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell;
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
    
    var showTableViewMetricsCell: ShowTableViewCell?
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if showTableViewMetricsCell == nil {
            showTableViewMetricsCell = tableView.dequeueReusableCellWithIdentifier("showCell") as? ShowTableViewCell
        }

        showTableViewMetricsCell!.bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 9999.0)
        
        var show = schedule[indexPath.section][indexPath.row]
        showTableViewMetricsCell!.titleLabel.text = show.title
        showTableViewMetricsCell!.hostLabel.text = show.host
        showTableViewMetricsCell!.timeLabel.text = show.time
        
        showTableViewMetricsCell!.setNeedsLayout()
        showTableViewMetricsCell!.layoutIfNeeded()
        
        var height = showTableViewMetricsCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        println(tableView.rowHeight)
        
        // Add 1 to the height to account for the row separator
        return height + 1.0
    }
}
