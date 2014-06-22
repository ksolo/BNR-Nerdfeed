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
    var courses: AnyObject[] = []

    init(style: UITableViewStyle) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                [unowned self](data, response, error) -> Void in
                let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as Dictionary<String, AnyObject>
                
                if let courses = jsonObject["courses"] {
                    self.courses += courses
                }
            }
        )
        dataTask.resume()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }


}
