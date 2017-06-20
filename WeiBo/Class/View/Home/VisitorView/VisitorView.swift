//
//  VisitorView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    var visitorInfoDictionary:[String:String]?{
        didSet{
            if let imageName = visitorInfoDictionary?["image"] {
                imageView.image = UIImage(named:imageName)
            }else {
                startAnimation()
            }
        }
    }
    
    lazy var imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    lazy var tipLab = UILabel().nk_fontSize(14)

    lazy var registerBtn = UIButton().nk_title("注册").nk_textColor(UIColor.orange).nk_backgroundImage("common_button_white_disable")
    
    lazy var logBtn = UIButton().nk_title("登录").nk_textColor(UIColor.orange).nk_backgroundImage("common_button_white_disable")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension VisitorView {
    
    func setup() {
        addSubview(imageView)
        addSubview(tipLab)
        addSubview(registerBtn)
        addSubview(logBtn)
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0))

    }
    
    func startAnimation() {
    
    }
    
    func resisterBtnClick(sender:UIButton) {
        
    }
    
    func logBtnClick(sender:UIButton) {
    
    }
    
}
