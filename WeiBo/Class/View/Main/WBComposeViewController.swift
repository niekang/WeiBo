//
//  WBComposeViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/27.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class WBComposeViewController: WBSuperViewController {

    @IBOutlet var titleBtn: UILabel!
    

    @IBOutlet var sendBtn: UIButton!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var textView: NKTextView!
    
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChange(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        /// 导航条设置
        setupNavigationBar()
        /// 底部工具条
        setupToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// 激活键盘
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// 隐藏键盘
        textView.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 设置代理
        textView.delegate = self
    }
    
    /// 键盘高度监控
    func keyboardFrameChange(noti:Notification) {
        guard let info = noti.userInfo,
            let rect = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        
        bottomConstant.constant = view.bounds.height - rect.origin.y
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
        WBLog(duration)
    }
    
    /// 点击发布
   
    @IBAction func sendBtnClick(_ sender: Any) {
    }
    
}

extension WBComposeViewController:UITextViewDelegate {
    /// 文本视图文字变化
    func textViewDidChange(_ textView: UITextView) {
        sendBtn.isEnabled = textView.hasText
    }
}

extension WBComposeViewController {
    /// 设置导航条
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendBtn)
        sendBtn.isEnabled = false
        navigationItem.titleView = titleBtn
        
        WBLog(sendBtn.isEnabled)
    }
    
    /// 返回
    func back() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 底部工具条
    func setupToolbar() {
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]

        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {
            
            guard let imageName = dict["imageName"] else {
                return
            }
            
            let btn = UIButton()
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        
            let item = UIBarButtonItem(customView: btn)
            items.append(item)
            
            let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            items.append(spaceItem)
        }
        
        items.removeLast()
        toolbar.items = items
    
    }
    
}
