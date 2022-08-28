//
//  ActivityTableViewCell.swift
//  BikeTracker
//
//  Created by Misael Pérez Chamorro on 28/08/22.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var initialLocationLabel: UILabel!
  @IBOutlet weak var finalLocationLabel: UILabel!
  @IBOutlet weak var distance: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
  }

  func bind(activity: Activity) {
    timeLabel.text = activity.time
    initialLocationLabel.text = activity.startLocation
    finalLocationLabel.text = activity.finishLocation
  }
}
