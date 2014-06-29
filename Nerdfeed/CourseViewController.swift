//
//  CourceViewControllerTableViewController.swift
//  Nerdfeed
//
//  Created by Kevin Solorio on 6/22/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController {
    
    let session: NSURLSession
    var courses: NSArray = []

    init(style: UITableViewStyle) {
        self.session = NSURLSession.sharedSession()
        
        super.init(style: style)
        self.navigationItem.title = "BNR Courses"
        
        self.fetchData()
    }
    
    init(nibName: String?, bundle: NSBundle?) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
        super.init(nibName: nibName, bundle: bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let requestString = "http://bookapi.bignerdranch.com/courses.json"
        let url = NSURL(string: requestString)
        let req = NSURLRequest(URL: url)
        
        let dataTask = self.session.dataTaskWithRequest(req, completionHandler:
            {
                data, response, error -> Void in
                let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                var courses: NSArray = jsonObject["courses"] as NSArray
                self.courses = courses
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in self.tableView.reloadData()})
            }
        )
        dataTask.resume()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.courses.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as? UITableViewCell
        let course = self.courses[indexPath.row] as NSDictionary
        
        if !cell {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "UITableViewCell")
        }
        
        cell!.textLabel.text = course["title"] as String
        return cell!
    }


}
