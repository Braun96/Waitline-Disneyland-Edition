//
//  CustomHPButton.swift
//  Waitline Disneyland
//
//  Created by Braun Butterfield on 3/17/16.
//  Copyright © 2016 Braun Butterfield. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomHPButton : UIButton {
    //var buttonColor = UIColor(red: 94/255, green: 208/255, blue: 255/255, alpha: 1)
   
    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet {
        setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        //self.layer.backgroundColor = buttonColor.CGColor
        self.addTarget(self, action: #selector(CustomHPButton.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(CustomHPButton.scaleToSmall), for:.touchDragEnter)
        self.addTarget(self, action: #selector(CustomHPButton.scaleAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(CustomHPButton.scaleDefault), for: .touchDragExit)
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.75, height: 0.75))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "LayerScaleSpringAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        self.layer.pop_add(scaleAnim, forKey: "LayerScaleDefaultAnimation")
        
    }
    
}
