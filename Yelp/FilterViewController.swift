//
//  FilterViewController.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
  @objc optional func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject])
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategorySwitchCellDelegate, DealSwitchCellDelegate {
  
  let numSections = 4
  let HeaderViewIdentifier = "TableViewHeaderView"
  
  var distances: [(String, Float)]!
  var sortMode: [(String, YelpSortMode)]!
  var categories: [[String: String]]!
  var switchStates = [Int: Bool]()
  var dealSwitchState = false
  
  weak var delegate: FilterViewControllerDelegate?

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
      super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
    
    categories = yelpCategories()
    distances = yelpDistances()
    sortMode = yelpSortMode()
    
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  

  @IBAction func onCancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onSearch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    var filters = [String : AnyObject]()
    
    // deals
    if (dealSwitchState)
    
    // categories
    var selectedCategories = [String]()
    for (row, isSelected) in switchStates {
      if isSelected {
        selectedCategories.append(categories[row]["code"]!)
      }
    }
    
    if selectedCategories.count > 0 {
      filters["categories"] = selectedCategories as AnyObject?
    }
    delegate?.filterViewController!(filterViewController: self, didUpdateFilters: filters)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      return distances.count
    } else if section == 2 {
      return sortMode.count
    }
    return categories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DealSwitchCell", for: indexPath) as! SwitchCell
      cell.dealSwitchCellDelegate = self
      cell.dealSwitchLabel.text = "Offering a deal"
      cell.dealSwitch.isOn = dealSwitchState
      return cell
    } else if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell", for: indexPath) as! SelectionCell
      cell.distanceLabel.text = distances[indexPath.row].0
      return cell
    } else if indexPath.section == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SortbyCell", for: indexPath) as! SelectionCell
      cell.sortbyLabel.text = sortMode[indexPath.row].0
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySwitchCell", for: indexPath) as! SwitchCell
      cell.categorySwitchCellDelegate = self
      cell.categorySwitchLabel.text = categories[indexPath.row]["name"]
      cell.categorySwitch.isOn = switchStates[indexPath.row] ?? false
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return nil
    }
    
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewIdentifier)! as UITableViewHeaderFooterView
    
    switch section {
      case 1:
        header.textLabel?.text = "Distance"
        break
      case 2:
        header.textLabel?.text = "Sort by"
        break
      case 3:
        header.textLabel?.text = "Categories"
        break
      default:
        header.textLabel?.text = nil
    }
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 0
    }
    return 30
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return numSections
  }
  
  func categorySwitchCell(categorySwitchCell: SwitchCell, didChangeValue value: Bool) {
    let indexPath = tableView.indexPath(for: categorySwitchCell)!
    
    switchStates[indexPath.row] = value
    print("value changed for row \(indexPath.row) with value \(value)")
  }
  
  func dealSwitchCell(dealSwitchCell: SwitchCell, didChangeValue value: Bool) {
    let indexPath = tableView.indexPath(for: dealSwitchCell)!
    
    dealSwitchState = value
    print("value changed for row \(indexPath.row) with value \(value)")
  }
  
  func yelpSortMode() -> [(String, YelpSortMode)] {
    return [("Best Matched", YelpSortMode.bestMatched),
            ("Distance", YelpSortMode.distance),
            ("Highest Rated", YelpSortMode.highestRated)]
  }
  
  func yelpDistances() -> [(String, Float)] {
    return [("Auto", 0),
            ("0.3 miles", 482.8),
            ("1 mile", 1609.34),
            ("5 miles", 8046.72),
            ("20 miles", 32186.9)]
  }
  
  func yelpCategories() -> [[String : String]] {
    return [["name" : "Afghan", "code": "afghani"],
           ["name" : "African", "code": "african"],
           ["name" : "American, New", "code": "newamerican"],
           ["name" : "American, Traditional", "code": "tradamerican"],
           ["name" : "Arabian", "code": "arabian"],
           ["name" : "Argentine", "code": "argentine"],
           ["name" : "Armenian", "code": "armenian"],
           ["name" : "Asian Fusion", "code": "asianfusion"],
           ["name" : "Asturian", "code": "asturian"],
           ["name" : "Australian", "code": "australian"],
           ["name" : "Austrian", "code": "austrian"],
           ["name" : "Baguettes", "code": "baguettes"],
           ["name" : "Bangladeshi", "code": "bangladeshi"],
           ["name" : "Barbeque", "code": "bbq"],
           ["name" : "Basque", "code": "basque"],
           ["name" : "Bavarian", "code": "bavarian"],
           ["name" : "Beer Garden", "code": "beergarden"],
           ["name" : "Beer Hall", "code": "beerhall"],
           ["name" : "Beisl", "code": "beisl"],
           ["name" : "Belgian", "code": "belgian"],
           ["name" : "Bistros", "code": "bistros"],
           ["name" : "Black Sea", "code": "blacksea"],
           ["name" : "Brasseries", "code": "brasseries"],
           ["name" : "Brazilian", "code": "brazilian"],
           ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
           ["name" : "British", "code": "british"],
           ["name" : "Buffets", "code": "buffets"],
           ["name" : "Bulgarian", "code": "bulgarian"],
           ["name" : "Burgers", "code": "burgers"],
           ["name" : "Burmese", "code": "burmese"],
           ["name" : "Cafes", "code": "cafes"],
           ["name" : "Cafeteria", "code": "cafeteria"],
           ["name" : "Cajun/Creole", "code": "cajun"],
           ["name" : "Cambodian", "code": "cambodian"],
           ["name" : "Canadian", "code": "New)"],
           ["name" : "Canteen", "code": "canteen"],
           ["name" : "Caribbean", "code": "caribbean"],
           ["name" : "Catalan", "code": "catalan"],
           ["name" : "Chech", "code": "chech"],
           ["name" : "Cheesesteaks", "code": "cheesesteaks"],
           ["name" : "Chicken Shop", "code": "chickenshop"],
           ["name" : "Chicken Wings", "code": "chicken_wings"],
           ["name" : "Chilean", "code": "chilean"],
           ["name" : "Chinese", "code": "chinese"],
           ["name" : "Comfort Food", "code": "comfortfood"],
           ["name" : "Corsican", "code": "corsican"],
           ["name" : "Creperies", "code": "creperies"],
           ["name" : "Cuban", "code": "cuban"],
           ["name" : "Curry Sausage", "code": "currysausage"],
           ["name" : "Cypriot", "code": "cypriot"],
           ["name" : "Czech", "code": "czech"],
           ["name" : "Czech/Slovakian", "code": "czechslovakian"],
           ["name" : "Danish", "code": "danish"],
           ["name" : "Delis", "code": "delis"],
           ["name" : "Diners", "code": "diners"],
           ["name" : "Dumplings", "code": "dumplings"],
           ["name" : "Eastern European", "code": "eastern_european"],
           ["name" : "Ethiopian", "code": "ethiopian"],
           ["name" : "Fast Food", "code": "hotdogs"],
           ["name" : "Filipino", "code": "filipino"],
           ["name" : "Fish & Chips", "code": "fishnchips"],
           ["name" : "Fondue", "code": "fondue"],
           ["name" : "Food Court", "code": "food_court"],
           ["name" : "Food Stands", "code": "foodstands"],
           ["name" : "French", "code": "french"],
           ["name" : "French Southwest", "code": "sud_ouest"],
           ["name" : "Galician", "code": "galician"],
           ["name" : "Gastropubs", "code": "gastropubs"],
           ["name" : "Georgian", "code": "georgian"],
           ["name" : "German", "code": "german"],
           ["name" : "Giblets", "code": "giblets"],
           ["name" : "Gluten-Free", "code": "gluten_free"],
           ["name" : "Greek", "code": "greek"],
           ["name" : "Halal", "code": "halal"],
           ["name" : "Hawaiian", "code": "hawaiian"],
           ["name" : "Heuriger", "code": "heuriger"],
           ["name" : "Himalayan/Nepalese", "code": "himalayan"],
           ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
           ["name" : "Hot Dogs", "code": "hotdog"],
           ["name" : "Hot Pot", "code": "hotpot"],
           ["name" : "Hungarian", "code": "hungarian"],
           ["name" : "Iberian", "code": "iberian"],
           ["name" : "Indian", "code": "indpak"],
           ["name" : "Indonesian", "code": "indonesian"],
           ["name" : "International", "code": "international"],
           ["name" : "Irish", "code": "irish"],
           ["name" : "Island Pub", "code": "island_pub"],
           ["name" : "Israeli", "code": "israeli"],
           ["name" : "Italian", "code": "italian"],
           ["name" : "Japanese", "code": "japanese"],
           ["name" : "Jewish", "code": "jewish"],
           ["name" : "Kebab", "code": "kebab"],
           ["name" : "Korean", "code": "korean"],
           ["name" : "Kosher", "code": "kosher"],
           ["name" : "Kurdish", "code": "kurdish"],
           ["name" : "Laos", "code": "laos"],
           ["name" : "Laotian", "code": "laotian"],
           ["name" : "Latin American", "code": "latin"],
           ["name" : "Live/Raw Food", "code": "raw_food"],
           ["name" : "Lyonnais", "code": "lyonnais"],
           ["name" : "Malaysian", "code": "malaysian"],
           ["name" : "Meatballs", "code": "meatballs"],
           ["name" : "Mediterranean", "code": "mediterranean"],
           ["name" : "Mexican", "code": "mexican"],
           ["name" : "Middle Eastern", "code": "mideastern"],
           ["name" : "Milk Bars", "code": "milkbars"],
           ["name" : "Modern Australian", "code": "modern_australian"],
           ["name" : "Modern European", "code": "modern_european"],
           ["name" : "Mongolian", "code": "mongolian"],
           ["name" : "Moroccan", "code": "moroccan"],
           ["name" : "New Zealand", "code": "newzealand"],
           ["name" : "Night Food", "code": "nightfood"],
           ["name" : "Norcinerie", "code": "norcinerie"],
           ["name" : "Open Sandwiches", "code": "opensandwiches"],
           ["name" : "Oriental", "code": "oriental"],
           ["name" : "Pakistani", "code": "pakistani"],
           ["name" : "Parent Cafes", "code": "eltern_cafes"],
           ["name" : "Parma", "code": "parma"],
           ["name" : "Persian/Iranian", "code": "persian"],
           ["name" : "Peruvian", "code": "peruvian"],
           ["name" : "Pita", "code": "pita"],
           ["name" : "Pizza", "code": "pizza"],
           ["name" : "Polish", "code": "polish"],
           ["name" : "Portuguese", "code": "portuguese"],
           ["name" : "Potatoes", "code": "potatoes"],
           ["name" : "Poutineries", "code": "poutineries"],
           ["name" : "Pub Food", "code": "pubfood"],
           ["name" : "Rice", "code": "riceshop"],
           ["name" : "Romanian", "code": "romanian"],
           ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
           ["name" : "Rumanian", "code": "rumanian"],
           ["name" : "Russian", "code": "russian"],
           ["name" : "Salad", "code": "salad"],
           ["name" : "Sandwiches", "code": "sandwiches"],
           ["name" : "Scandinavian", "code": "scandinavian"],
           ["name" : "Scottish", "code": "scottish"],
           ["name" : "Seafood", "code": "seafood"],
           ["name" : "Serbo Croatian", "code": "serbocroatian"],
           ["name" : "Signature Cuisine", "code": "signature_cuisine"],
           ["name" : "Singaporean", "code": "singaporean"],
           ["name" : "Slovakian", "code": "slovakian"],
           ["name" : "Soul Food", "code": "soulfood"],
           ["name" : "Soup", "code": "soup"],
           ["name" : "Southern", "code": "southern"],
           ["name" : "Spanish", "code": "spanish"],
           ["name" : "Steakhouses", "code": "steak"],
           ["name" : "Sushi Bars", "code": "sushi"],
           ["name" : "Swabian", "code": "swabian"],
           ["name" : "Swedish", "code": "swedish"],
           ["name" : "Swiss Food", "code": "swissfood"],
           ["name" : "Tabernas", "code": "tabernas"],
           ["name" : "Taiwanese", "code": "taiwanese"],
           ["name" : "Tapas Bars", "code": "tapas"],
           ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
           ["name" : "Tex-Mex", "code": "tex-mex"],
           ["name" : "Thai", "code": "thai"],
           ["name" : "Traditional Norwegian", "code": "norwegian"],
           ["name" : "Traditional Swedish", "code": "traditional_swedish"],
           ["name" : "Trattorie", "code": "trattorie"],
           ["name" : "Turkish", "code": "turkish"],
           ["name" : "Ukrainian", "code": "ukrainian"],
           ["name" : "Uzbek", "code": "uzbek"],
           ["name" : "Vegan", "code": "vegan"],
           ["name" : "Vegetarian", "code": "vegetarian"],
           ["name" : "Venison", "code": "venison"],
           ["name" : "Vietnamese", "code": "vietnamese"],
           ["name" : "Wok", "code": "wok"],
           ["name" : "Wraps", "code": "wraps"],
           ["name" : "Yugoslav", "code": "yugoslav"]]
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
