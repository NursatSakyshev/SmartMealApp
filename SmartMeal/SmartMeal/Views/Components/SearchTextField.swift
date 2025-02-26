//
//  SearchTextField.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
//    let leftPaddingView = UIView()
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    func setup() {
        leftPaddingView.addSubview(iconView)
//        leftPaddingView.backgroundColor = .green
        autocapitalizationType = .none
        layer.cornerRadius = 24
        backgroundColor = UIColor(red: 248/255, green: 249/255, blue: 254/255, alpha: 1)
        leftView = leftPaddingView
        leftViewMode = .always
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        iconView.tintColor = .gray
    }

    var padding = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
       
   override func becomeFirstResponder() -> Bool {
       let didSetFirstResponder = super.becomeFirstResponder()
       
       return didSetFirstResponder
   }
   
   override func resignFirstResponder() -> Bool {
       let didResignFirstResponder = super.resignFirstResponder()
       
       if didResignFirstResponder {
           layer.borderColor = UIColor.clear.cgColor
       }
       
       return didResignFirstResponder
   }

}
