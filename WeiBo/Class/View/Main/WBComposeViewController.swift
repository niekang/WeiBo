//
//  WBComposeViewController.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/27.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBComposeViewController: BaseViewController {

    @IBOutlet var titleBtn: UILabel!

    @IBOutlet var sendBtn: UIButton!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var textView: NKTextView!
    
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    
    lazy var emmotionInputView:EmotionInputView = {
        let v = EmotionInputView.inputView(selectEmotion: {[weak self] (em) in
            self?.textView.insertEmoticon(em: em)
        })
        return v
    }()
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChange(noti:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    @objc func keyboardFrameChange(noti:Notification) {
        guard let info = noti.userInfo,
            let rect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        
        bottomConstant.constant = view.bounds.height - rect.origin.y
        
        emmotionInputView.frame.size.height = rect.size.height
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    /// 点击发布
    @IBAction func sendBtnClick(_ sender: Any) {
        
        let text = textView.emoticonText
    
        let image:UIImage? = nil
        
        WBNetworkManager.shared.uploadWB(text: text, image: image) { (isSuccess, json) in
            if isSuccess {
                SVProgressHUD.setMaximumDismissTimeInterval(1)
                SVProgressHUD.showSuccess(withStatus: "发布成功")
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: WBHomeVCShouldRefresh), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /// 表情键盘
    @objc func emoticonKeyboard() {
        textView.becomeFirstResponder()
        
        textView.inputView = (textView.inputView == nil) ? emmotionInputView : nil
        textView.reloadInputViews()
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
        
    }
    
    /// 返回
    @objc func back() {
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
            
            if let actionName = dict["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
        }
        
        items.removeLast()
        toolbar.items = items
    
    }
    
}
