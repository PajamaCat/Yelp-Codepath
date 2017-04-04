//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate, UISearchBarDelegate {
    
  var businesses: [Business]!
  var searchBar: UISearchBar!
  var filters: [String : AnyObject]?
  var term: String = "Restaurant"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
        
    Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
          for business in businesses {
              print(business.name!)
              print(business.address!)
          }
      }
    })
    
    searchBar = UISearchBar()
    searchBar.sizeToFit()
    searchBar.delegate = self
    
    navigationItem.titleView = searchBar
    
    /* Example of Yelp search with more search options specified
     Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
        
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.term = searchBar.text!
    
    if let filters = self.filters {
      searchWithFilters(filters: filters)
    } else {
      Business.searchWithTerm(term: term, completion: { (businesses: [Business]?, error: Error?) -> Void in
        self.businesses = businesses
        self.tableView.reloadData()
        if let businesses = businesses {
          for business in businesses {
            print(business.name!)
            print(business.address!)
          }
        }
      })
    }
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if businesses != nil {
      return businesses!.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
    cell.business = businesses[indexPath.row]
    return cell
  }
    
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let navigationController = segue.destination as! UINavigationController
    let filterViewController = navigationController.topViewController as! FilterViewController
    
    filterViewController.delegate = self
  }
  
  
  func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
    searchWithFilters(filters: filters)
  }
  
  func searchWithFilters(filters: [String : AnyObject]) {
    let categories = filters["categories"] as? [String]
    let sort = filters["sortby"] as? YelpSortMode
    let deals = filters["deal"] as? Bool
    let distance = filters["radius"] as? Float
    
    Business.searchWithTerm(term: term, distance: distance, sort: sort, categories: categories, deals: deals, completion: {
      (businesses: [Business]?, error: Error?) -> Void in
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
        for business in businesses {
          print(business.name!)
          print(business.address!)
        }
      }
    })
  }
}
