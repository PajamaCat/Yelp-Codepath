//
//  SortMode.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class SortMode: NSObject {
  let displayName: String?
  let yelpSortMode: YelpSortMode?
  var isSelected: Bool?
  
  init(displayName: String, yelpSortMode: YelpSortMode, isSelected: Bool) {
    self.displayName = displayName
    self.yelpSortMode = yelpSortMode
    self.isSelected = isSelected
  }
}
