//
//  WBComposeBtnView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/26.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBComposeBtnView: UIControl {

    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var label: UILabel!
    
    /// 跳转控制器的类型
    var clsName: String?

    class func composeBtnView(imageName:String, title:String) -> WBComposeBtnView {
        let nib = UINib(nibName: "WBComposeBtnView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil).first as! WBComposeBtnView
        v.imageView.image = UIImage(named: imageName)
        v.label.text = title
        return v
    }
    
   
}
