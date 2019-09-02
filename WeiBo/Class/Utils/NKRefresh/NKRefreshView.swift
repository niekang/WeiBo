
//
//  NKRefreshView.swift
//  NKRefresh
//
//  Created by 聂康 on 2017/6/25.
//  Copyright © 2017年 聂康. All rights reserved.
//

import UIKit

enum NKRefreshState {
    case idle
    case pulling
    case willRefresh
    case refreshing
}

class NKRefreshView: UIView {

    @IBOutlet weak var leftImageView: UIImageView?

    @IBOutlet weak var stateLabel: UILabel?
    
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    
    /// 父视图的高度
    var parentViewHeight: CGFloat = 0
    
    var state:NKRefreshState = .idle {
        didSet{
            switch state {
            case .idle:
                leftImageView?.isHidden = false
                stateLabel?.text = "下拉刷新..."
                indicator?.stopAnimating()
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftImageView?.transform = CGAffineTransform.identity
                })
            case .pulling:
                stateLabel?.text = "再拉就刷新啦!"
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftImageView?.transform = CGAffineTransform.identity
                })
            case .willRefresh:
                stateLabel?.text = "松手就刷新了"
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftImageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                })
            case .refreshing:
                stateLabel?.text = "正在刷新..."
                leftImageView?.isHidden = true
                indicator?.isHidden = false
                indicator?.startAnimating()
            }
        }
    }
    
    class func refreshView() -> NKRefreshView{
        let nib = UINib(nibName: "NKMTRefreshView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil).first as! NKRefreshView
        
        return v
    }
    
    
}

