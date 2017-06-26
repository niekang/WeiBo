//
//  WBComposeView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/26.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import pop

class WBComposeView: UIView {
    
    deinit {
        print("释放了")
    }

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var closeCenterX:NSLayoutConstraint!
    
    @IBOutlet weak var backCenterX:NSLayoutConstraint!
    
    private var composeCompetion:((_ className:String?) -> Void)?

    class func composeView() -> WBComposeView{
    
        let nib = UINib(nibName: "WBComposeView", bundle: nil)

        let v = nib.instantiate(withOwner: nil, options: nil).first as! WBComposeView

        v.frame = UIScreen.main.bounds
        
        v.setupIU()
        
        return v
    }
    
    override func awakeFromNib() {
        backBtn.isHidden = true
    }
    
    /// 列表按钮点击事件
    func clickButton(selectedButton: WBComposeBtnView) {
        // 1. 判断当前显示的视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 2. 遍历当前视图
        // - 选中的按钮放大
        // - 为选中的按钮缩小
        for (i, btn) in v.subviews.enumerated() {
            
            // 1> 缩放动画
            let scaleAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            
            // x,y 在系统中使用 CGPoint 表示，如果要转换成 id，需要使用 `NSValue` 包装
            let scale = (selectedButton == btn) ? 2 : 0.2
            
            scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnim.duration = 0.5
            
            btn.pop_add(scaleAnim, forKey: nil)
            
            // 2> 渐变动画 - 动画组
            let alphaAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.5
            
            btn.pop_add(alphaAnim, forKey: nil)
            
            // 3> 添加动画监听
            if i == 0 {
                alphaAnim.completionBlock = { _, _ in
                    // 执行完成闭包
                    self.removeFromSuperview()
                    self.composeCompetion?(selectedButton.clsName)
                }
            }
        }

    }
    
    /// 点击更多按钮 滚动到第二页
    func clickMore() {
        backBtn.isHidden = false
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        let margin = scrollView.bounds.width / 6
        backCenterX.constant -= margin
        closeCenterX.constant += margin
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    ///返回按钮点击 滚动到第一页
    @IBAction func backAction() {
        backBtn.isHidden = true
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        backCenterX.constant = 0
        closeCenterX.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    /// 关闭按钮点击 移除视图
    @IBAction func close() {
        // 1. 根据 contentOffset 判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 2. 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated().reversed() {
            
            // 1> 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            // 2> 设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            
            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            // 3> 添加动画
            btn.layer.pop_add(anim, forKey: nil)
            
            // 4> 监听第 0 个按钮的动画，是最后一个执行的
            if i == 0 {
                anim.completionBlock = { _, _ in
                    self.hideCurrentView()
                }
            }
        }

    }
    
    /// 隐藏当前视图
    private func hideCurrentView() {
        
        // 1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        
        // 3> 添加完成监听方法
        anim.completionBlock = { _, _ in
            self.removeFromSuperview()
        }
    }
    

    
    ///页面显示动画
    func show(completion:((_ composeClassName:String?)->())?) {
        
        composeCompetion = completion
        
        let anima:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anima.fromValue = 0
        anima.toValue = 1
        anima.duration = 0.25
        pop_add(anima, forKey: nil)
        
        buttonsAppearAnima()
    }
    
    //按钮出现弹回动画
    func buttonsAppearAnima() {
        //获取第一页视图
        let v = scrollView.subviews[0]
        //遍历第一页视图上的所有按钮
        for (i, btn) in v.subviews.enumerated() {
            let anima:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anima.fromValue = btn.center.y + 300
            anima.toValue = btn.center.y
            
            anima.springSpeed = 8
            anima.springBounciness = 8
            
            //设置动画开始时间 控制先后顺序
            anima.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            btn.pop_add(anima, forKey: nil)
        }
    }
}

extension WBComposeView {
    
    func setupIU() {
        layoutIfNeeded()

        let rect = scrollView.bounds
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * scrollView.width, dy: 0))
            addButtons(v: v, index: i * 6)
            scrollView.addSubview(v)
        }
        
        scrollView.contentSize = CGSize(width: 2 * scrollView.bounds.width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.bounces = false
    }
    
    func addButtons(v:UIView, index:Int) {
        /// 按钮数据数组
        let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                           ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                           ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                           ["imageName": "tabbar_compose_lbs", "title": "签到"],
                           ["imageName": "tabbar_compose_review", "title": "点评"],
                           ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                           ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                           ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                           ["imageName": "tabbar_compose_music", "title": "音乐"],
                           ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
        ]
        
        let count = 6
        for i in index..<(index + count) {
            
            if i >= buttonsInfo.count {
                break
            }
            
            let dict = buttonsInfo[i]
            guard let image = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            let composeBtnView = WBComposeBtnView.composeBtnView(imageName: image, title: title)
            composeBtnView.clsName = dict["clsName"]

            v.addSubview(composeBtnView)
            
            // 3> 添加监听方法
            if let actionName = dict["actionName"] {
                composeBtnView.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            } else {
                composeBtnView.addTarget(self, action: #selector(clickButton(selectedButton:)), for: .touchUpInside)
            }
        }

        // 遍历视图的子视图，设置按钮frame
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i, btn) in v.subviews.enumerated() {
            
            let y: CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
