//
//  EmotionToolView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/29.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

protocol EmotionToolViewDelegate: NSObjectProtocol {
    
    func emotionToolViewDidSelectedItemIndex(toolView:EmotionToolView, index:Int);
    
}

class EmotionToolView: UIView {
    
    weak var delegate:EmotionToolViewDelegate?
    
    /// 选中分组索引
    var selectedIndex: Int = 0 {
        didSet {
            
            // 1. 取消所有的选中状态
            for btn in subviews as! [UIButton] {
                btn.isSelected = false
            }
            
            // 2. 设置 index 对应的选中状态
            (subviews[selectedIndex] as! UIButton).isSelected = true
        }
    }

    
    override func awakeFromNib() {
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count = subviews.count
        let w = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: bounds.height)
        
        for (i, btn) in subviews.enumerated() {
            btn.frame = rect.offsetBy(dx: CGFloat(i)*w, dy: 0)
        }
    }
    
    @objc func packageClick(btn:UIButton) {
        // 通知代理执行协议方法
        delegate?.emotionToolViewDidSelectedItemIndex(toolView: self, index: btn.tag)
    }
}

extension EmotionToolView {
    
    func setup() {
        let manager = EmotionManager.shared
        
        for (i, pack) in manager.packages.enumerated() {
            let btn = UIButton()
            btn.setTitle(pack.groupName, for: [])
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: [])
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            
            let imageName = "compose_emotion_table_\(pack.bgImageName ?? "")_normal"
            let imageHighlightedName = "compose_emotion_table_\(pack.bgImageName ?? "")_selected"
            
            var imageN = UIImage(named: imageName, in: manager.bundle, compatibleWith: nil)
            var imageH = UIImage(named: imageHighlightedName, in: manager.bundle, compatibleWith: nil)
            
            let size = imageN?.size ?? CGSize()
            
            let inset = UIEdgeInsets(top: size.height * 0.5,
                                     left: size.width * 0.5,
                                     bottom: size.height * 0.5,
                                     right: size.width * 0.5)
            imageN = imageN?.resizableImage(withCapInsets: inset)
            imageH = imageN?.resizableImage(withCapInsets: inset)
            
            btn.setBackgroundImage(imageN, for: [])
            btn.setBackgroundImage(imageH, for: .highlighted)
            btn.setBackgroundImage(imageH, for: .selected)
            
            btn.sizeToFit()
            addSubview(btn)
            btn.tag = i
            
            btn.addTarget(self, action: #selector(packageClick(btn:)), for: .touchUpInside)
        }
        
        // 默认选中第0个按钮
        (subviews[0] as! UIButton).isSelected = true

    }
    
}
