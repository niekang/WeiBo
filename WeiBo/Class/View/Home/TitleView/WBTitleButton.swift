//
//  WBTitleView.swift
//  WeiBo
//
//  Created by 聂康 on 2017/6/24.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    init(title:String?) {
        super.init(frame: CGRect())
        if title == nil {
            setTitle("首页", for: .normal)
        }else {
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)

            setTitle(title! + " ", for: .normal)
            setTitleColor(UIColor.darkGray, for: .normal)
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let _ = titleLabel?.text,
           let _ = imageView?.image else {
            return
        }
        
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = titleLabel!.bounds.width
    }
}
