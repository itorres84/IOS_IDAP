//
//  ViewController.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 17/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit
import Firebase

class ViewController: BaseViewController {
    //MARK: - Variables
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: - IBOutlets
    @IBOutlet weak var buttonSesion: UIButton!
    @IBOutlet weak var buttonForgetPassword: UIButton!
    @IBOutlet weak var txtFieldMail: textFieldCustomVC!
    @IBOutlet weak var txtFieldPwd: textFieldCustomVC!
    
    //MARK: - IBActions
    @IBAction func iniciarSesion(_ sender: UIButton) {
        print("Presionaste iniciar sesión...")
        self.showLoading()
        let mail:String = txtFieldMail.textField.text!
        let pwd:String = txtFieldPwd.textField.text!
        print("Mail: \(txtFieldMail.textField.text!)")
        print("Pwd: \(txtFieldPwd.textField.text!)")
        if mail != "" && pwd != ""{
            
            Auth.auth().signIn(withEmail: mail, password: pwd) { (user, error) in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    self.txtFieldMail.textField.text = ""
                    self.txtFieldPwd.textField.text = ""
                    self.hideLoading()
                    self.mostrarErrorAlert(msj: error.localizedDescription)
                    return
                }
                UserDefaults.standard.set(user?.user.uid, forKey: "UID")
                UserDefaults.standard.synchronize()
                self.hideLoading()
                self.mostrarPrincipal()
            }
            
        }else{
            self.hideLoading()
            self.mostrarAlert()
        }
    }
    
    @IBAction func restablecerPwd(_ sender: UIButton) {
        print("Presionaste reestablecer password...")
    }
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldMail.textField.delegate = self
        self.txtFieldPwd.textField.delegate = self
        self.buttonSesion.layer.cornerRadius = 10
        self.buttonSesion.clipsToBounds = true
        self.buttonForgetPassword.underline()
        
        self.txtFieldMail.textField.text = "israeltorres27@gmail.com"
        self.txtFieldPwd.textField.text = "123456"
        
//        self.txtFieldMail.textField.text = "itorresa@pagatodo.com"
//        self.txtFieldPwd.textField.text = "123456"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print("User: \(user.debugDescription)")
//            self.setTitleDisplay(user)
//            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    //MARK: - Funcliones Controller
    func mostrarPrincipal(){
        let storyboard = UIStoryboard(name: "Principal", bundle: nil)
        let navigation:UINavigationController = storyboard.instantiateViewController(withIdentifier: "PrincipalViewController") as! UINavigationController
//        let controller:PrincipalVC = (navigation.viewControllers.first as? PrincipalVC)!
        self.present(navigation, animated: true, completion: nil)
    }
    
    func mostrarAlert(){
        let alertIhm = UIAlertController (title: "Aviso", message: "\nLlena todos los campos para continuar", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        alertIhm.addAction(okAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    
    func mostrarErrorAlert(msj:String){
        let alertIhm = UIAlertController (title: "Error", message: msj, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
            UIAlertAction in
//            self.mostrarPrincipal()
        }
        alertIhm.addAction(okAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    //MARK: - Memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField){
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
}

