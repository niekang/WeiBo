//
//  NKRefreshControl.swift
//  NKRefresh
//
//  Created by 聂康 on 2017/6/25.
//  Copyright © 2017年 聂康. All rights reserved.
//

import UIKit

private let NKRefreshOffSet:CGFloat = 120

class NKRefreshControl: UIControl {
    
    private weak var scrollView:UIScrollView?

    lazy var refreshView:NKRefreshView = NKRefreshView.refreshView()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 重载方法 KVO 监控contentOffset
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let scr = newSuperview as? UIScrollView else {
            return
        }
        scrollView = scr
        
        scr.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    /// 移除KVO
    override func removeFromSuperview() {
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scr = scrollView else {
            return
        }
        
        //计算NKRefreshControl高度
        let height = -(scr.contentInset.top + scr.contentOffset.y)
        
        if height < 0 {
            return
        }
        
        self.frame = CGRect(x: 0, y: -height, width: scr.bounds.width, height: height)
        
        if refreshView.state != .refreshing {
            refreshView.parentViewHeight = height
        }
        
        if scr.isDragging {
            if height < NKRefreshOffSet && refreshView.state == .idle{
                refreshView.state = .pulling
            }else if height < NKRefreshOffSet && refreshView.state == .willRefresh {
                refreshView.state = .pulling
            }else if height >= NKRefreshOffSet && refreshView.state == .pulling{
                refreshView.state = .willRefresh
            }
        }else {
            if refreshView.state == .willRefresh {
                beginRefresh()
                sendActions(for: .valueChanged)
            }
        }
    }
    
    
    /// 刷新方法
    func beginRefresh() {
        guard let scr = scrollView else{
            return
        }
        //防止多次刷新
        if refreshView.state == .refreshing {
            return
        }
        
        refreshView.parentViewHeight = NKRefreshOffSet

        refreshView.state = .refreshing
        
        var inset = scr.contentInset
        
        inset.top += NKRefreshOffSet
        
        scr.contentInset = inset
        
    }
    
    
    ///结束刷新
    func endRefresh() {
        guard let scr = scrollView else{
            return
        }
        
        //防止多次刷新
        if refreshView.state != .refreshing {
            return
        }
        
        refreshView.state = .idle
        
        var inset = scr.contentInset
        
        inset.top -= NKRefreshOffSet
        
        scr.contentInset = inset

    }
    
}


extension NKRefreshControl {
    
    func setupUI() {
        
//        clipsToBounds = true
        
        refreshView.backgroundColor = superview?.backgroundColor
        
        addSubview(refreshView)
        
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        //给刷新视图添加约束
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))

    }
}
