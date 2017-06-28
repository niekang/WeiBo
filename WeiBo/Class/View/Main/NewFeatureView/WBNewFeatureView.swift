//
//  WBNewFeatureView.swift
//  WeiBo
//
//  Created by 聂康 on 2017/6/24.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var enterWB: (() -> ())?
    
    
    /// 从xib加载视图
    ///
    /// - Parameter enterWB: 进入app回调
    /// - Returns: 返回视图
    class func newFeatureView(enterWB:(() -> ())? = nil) -> WBNewFeatureView{
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let welcomeView = (nib.instantiate(withOwner: nil, options: nil).first) as! WBNewFeatureView
        if let enterWB = enterWB {
            welcomeView.enterWB = enterWB
        }
        
        return welcomeView
    }
    
    /// 布局scrollView
    override func awakeFromNib() {
        let rect = UIScreen.main.bounds
        for i in 0..<4 {
            let imageView = UIImageView(image: UIImage(named: "new_feature_\(i + 1)"))
            imageView.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: rect.width * (4 + 1), height: rect.height)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        enterBtn.isHidden = true
    }

    /// 进入微博按钮点击
    @IBAction func enterBtnClick(_ sender: Any) {
        removeFromSuperview()
        enterWB?()
    }
}

extension WBNewFeatureView:UIScrollViewDelegate {
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// 计算当前在哪一页
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        if page == scrollView.subviews.count {
            removeFromSuperview()
            enterWB?()
        }
        
        enterBtn.isHidden = (page != scrollView.subviews.count - 1)
        pageControl.currentPage = page

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > CGFloat(scrollView.subviews.count - 1) * scrollView.bounds.width {
            removeFromSuperview()
            enterWB?()
        }
    }
    
}
