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
let width = UIScreen.main.bounds.width - 2 * outMargin
//每张配图的宽度
let imageWidth = (width - 2 * innerMargin)/3


class WBStatusPictureView: UIView {
    
    var pic_urls:[WBStatusPicture]? {
        didSet{
            guard let urls = pic_urls else{
                return
            }
            
            let count = urls.count
            heightConstraint.constant = caculatePictureViewHeight(count: count)
            
            for v in subviews {
                v.isHidden = true
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
        }
    }

    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        setupUI()
    }
    
    func setupUI() {
        clipsToBounds = true
        for i in 0..<9 {
            let row = i/3 + 1
            let colume = i%3
            let rect = CGRect(x: CGFloat(colume) * (imageWidth + innerMargin), y: CGFloat(row - 1) * (imageWidth + innerMargin) + outMargin , width: imageWidth, height: imageWidth)
            let imageView = UIImageView(frame: rect)
            addSubview(imageView)
            
            imageView.backgroundColor = UIColor.green
        }
    }
    
    
    /// 计算配图视图高度
    ///
    /// - Parameter count: 配图数量
    /// - Returns: 高度
    func caculatePictureViewHeight(count:Int) -> CGFloat{
        if count == 0 {
            return 0
        }
        //计算行数
        let row = (count - 1)/3 + 1
        //计算高度
        let viewHeight = outMargin + CGFloat(row) * imageWidth + innerMargin * (CGFloat(row) - 1)
        
        return viewHeight
    }
}
