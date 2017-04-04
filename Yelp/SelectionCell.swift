//
//  SelectionCell.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceSelectionCellDelegate {
    @objc optional func disdanceSelectionCell(disdanceSelectionCell: SelectionCell, didChangeValue value: Bool)
}

@objc protocol SortbySelectionCellDelegate {
    @objc optional func sortbySelectionCell(sortbySelectionCell: SelectionCell, didChangeValue value: Bool)
}

class SelectionCell: UITableViewCell {

  
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var distanceButton: RadioButton!
  @IBOutlet weak var sortbyLabel: UILabel!
  @IBOutlet weak var sortbyButton: RadioButton!
    
  weak var distanceDelegate: DistanceSelectionCellDelegate?
  weak var sortbyDelegate: SortbySelectionCellDelegate?
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }
  
  func onDistanceButtonClicked(_ sender: RadioButton) {
    sender.buttonClicked(sender: sender)
    distanceDelegate?.disdanceSelectionCell?(disdanceSelectionCell: self, didChangeValue: true)
  }
  
  func onSortbyButtonClicked(_ sender: RadioButton) {
    sender.buttonClicked(sender: sender)
    sortbyDelegate?.sortbySelectionCell?(sortbySelectionCell: self, didChangeValue: true)
  }
  
  func resetDistanceButton() {
    distanceButton.isChecked = false
  }
  
  func resetSortbyButton() {
    sortbyButton.isChecked = false
  }
  
  func isDistanceChecked() -> Bool {
    return distanceButton.isChecked
  }
  
  func isSortbyChecked() -> Bool {
    return sortbyButton.isChecked
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
