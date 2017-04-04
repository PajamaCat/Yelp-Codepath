//
//  RadioButton.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
  
  // Images
  let checkedImage = UIImage(named: "checked_radio")! as UIImage
  let uncheckedImage = UIImage(named: "unchecked_radio")! as UIImage
  
  // Bool property
  var isChecked: Bool = false {
    didSet{
      if isChecked == true {
        self.setImage(checkedImage, for: .normal)
      } else {
        self.setImage(uncheckedImage, for: .normal)
      }
    }
  }
  
  override func awakeFromNib() {
    self.isChecked = false
  }
  
  func buttonClicked(sender: UIButton) {
    if sender == self {
      isChecked = !isChecked
    }
  }

}
