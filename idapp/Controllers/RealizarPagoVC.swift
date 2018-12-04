//
//  RealizarPagoVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 19/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class RealizarPagoVC: UIViewController {
    //MARK: - Variables
    weak var delegateP: ConfirmPagoDelegate?
    
    //MARK: - IBOutlet
    @IBOutlet weak var txtFieldConcepto: textFieldCustomVC!
    @IBOutlet weak var txtFieldMonto: textFieldCustomVC!
    @IBOutlet weak var txtFieldNumTarjeta: textFieldCustomVC!
    @IBOutlet weak var txtFieldTitular: textFieldCustomVC!
    @IBOutlet weak var txtFieldFechaVencimiento: textFieldCustomVC!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonContinuar: UIButton!
    
    //MARK: - IBActions
    @IBAction func goToBack(_ sender: UIButton) {
        self.mostrarAlertTwoButtons(message: "Se borrarán todos tus datos sin guardar")
    }
    
    @IBAction func goToNextView(_ sender: UIButton) {
        if txtFieldConcepto.textField.text == "" ||
            txtFieldMonto.textField.text == "" ||
            txtFieldNumTarjeta.textField.text == "" ||
            txtFieldTitular.textField.text == "" ||
            txtFieldFechaVencimiento.textField.text == "" {
            self.mostrarAlert(message: "Llena todos los campos para continuar")
        }else{
            let storyboard = UIStoryboard(name: "Principal", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ConfirmarPagoVC") as! ConfirmarPagoVC
            controller.numTarjetaVC = txtFieldNumTarjeta.textField.text!
            controller.montoVC = txtFieldMonto.textField.text!
            controller.conceptoVC = txtFieldConcepto.textField.text!
            controller.delegate = delegateP
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBar()
        self.txtFieldConcepto.textField.delegate = self
        self.txtFieldMonto.textField.delegate = self
        self.txtFieldNumTarjeta.textField.delegate = self
        self.txtFieldTitular.textField.delegate = self
        self.txtFieldFechaVencimiento.textField.delegate = self
        
        self.buttonBack.layer.cornerRadius = 8
        self.buttonBack.clipsToBounds = true
        self.buttonContinuar.layer.cornerRadius = 8
        self.buttonContinuar.clipsToBounds = true
        
    }
    
    //MARK: - Funciones Controller
    func configNavBar(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        self.navigationItem.hidesBackButton = true
    }
    
    func mostrarAlert(message : String){
        let alertIhm = UIAlertController (title: "Aviso", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        alertIhm.addAction(okAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    
    func mostrarAlertTwoButtons(message : String){
        let alertIhm = UIAlertController (title: "Aviso", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertIhm.addAction(okAction)
        alertIhm.addAction(cancelAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    
    //MARK: - Memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- TextField Delegate
extension RealizarPagoVC: UITextFieldDelegate {
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
