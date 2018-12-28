//
//  ChekView.swift
//  idapp
//
//  Created by Israel Torres Alvarado on 12/27/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

@IBDesignable
class ChekView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var ImgCheck: UIImageView!
    
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBAction func changeCheck(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            ImgCheck.isHidden = false
        }else{
            sender.tag = 0
            ImgCheck.isHidden = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]

        addSubview(view)
        sendSubview(toBack: view)
    }
    
    public func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
