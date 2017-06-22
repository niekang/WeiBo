//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    
    var statusViewModel:WBStatusViewModel? {
        didSet{
            guard let count = statusViewModel?.picURLs?.count else{
                return
            }
            heightConstraint.constant = caculatePictureViewHeight(count: count)
        }
    }

    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    
    
    func caculatePictureViewHeight(count:Int) -> CGFloat{
        if count == 0 {
            return 0
        }
        //配图视图与外部的间距
        let outMargin = 12 as CGFloat
        //配图之间的间距
        let innerMargin = 5 as CGFloat
        //配图视图的宽度
        let width = UIScreen.main.bounds.width - 2 * outMargin
        //每张配图的宽度
        let imageWidth = (width - 2 * innerMargin)/3
        //计算行数
        let row = (count - 1)/3 + 1
        //计算高度
        let viewHeight = outMargin + CGFloat(row) * imageWidth + innerMargin * (CGFloat(row) - 1)
        
        return viewHeight
    }
}
