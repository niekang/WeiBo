//
//  EmotionCollectionViewCell.swift
//  WeiBo
//
//  Created by 聂康  on 2017/6/29.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

protocol EmotionCollectionViewCellDelegate:NSObjectProtocol {
    /// 表情 cell 选中表情模型
    ///
    /// - parameter em: 表情模型／nil 表示删除
    func emoticonCellDidSelectedEmoticon(cell: EmotionCollectionViewCell, em: Emotion?)

}

class EmotionCollectionViewCell: UICollectionViewCell {
    
    weak var delegate:EmotionCollectionViewCellDelegate?
    
    var emotions:[Emotion]? {
        didSet {
            for v in contentView.subviews {
                v.isHidden = true
            }
            
            // 显示删除按钮
            contentView.subviews.last?.isHidden = false

            guard let emotions = emotions else {
                return
            }
            
            for (i, em) in emotions.enumerated() {
                guard let btn = contentView.subviews[i] as? UIButton else {
                    continue
                }
                btn.setImage(em.image, for: [])
                
                btn.setTitle(em.emoji, for: [])
                
                btn.isHidden = false
            }
        }
    }
    
    /// 表情选择提示视图
    private lazy var tipView = EmotionTipView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 当视图从界面上删除，同样会调用此方法，newWindow == nil
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        guard let w = newWindow else {
            return
        }
        
        // 将提示视图添加到窗口上
        // 提示：在 iOS 6.0之前，很多程序员都喜欢把控件往窗口添加
        // 在现在开发，如果有地方，就不要用窗口！
        w.addSubview(tipView)
        tipView.isHidden = true
    }
    
    @objc func emotionClick(btn:UIButton) {
        let tag = btn.tag
        
        var em: Emotion?
        if tag < (emotions?.count ?? 0) {
            em = emotions?[tag]
        }
        
        delegate?.emoticonCellDidSelectedEmoticon(cell: self, em: em)

    }
    
    
    /// 长按手势识别 - 是一个非常非常重要的手势
    /// 可以保证一个对象监听两种点击手势！而且不需要考虑解决手势冲突！
    @objc func longGesture(gesture: UILongPressGestureRecognizer) {
        
        // 测试添加提示视图
        // addSubview(tipView)
        
        // 1> 获取触摸位置
        let location = gesture.location(in: self)
        
        // 2> 获取触摸位置对应的按钮
        guard let button = buttonWithLocation(location: location) else {
            
            tipView.isHidden = true
            
            return
        }
        
        // 3> 处理手势状态
        // 在处理手势细节的时候，不要试图一下把所有状态都处理完毕！
        switch gesture.state {
        case .began, .changed:
            
            tipView.isHidden = false
            
            // 坐标系的转换 -> 将按钮参照 cell 的坐标系，转换到 window 的坐标位置
            let center = self.convert(button.center, to: window)
            
            // 设置提示视图的位置
            tipView.center = center
            
            // 设置提示视图的表情模型
            if button.tag < (emotions?.count ?? 0) {
                tipView.emoticon = emotions?[button.tag]
            }
        case .ended:
            tipView.isHidden = true
            
            // 执行选中按钮的函数
            emotionClick(btn: button)
        case .cancelled, .failed:
            tipView.isHidden = true
        default:
            break
        }
    }
    
    func buttonWithLocation(location: CGPoint) -> UIButton? {
        
        // 遍历 contentView 所有的子视图，如果可见，同时在 location 确认是按钮
        for btn in contentView.subviews as! [UIButton] {
            
            // 删除按钮同样需要处理
            if btn.frame.contains(location) && !btn.isHidden && btn != contentView.subviews.last {
                return btn
            }
        }
        
        return nil
    }

}

extension EmotionCollectionViewCell {
    
    func setupUI() {
        /// 行数
        let rowCount = 3
        /// 列数
        let columeCount = 7
        /// 左右间距
        let margin:CGFloat = 8
        /// 底部间距
        let bottom:CGFloat = 16
        /// 宽度
        let w = (bounds.width - 2 * margin) / CGFloat(columeCount)
        /// 高度
        let h = (bounds.height - bottom) / CGFloat(rowCount)
        
        for i in 0..<21 {
            //当前在哪行
            let row = i / columeCount
            ///当前在哪列
            let colume = i % columeCount
    
            let x = margin + CGFloat(colume) * w
            let y = CGFloat(row) * h
            
            let btn = UIButton()
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
                        
            btn.tag = i
            btn.addTarget(self, action: #selector(emotionClick(btn:)), for: .touchUpInside)
            
            contentView.addSubview(btn)
        }
        
        let removeBtn = contentView.subviews.last as! UIButton
        
        // 设置图像
        let image = UIImage(named: "compose_emotion_delete_highlighted", in: EmotionManager.shared.bundle, compatibleWith: nil)
        removeBtn.setImage(image, for: [])
        

        // 添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture(gesture:)))
        
        longPress.minimumPressDuration = 0.1
        addGestureRecognizer(longPress)

    }
    
}
