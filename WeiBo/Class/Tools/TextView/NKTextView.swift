//
//  NKTextView.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/27.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class NKTextView: UITextView {

    var placeholderLabel = UILabel()

    override func awakeFromNib() {
        setupUI()
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    func textViewTextDidChange() {
        // 如果有文本，不显示占位标签，否则显示
        placeholderLabel.isHidden = hasText
    }
}

extension NKTextView {
    
    func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLabel.backgroundColor = backgroundColor
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = font
        placeholderLabel.text = "请输入文字"
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
        
    }

}
