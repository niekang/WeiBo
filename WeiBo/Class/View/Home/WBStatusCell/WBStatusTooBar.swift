//
//  WBStatusTooBar.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusTooBar: UIView {
    
    var statusViewModel:WBStatusViewModel? {
        didSet{
            retweetedBtn.setTitle(statusViewModel?.retweetedStr, for: .normal)
            commentBtn.setTitle(statusViewModel?.commentStr, for: .normal)
            likeBtn.setTitle(statusViewModel?.likeStr, for: .normal)
        }
    }

    @IBOutlet weak var retweetedBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
  
}
