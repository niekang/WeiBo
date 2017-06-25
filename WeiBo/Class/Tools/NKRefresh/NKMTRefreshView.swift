
//
//  NKMTRefreshView.swift
//  NKRefresh
//
//  Created by 聂康 on 2017/6/25.
//  Copyright © 2017年 聂康. All rights reserved.
//

import UIKit

class NKMTRefreshView: NKRefreshView {

    @IBOutlet weak var houseView: UIImageView!

    @IBOutlet weak var earthView: UIImageView!

    @IBOutlet weak var kangarooView: UIImageView!
    
    /// 父视图高度
    override var parentViewHeight: CGFloat {
        didSet {
            print("父视图高度 \(parentViewHeight)")
            
            if parentViewHeight < 50 {
                return
            }
            
            // 23 -> 126
            // 0.2 -> 1
            // 高度差 / 最大高度差
            // 23 == 1 -> 0.2
            // 126 == 0 -> 1
            var scale: CGFloat
            
            if parentViewHeight > 120 {
                scale = 1
            } else {
                scale = 1 - ((120 - parentViewHeight) / (120 - 50))
            }
            
            kangarooView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
        
    override func awakeFromNib() {
        let image1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let image2 = #imageLiteral(resourceName: "icon_building_loading_2")
        houseView.image = UIImage.animatedImage(with: [image1,image2], duration: 0.5)
        
        let anima = CABasicAnimation(keyPath: "transform.rotation")
        anima.toValue = -2 * Double.pi
        anima.repeatCount = MAXFLOAT
        anima.duration = 5
        earthView.layer.add(anima, forKey: "anima")
        
        let image3 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let image4 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        kangarooView.image = UIImage.animatedImage(with: [image3,image4], duration: 0.5)
        
        //设置锚点
        kangarooView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        //设置 center
        let x = bounds.width * 0.5
        let y = bounds.height - 30
        kangarooView.center = CGPoint(x: x, y: y)

        kangarooView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

    }
    
    
    
}
