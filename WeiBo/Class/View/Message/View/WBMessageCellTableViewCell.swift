//
//  WBMessageCellTableViewCell.swift
//  WeiBo
//
//  Created by 聂康 on 2019/9/9.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

class WBMessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    
    var model: WBMessage? {
        didSet {
            guard let model = self.model else {
                return
            }
            
            if let image = model.icon {
                self.iconView.image = UIImage(named: image)
            }
            self.titleLabel.text = model.title
            self.desLabel.text = model.detail
        }
    }
    
}
