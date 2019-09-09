//
//  VisitorView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/20.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    weak var target: UIViewController? {
        didSet{
            target?.view.addSubview(self)
            
            //
            self.logBtn.action(self, #selector(logBtnClick(sender:)))
            self.registerBtn.action(self, #selector(resisterBtnClick(sender:)))
            
            /// 监听登录状态
            NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(WBLoginSuccessNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(logOut), name: Notification.Name(WBLogOutNotification), object: nil)
            
            /// 判断是否登录
            (WBUserAccont.shared.access_token != nil) ? loginSuccess() : logOut()

        }
    }
    
    var loginClousure: (()-> ())?
    var logoutClousure : (() -> ())?
    
    var visitorInfoDictionary:[String:String]?{
        didSet{
            guard let imageName = visitorInfoDictionary?["image"],
                let message = visitorInfoDictionary?["tip"] else{
                    return
            }
            
            tipLab.text(message)

            if imageName == "" {
                startAnimation()
                return
            }
            
            imageView.image = UIImage(named:imageName)
            houseImageView.isHidden = true
            maskImageView.isHidden = true
        }
    }
    
    //中间图像
    lazy var imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    //首页小房子
    lazy var houseImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    
    // 首页遮罩图像
    lazy var maskImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    //提示标签
    lazy var tipLab = UILabel().fontSize(16).numberOfLines(0)

    //注册按钮
    lazy var registerBtn = UIButton().title("注册").textColor(UIColor.orange).backgroundImage("common_button_white_disable")
    
    //登录按钮
    lazy var logBtn = UIButton().title("登录").textColor(UIColor.orange).backgroundImage("common_button_white_disable")

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension VisitorView {
    
    func setup() {
        addSubview(imageView)
        addSubview(houseImageView)
        addSubview(maskImageView)
        addSubview(tipLab)
        addSubview(registerBtn)
        addSubview(logBtn)
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //添加约束
        addConstrains()
        
    }
    
    // MARK: - 添加登录通知,处理访客视图
    
    ///注册
    @objc func resisterBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    ///登录
    @objc func logBtnClick(sender:UIButton) {
        WBUserAccont.shared.login()
    }
    
    ///登录成功监听方法
    @objc func loginSuccess() {
        self.removeFromSuperview()
        self.loginClousure?()
    }
    
    /// 退出登录监听方法
    @objc func logOut() {
        self.target?.view.addSubview(self)
        self.target?.view.bringSubviewToFront(self)
        self.logoutClousure?()
    }

    
    func startAnimation() {
        let anima = CABasicAnimation(keyPath: "transform.rotation")
        anima.toValue = 2 * Double.pi
        anima.repeatCount = MAXFLOAT
        anima.duration = 15
        anima.isRemovedOnCompletion = false
        imageView.layer.add(anima, forKey: "rotation")
    }
    
    func addConstrains() {
        //中间图片
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0))
        
        //小房子
        addConstraint(NSLayoutConstraint(item: houseImageView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: houseImageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0))
        
        //标签
        addConstraint(NSLayoutConstraint(item: tipLab,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 220))
        
        addConstraint(NSLayoutConstraint(item: tipLab,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: imageView,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 20))
        
        addConstraint(NSLayoutConstraint(item: tipLab,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: imageView,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLab,
                                         attribute: .left,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: 80))
        
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLab,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 20))
        
        //登录按钮
        addConstraint(NSLayoutConstraint(item: logBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLab,
                                         attribute: .right,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: logBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: 80))
        
        addConstraint(NSLayoutConstraint(item: logBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLab,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 20))
        //遮罩视图
        addConstraint(NSLayoutConstraint(item: maskImageView,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .left,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: maskImageView,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .right,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: maskImageView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: maskImageView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: registerBtn,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 20))

    }
    
}
