//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Search bar
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "What are you looking for?"
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        
        // The next 2 lines should go together
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: [], deals: true, completion: self.onData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Data received
    func onData(businesses: [Business]!, error: NSError!) -> Void {
        self.businesses = businesses
        self.tableView.reloadData()
        
        for business in businesses {
            print(business.name!)
            print(business.address!)
            print(business.categories!)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Business.searchWithTerm(searchText, sort: .Distance, categories: [], deals: nil, completion: self.onData)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessTableViewCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let deals = (filters["deals"] as? Bool)!
        let categories = (filters["categories"] as? [String])!
        let distance = (filters["distance"] as? Int)!

        let sortBy = (filters["sortBy"] as? YelpSortMode)
        
        Business.searchWithTerm("Restaurant", sort: sortBy, categories: categories, deals: deals, completion: self.onData)
    }
}



