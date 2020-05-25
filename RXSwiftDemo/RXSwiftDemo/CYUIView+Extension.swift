//
//  CYUIView+Extension.swift
//  caiyunInterpreter
//
//  Created by wwly on 2020/3/2.
//  Copyright © 2020 北京彩彻区明科技有限公司. All rights reserved.
//

import UIKit

extension UIView {
    /// x
    public var x : CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var f = self.frame
            f.origin.x = newValue
            self.frame = f
        }
    }
    /// y
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var f = self.frame
            f.origin.y = newValue
            self.frame = f
        }
    }
    /// width
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var f = self.frame
            f.size.width = newValue
            self.frame = f
        }
    }
    /// height
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var f = self.frame
            f.size.height = newValue
            self.frame = f
        }
    }
    /// origin
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var f = self.frame
            f.origin = newValue
            self.frame = f
        }
    }
    /// size
    public var size : CGSize {
        get {
            return self.frame.size
        }
        set {
            var f = self.frame
            f.size = newValue
            self.frame = f
        }
    }
    /// centerX
    public var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            var c = self.center
            c.x = newValue
            self.center = c
        }
    }
    /// centerY
    public var centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            var c = self.center
            c.y = newValue
            self.center = c
        }
    }
    /// maxX
    public var maxX : CGFloat {
        get {
            return self.x + self.width
        }
        set {
            let c = self.width
            self.x = newValue - c
        }
    }
    /// maxY
    public var maxY : CGFloat {
        get {
            return self.y + self.height
        }
        set {
            let c = self.height
            self.y = newValue - c
        }
    }
}

extension UIView {
    // MARK: 同时添加多个 view
    public func addSubviews(_ views : [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    public func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        UIColor.clear.setFill()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        path.fill()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
}

extension UILabel {
    public convenience init(text: String?, font: UIFont?, textColor: UIColor?, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init(text: text, frame: CGRect.zero, font: font, textColor: textColor, alignment: alignment, numberOfLines: numberOfLines)
    }
    
    public convenience init(text: String?, frame: CGRect, font: UIFont?, textColor: UIColor?, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        
        self.text = text
        self.frame = frame
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
    /// 获取内容对应的宽度
    func textWidth() -> CGFloat {
        return self.text?.getWidth(height: self.height, font: self.font) ?? 0
    }
    
    /// 获取内容对应的高度
    func textHeight() -> CGFloat {
        return self.text?.getHeight(width: self.width, font: self.font) ?? 0
    }
}

extension UIButton {
    public convenience init(buttonType: UIButton.ButtonType, title: String?, titleFont: UIFont?, titleColor: UIColor?) {
        self.init(type: buttonType)
        if title != nil {
            self.setTitle(title, for: .normal)
        }
        if titleFont != nil {
            self.titleLabel?.font = titleFont
        }
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    public convenience init(buttonType: UIButton.ButtonType, image: UIImage?, hightlightedImage: UIImage? = nil, imageContentMode: UIView.ContentMode = UIView.ContentMode.scaleAspectFit) {
        self.init(type: buttonType)
        if image != nil {
            self.setImage(image, for: .normal)
        }
        if hightlightedImage != nil {
            self.setImage(hightlightedImage, for: .highlighted)
        }
        self.imageView?.contentMode = imageContentMode
    }
}

extension UIImageView {
    public convenience init(named: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init()
        self.image = UIImage(named: named)
        self.contentMode = contentMode
    }
}

extension String {
    func getHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = self.boundingRect(with: CGSize(width: width, height: 9999), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.height + 1
    }
    
    func getWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let rect = self.boundingRect(with: CGSize(width: 9999, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.width + 1
    }
    
    /// 判断字符串是否为空
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
    static func convertTimeSecond(timeSecond: Int64) -> String {
        var theLastTime: String = ""
        let second = timeSecond
        if timeSecond < 60 {
            theLastTime = String(format: "00:%02zd", second)
        } else if timeSecond >= 60 && timeSecond < 3600 {
            theLastTime = String(format: "%02zd:%02zd", second/60, second%60)
        } else if(timeSecond >= 3600){
            theLastTime = String(format: "%02zd:%02zd:%02zd", second/3600, second%3600/60, second%60)
        }
        return theLastTime
    }
}

extension NSArray {
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension UIView {
    func getTransformRotationAngle(orientation: UIInterfaceOrientation) -> CGAffineTransform {
        if (orientation == .portrait) {
            return .identity;
        } else if (orientation == .landscapeLeft) {
            return CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        } else if(orientation == .landscapeRight) {
            return CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
        return .identity;
    }
}

extension UIColor {
    
    /// 24位16进制颜色
    ///
    /// - Parameter hex: 24位16进制 数
    convenience init(hex: UInt32) {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        self.init(r: UInt8(r), g: UInt8(g), b: UInt8(b))
    }
    
    /// 获取 UIColor
    ///
    /// - Parameters:
    ///   - r: 红    取值: 0-255
    ///   - g: 绿    取值: 0-255
    ///   - b: 蓝    取值: 0-255
    convenience init(r: UInt8, g: UInt8, b: UInt8) {
        self.init(red: CGFloat(r) / 255.0, green:  CGFloat(g) / 255.0, blue:  CGFloat(b) / 255.0, alpha: 1)
    }
    
    /// 随机色
    class var random: UIColor {
        return UIColor(r: UInt8(arc4random_uniform(256)), g: UInt8(arc4random_uniform(256)), b: UInt8(arc4random_uniform(256)))
    }
}
