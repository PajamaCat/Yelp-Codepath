//
//  Distance.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class Distance: NSObject {
  
  let displayName: String?
  let meterValue: Float?
  var isSelected: Bool?
  
  init(displayName: String, meterValue: Float, isSelected: Bool) {
    self.displayName = displayName
    self.meterValue = meterValue
    self.isSelected = isSelected
  }

}
