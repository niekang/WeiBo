//
//  WBWelcomView.swift
//  WeiBo
//
//  Created by 聂康 on 2017/6/24.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBWelcomView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    
    @IBOutlet weak var welcomLabel: UILabel!
    
    
    class func welcomeView() -> WBWelcomView{
        let nib = UINib(nibName: "WBWelcomView", bundle: nil)
        
        let welcomeView = nib.instantiate(withOwner: nil, options: nil).first
        
        return welcomeView as! WBWelcomView
    }
    
    override func awakeFromNib() {
        iconView.layer.cornerRadius = iconView.width * 0.5
        iconView.layer.masksToBounds = true
        guard let avatar = WBUserAccont.shared.avatar_large,
            let url = URL(string: avatar) else {
            return
        }
        /// 设置用户头像
        iconView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "avatar_default_big"))
        
    }
    
    override func didMoveToWindow() {
        
        //强制更新约束
        self.layoutIfNeeded()
        
        bottomConstant.constant = UIScreen.main.bounds.size.height - 200
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.layoutIfNeeded()
        }) { (_) in
            
            UIView.animate(withDuration: 1, animations: { 
                self.welcomLabel.alpha = 1
            }, completion: { (_) in
                self.perform(#selector(self.removeFromSuperview), with: nil, afterDelay: 1)
            })
        }
    }
    
}
