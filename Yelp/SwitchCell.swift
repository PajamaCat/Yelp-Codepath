//
//  SwitchCell.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategorySwitchCellDelegate {
  @objc optional func categorySwitchCell(categorySwitchCell: SwitchCell, didChangeValue value: Bool)
}

@objc protocol DealSwitchCellDelegate {
  @objc optional func dealSwitchCell(dealSwitchCell: SwitchCell, didChangeValue value: Bool)
}


class SwitchCell: UITableViewCell {

  @IBOutlet weak var dealSwitchLabel: UILabel!
  @IBOutlet weak var categorySwitchLabel: UILabel!
  @IBOutlet weak var dealSwitch: UISwitch!
  @IBOutlet weak var categorySwitch: UISwitch!
  weak var categorySwitchCellDelegate : CategorySwitchCellDelegate?
  weak var dealSwitchCellDelegate : DealSwitchCellDelegate?
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    
  }

  @IBAction func onCategorySwitchValueChanged(_ sender: UISwitch) {
    print("fired on category")
    categorySwitchCellDelegate?.categorySwitchCell?(categorySwitchCell: self, didChangeValue: categorySwitch.isOn)
  }
  
  @IBAction func onDealSwitchValueChanged(_ sender: UISwitch) {
    print("fired on deal")
    dealSwitchCellDelegate?.dealSwitchCell?(dealSwitchCell: self, didChangeValue: dealSwitch.isOn)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
