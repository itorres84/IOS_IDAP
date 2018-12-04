//
//  textFieldCustomVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

@IBDesignable
public class textFieldCustomVC: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var tittleTextField: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBInspectable
    public var tittle: String {
        get {
            return (self.tittleTextField?.text)!
        }
        set {
            self.tittleTextField.text = newValue
        }
    }
    
    @IBInspectable
    public var placeHolder: String {
        get {
            return (self.textField?.placeholder)!
        }
        set {
            self.textField.placeholder = newValue
        }
    }
    
    @IBInspectable
    public var isPassword: Bool {
        get {
            return (self.textField?.isSecureTextEntry)!
        }
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
    
    @IBInspectable
    public var typeField: Int  = 1{
        didSet{
            switch typeField {
            case 1: //.text?:
                self.textField.isSecureTextEntry = false
                self.textField.autocorrectionType = .no
                self.textField.autocapitalizationType = .sentences
                self.textField.keyboardType = .asciiCapable
            case 2: //.number?, .codAct?:
                self.textField.isSecureTextEntry = false
                self.textField.keyboardType = .decimalPad
            case 3: //.email?:
                self.textField.isSecureTextEntry = false
                self.textField.autocorrectionType = .no
                self.textField.keyboardType = .emailAddress
            case 4: //.phone?:
                self.textField.isSecureTextEntry = false
                self.textField.keyboardType = .numberPad
            case 5: //.psswrd?:
                self.textField.isSecureTextEntry = false
                self.textField.keyboardType = .numberPad
            case 6: //.cvv?:
                self.textField.isSecureTextEntry = false
                self.textField.keyboardType = .numberPad
            case 7: //.search?:
                self.textField.isSecureTextEntry = false
                self.textField.autocorrectionType = .no
                self.textField.autocapitalizationType = .sentences
                self.textField.keyboardType = .asciiCapable
            case 8: //.curp?:
                self.textField.autocorrectionType = .no
                self.textField.autocapitalizationType = .allCharacters
            //            self.textField.addTarget(self, action: #selector(VMTxtYaGanaste.editingChanged), for: .editingChanged)
            default:
                print("Not controler....")
                self.textField.isSecureTextEntry = false
                self.textField.autocorrectionType = .no
                self.textField.autocapitalizationType = .sentences
                self.textField.keyboardType = .asciiCapable
            }
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
