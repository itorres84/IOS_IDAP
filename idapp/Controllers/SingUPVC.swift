//
//  singUPVC.swift
//  idapp
//
//  Created by Israel Torres Alvarado on 12/4/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit
import Firebase

class SingUPVC: BaseViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var goodInfoSwitch: UISwitch!
    @IBOutlet weak var termConditions: UISwitch!
    
    @IBOutlet weak var btnSingUp: UIButton!
    
    var ref: DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSingUp.layer.cornerRadius = 10
        self.btnSingUp.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SingUPVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        txtEmail.keyboardType = .emailAddress
        txtEmail.autocorrectionType = .no
        txtNombre.autocorrectionType = .no
        txtApellidos.autocorrectionType = .no
        txtPassword.autocorrectionType = .no
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("Todo OK")
        }
    }
    
    
    @IBAction func sendSingUp(_ sender: UIButton) {
        
    
        if txtEmail.text == ""{
            showAviso(msn: "El campo email es necesario")
        }else if txtNombre.text == ""{
            showAviso(msn: "El campo nombre es necesario")
        }else if txtApellidos.text == ""{
            showAviso(msn: "El campo Apellidos es necesario")
        }else if txtPassword.text == ""{
            showAviso(msn: "El campo contraseña es necesario")
        }else{
            
            print("go to Singup....");
            self.showLoading()
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
                if let _ = error{
                    self.showAviso(msn: (error?.localizedDescription)!)
                    self.hideLoading()
                }else{
                    
                    guard let user = authResult?.user else { return }
                    print(user);
                    user.sendEmailVerification(completion: { (error) in
                        if let _ = error{
                            self.showAviso(msn: (error?.localizedDescription)!)
                            self.hideLoading()
                        }else{
                            let name = self.txtNombre.text! + self.txtApellidos.text!
                            let profile = user.createProfileChangeRequest()
                            profile.displayName = name
                            
                            self.writeUserData(userId: user.uid, name:name, email: self.txtEmail.text!)
                        }
                    })
                    
                    
                    
                }
                
            }
            
        }
    
    
    }
    
    func showAviso(msn:String){
        let alert = UIAlertController(title: "Error", message: msn, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func writeUserData(userId:String, name:String, email:String) {
    
        ref.child("users").child(userId).setValue(["username": email,"name":name]) { (error, snapshot) in
            
            if let _ = error{
                self.showAviso(msn: (error?.localizedDescription)!)
                self.hideLoading()
            }else{
                
                self.hideLoading()
                // Create the alert controller
                let alertController = UIAlertController(title: "Registrado", message: "Registro realizado favor de iniciar sesion.", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    self.dismiss(animated: true, completion: {
                        print("Sali")
                    })
                }
             
                // Add the actions
                alertController.addAction(okAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }
    }
    

}
