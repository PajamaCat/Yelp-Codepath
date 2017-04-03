//
//  SelectionCell.swift
//  Yelp
//
//  Created by jiafang_jiang on 4/3/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell {

  
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var distanceButton: RadioButton!
  @IBOutlet weak var sortbyLabel: UILabel!
  @IBOutlet weak var sortbyButton: RadioButton!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }
  @IBAction func onDistanceButtonClicked(_ sender: RadioButton) {
    sender.buttonClicked(sender: sender)
  }
  
  @IBAction func onSortbyButtonClicked(_ sender: RadioButton) {
        sender.buttonClicked(sender: sender)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
