//
//  WBStatusPictureView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/22.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

//配图视图与WBStatusPictureView顶部的间距
let outMargin = 12 as CGFloat
//配图之间的间距
let innerMargin = 5 as CGFloat
//配图视图的宽度
let picViewWidth = UIScreen.main.bounds.width - 2 * outMargin
//每张配图的宽度
let imageWidth = (picViewWidth - 2 * innerMargin)/3


class WBStatusPictureView: UIView {
    
    var statusViewModel:WBStatusViewModel? {
        didSet{
            
            guard let statusViewModel = statusViewModel,
                let urls = statusViewModel.picURLs else{
                    heightConstraint.constant = 0
                return
            }
                        
            for v in subviews {
                v.isHidden = true
            }
            
            if urls.count == 1 {
                let imageView = subviews[0] as! UIImageView
                imageView.frame = CGRect(x: 0,
                                         y: outMargin,
                                         width: statusViewModel.pictureViewSize.width,
                                         height: statusViewModel.pictureViewSize.height - outMargin)
            }else {
                let imageView = subviews[0] as! UIImageView
                imageView.frame = CGRect(x: 0,
                                         y: outMargin,
                                         width: imageWidth,
                                         height: imageWidth)
            }
            
            for (i, url) in urls.enumerated() {
                var index = i
                //4张配图的时候特殊处理
                if (i == 2 || i == 3) && urls.count == 4 {
                    index = i + 1
                }
                let imageView = subviews[index] as! UIImageView
                imageView.nk_setImage(URLString: url.thumbnail_pic, placeholderImageName: nil)
                imageView.isHidden = false
                
            }

            
            heightConstraint.constant = statusViewModel.pictureViewSize.height
          
        }
    }

    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = superview?.backgroundColor
        clipsToBounds = true
        for i in 0..<9 {
            let row = i/3 + 1
            let colume = i%3
            let rect = CGRect(x: CGFloat(colume) * (imageWidth + innerMargin), y: CGFloat(row - 1) * (imageWidth + innerMargin) + outMargin , width: imageWidth, height: imageWidth)
            let imageView = UIImageView(frame: rect)
            addSubview(imageView)
        }
    }
    
    
}
