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
    
    @objc func textViewTextDidChange() {
        // 如果有文本，不显示占位标签，否则显示
        placeholderLabel.isHidden = hasText
    }
}


extension NKTextView {
    
    /// 返回 textView 对应的纯文本的字符串[将属性图片转换成文字]
    var emoticonText: String {
        
        // 1. 获取 textView 的属性文本
        guard let attrStr = attributedText else {
            return ""
        }
        
        // 2. 需要获得属性文本中的图片[附件 Attachment]
        /**
         1> 遍历的范围
         2> 选项 []
         3> 闭包
         */
        var result = String()
        
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: [], using: { (dict, range, _) in
            
            // 如果字典中包含 NSAttachment `Key` 说明是图片，否则是文本
            // 下一个目标：从 attachment 中如果能够获得 chs 就可以了！
            if let attachment = dict[NSAttributedString.Key.attachment] as? EmotionAttachment {
                // print("图片 \(attachment)")
                result += attachment.chs ?? ""
            } else {
                let subStr = (attrStr.string as NSString).substring(with: range)
                
                result += subStr
            }
        })
        
        return result
    }
    
    /// 向文本视图插入表情符号[图文混排]
    ///
    /// - parameter em: 选中的表情符号，nil 表示删除
    func insertEmoticon(em: Emotion?) {
        guard let em = em else {
            return
        }
        
        // 2. emoji 字符串
        if let emoji = em.emoji,
            let textRange = selectedTextRange {
            
            // UITextRange 仅用在此处！
            replace(textRange, withText: emoji)
            
            return
        }
        
        // 代码执行到此，都是图片表情
        // 0. 获取表情中的图像属性文本
        let imageText = em.imageText(font: font!)
        
        // 1> 获取当前 textView 属性文本 => 可变的
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        
        // 2> 将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharacters(in: selectedRange, with: imageText)
        
        // 3> 重新设置属性文本
        // 记录光标位置
        let range = selectedRange
        
        // 设置文本
        attributedText = attrStrM
        
        // 恢复光标位置，length 是选中字符的长度，插入文本之后，应该为 0
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        // 4> 让代理执行文本变化方法 - 在需要的时候，通知代理执行协议方法！
        delegate?.textViewDidChange?(self)
        
        // 5> 执行当前对象的 文本变化方法
        textViewTextDidChange()
        
    }
}

extension NKTextView {
    
    func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLabel.backgroundColor = backgroundColor
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = font
        placeholderLabel.text = "请输入文字"
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
        
    }

}
