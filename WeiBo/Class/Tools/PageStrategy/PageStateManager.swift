//
//  PageStateManager.swift
//  WeiBo
//
//  Created by MC on 2019/8/27.
//  Copyright © 2019 com.nk. All rights reserved.
//

import UIKit

public protocol LoadViewProtocol: UIView {
    func startLoading()
    func stopLoading()
}

class PageStateManager {
    
    private var emptyView: UIView?
    private var errorView: UIView?
    private var loadView: LoadViewProtocol?
    
    private var pageView: UIView?
    
    public typealias ReloadCallback = () -> Void
    
    private var reloadCallback: ReloadCallback?
    
    init(_ pageView: UIView, emptyView: UIView? = nil, errorView: UIView? = nil, loadView: LoadViewProtocol? = nil) {
        self.setEmptyView(emptyView)
        self.setErrorView(errorView)
        self.setLoadView(loadView)
    }
    
    //MARK: - public method
    public func setEmptyView(_ emptyView: UIView?) {
        guard let emptyView = emptyView else {
            return
        }
        self.emptyView?.removeFromSuperview()
        self.emptyView = emptyView
        self.pageView?.addSubview(emptyView)
    }
    
    public func setErrorView(_ errorView: UIView?) {
        guard let errorView = errorView else {
            return
        }
        self.errorView?.removeFromSuperview()
        self.errorView = errorView
        self.pageView?.addSubview(errorView)
    }
    public func setLoadView(_ loadView: LoadViewProtocol?) {
        guard let loadView = loadView else {
            return
        }
        self.loadView?.removeFromSuperview()
        self.loadView = loadView
        self.pageView?.addSubview(loadView)
    }
    
    public func setReloadCallback(reloadCallback: @escaping ReloadCallback) {
        self.reloadCallback = reloadCallback
    }
    
    public func showContent() {
        self.emptyView?.isHidden = true
        self.loadView?.isHidden = true
        self.loadView?.stopLoading()
        self.errorView?.isHidden = true
    }
    
    public func showEmpty() {
        self.showView(self.emptyView)
    }
    
    public func showLoading() {
        self.showView(self.loadView)
        self.loadView?.startLoading()
    }
    
    public func showError() {
        self.showView(self.errorView)
    }
    
    //MARK: - private method
    private func showView(_ view: UIView?) {
        guard let view = view else {
            return
        }
        self.showContent()
        view.isHidden = false
        self.pageView?.bringSubviewToFront(view)
    }
    
    
}
