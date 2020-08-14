//
//  Style.swift
//  Operations
//
//  Created by Asante on 5/19/20.
//  Copyright © 2020 Rare Times. All rights reserved.
//

import Foundation
import UIKit

class Style {
    
    enum TextStyle {
        case navigationBar
        case assessmentTitle
        case mainTitle
        case subtitle
        case body
        case assessmentButton
        case segueButton
        case textField
        case textView
        case view
        case progressBar
        case slider
    }
    
    struct TextAttributes {
        let font: UIFont
        let color: UIColor
        let backgroundColor: UIColor?
        
        init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - General Properties
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle
    
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes
    
    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes)
    {
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }
    
    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }
    
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    
    /// Label Style with Text Shadow Bool
    func apply(textStyle: TextStyle, shadow: Bool, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
        if shadow == true {
            
            label.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
            label.shadowColor = label.textColor.withAlphaComponent(0.40)
            label.shadowOffset = CGSize(width: 1, height: 1)
            
            if textStyle == .assessmentTitle {
                label.textColor = .blue
            } else { }
        }
    }
    
    enum Marker {
        case unmarked
        case marked
    }
    
    /// Buttons: Green & Gray (Mark Completed or Unmarked to Complete)
    func apply(textStyle: TextStyle = .segueButton, marker: Marker, titleText: String?, to button: UIButton) {
        
        let attributes = attributesForStyle(textStyle)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = attributes.font
        button.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
        button.layer.cornerRadius = 5
        button.setTitle(titleText, for: .normal)
        switch marker {
        case .unmarked:
            button.backgroundColor = .blue
            button.setTitleColor(attributes.color, for: .normal)
        case .marked:
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    /// Buttons: Green & Gray (Mark Completed or Unmarked to Complete with Strikethrough Text Attribute)
    func apply(textStyle: TextStyle = .segueButton, marker: Marker, attribute: NSAttributedString.Key, titleText: String?, to button: UIButton) {
        
        let attributes = attributesForStyle(textStyle)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: button.titleLabel!.text!)
        attributeString.addAttribute(attribute, value: 2, range: NSMakeRange(0, attributeString.length))
        button.titleLabel?.attributedText = attributeString
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = attributes.font
        button.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
        button.layer.cornerRadius = 5
        button.setTitle(titleText, for: .normal)
        
        switch marker {
        case .unmarked:
            button.setTitleColor(attributes.color, for: .normal)
            button.isEnabled = true
            if button.state == .normal {
                button.backgroundColor = .green
            } else {
                button.backgroundColor = .blue
            }
            
        case .marked:
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.isEnabled = false
        }
    }
    
    /// Navigation Bar Style
    func apply(textStyle: TextStyle = .navigationBar, to navigationBar: UINavigationBar) {
        let attributes = attributesForStyle(textStyle)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: attributes.font,
            NSAttributedString.Key.foregroundColor: attributes.color
        ]
        if let color = attributes.backgroundColor {
            navigationBar.barTintColor = color
        }
        navigationBar.tintColor = attributes.color
        navigationBar.barStyle = preferredStatusBarStyle == .default ? .default : .black
    }
    
    /// Text Field Style
    func apply(textStyle: TextStyle, to textField: UITextField) {
        let attributes = attributesForStyle(textStyle)
        textField.font = attributes.font
        textField.textColor = attributes.color
        textField.backgroundColor = attributes.backgroundColor
        textField.layer.cornerRadius = 5
        textField.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
        
    }
    
    /// Text View Style
    func apply(textStyle: TextStyle, shadow: Bool, to textView: UITextView) {
        let attributes = attributesForStyle(textStyle)
        textView.font = attributes.font
        textView.textColor = attributes.color
        textView.backgroundColor = attributes.backgroundColor
        textView.layer.cornerRadius = 5
        if (shadow) {
            textView.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
        }
    }
    
    /// View Style
    func apply(textStyle: TextStyle, bgColor: UIColor?, shadow: Bool, to view: UIView) {
        let attributes = attributesForStyle(textStyle)
        view.backgroundColor = attributes.backgroundColor
        if bgColor != nil {
            view.backgroundColor = bgColor
            view.layer.cornerRadius = 12
            if (shadow) {
                view.dropShadowForUIView(color: .black, opacity: 0.3, offSet: CGSize(width: 1, height: 1), radius: 9, scale: true)
            }
        } else {
            view.layer.cornerRadius = 5
            if (shadow) {
                view.dropShadowForUIView(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 1), radius: 2.5, scale: true)
            }
        }
    }
    
    /// Progress View Style
    func apply(textStyle: TextStyle, to progressView: UIProgressView) {
        let attributes = attributesForStyle(textStyle)
        progressView.backgroundColor = attributes.backgroundColor
        
        progressView.heightConstraint()
        progressView.layer.cornerRadius = 12
    }
    
    /// UISlider Style
    func apply(textStyle: TextStyle, snap: Bool, to slider: UISlider) {
        let attributes = attributesForStyle(textStyle)
        slider.backgroundColor = attributes.backgroundColor
        if snap == true {
            
        }
    }
}

extension UIView {
    func unselectedButtonColor(button: UIButton) {
        let unselectedColor = UIColor(named: "Button Color")
        button.backgroundColor = unselectedColor
    }
    
    func selectedButtonColor(button: UIButton) {
        let selectedColor = UIColor(named: "Selected Button Color")
        button.backgroundColor = selectedColor
    }
    
    func dropShadowForUIView(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UITextField {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIImageView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UITextView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UILabel {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIButton {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIProgressView {
    
    func heightConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 23)
        self.addConstraint(heightConstraint)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
