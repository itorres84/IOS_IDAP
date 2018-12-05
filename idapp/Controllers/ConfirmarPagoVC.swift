//
//  ConfirmarPagoVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 19/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

protocol ConfirmPagoDelegate : class {
    func cobroExitosoFinish(pago:Pago)
}
class ConfirmarPagoVC: UIViewController {
    //MARK: - Variables
    weak var delegate: ConfirmPagoDelegate?
    var requiereFactura = true
    var numTarjetaVC = ""
    var montoVC = ""
    var conceptoVC = ""
    
    //MARK: - OIBOutlets
    @IBOutlet weak var imageTipoTarjeta: UIImageView!
    @IBOutlet weak var labelNumTarjeta: UILabel!
    @IBOutlet weak var txtFieldDigitosSeguridad: textFieldCustomVC!
    @IBOutlet weak var labelMonto: UILabel!
    @IBOutlet weak var labelConcepto: UILabel!
    @IBOutlet weak var viewButtonCheck: UIView!
    @IBOutlet weak var buttonCheckFactura: UIButton!
    @IBOutlet weak var buttonUsarOtrosDatos: UIButton!
    @IBOutlet weak var buttonPagar: UIButton!
    @IBOutlet weak var buttonRegresar: UIButton!
    @IBOutlet weak var viewDatosParaFactura: UIView!
    
    //MARK: - IBActions
    @IBAction func requerirFactura(_ sender: UIButton) {
        
        if !requiereFactura{
            self.buttonCheckFactura.setImage(UIImage(named: "icoCheckVacio"), for: .normal)
            requiereFactura = true
            self.viewDatosParaFactura.isHidden = true
        }else{
            self.buttonCheckFactura.setImage(UIImage(named: "icoCheck"), for: .normal)
            requiereFactura = false
            self.viewDatosParaFactura.isHidden = false
        }
    }
    
    @IBAction func usarOtrosDatos(_ sender: UIButton) {
        print("Usar otros datos")
    }
    
    @IBAction func pagar(_ sender: UIButton) {
        if txtFieldDigitosSeguridad.textField.text != ""{
            self.mostrarAlert(message: "\n¡Tu pago ha sido COMPLETADO con éxito!\n", exito: true)
        }else{
            self.mostrarAlert(message: "\nIngresa el código de seguridad para efectuar el pago", exito: false)
        }
    }
    
    @IBAction func goToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldDigitosSeguridad.textField.delegate = self
        self.configNavBar()
        self.configView()
        self.llenarDatos()
    }
    
    //MARK: - Funciones Controller
    func llenarDatos(){
        self.labelNumTarjeta.text = numTarjetaVC
        self.labelMonto.text = "$" + montoVC
        self.labelConcepto.text = conceptoVC
        self.buttonPagar.setTitle("Pagar $" + montoVC, for: .normal)
    }
    
    func configNavBar(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        self.navigationItem.hidesBackButton = true
    }
    
    func configView(){
        self.viewButtonCheck.layer.borderWidth = 0.5
        self.viewButtonCheck.layer.borderColor = UIColor.azulBordeCheck().cgColor
        self.viewButtonCheck.layer.cornerRadius = 4
        self.viewButtonCheck.clipsToBounds = true
        
        self.buttonUsarOtrosDatos.underline()
        self.buttonPagar.layer.cornerRadius = 8
        self.buttonPagar.clipsToBounds = true
        self.buttonRegresar.underline()
    }
    
    func mostrarAlert(message : String, exito : Bool){
        var titulo = ""
        var mensaje = message
        var buttonTitle = "Aceptar"
        if exito{
            titulo = message
            mensaje = ""
            buttonTitle = "Ver mis pagos"
        }
        let alertIhm = UIAlertController (title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            if exito {
                let pagoActual : Pago = Pago(concepto: self.labelConcepto.text!,
                                             fechaPago: "Hoy",
                                             monto: self.montoVC,
                                             facturado: !self.requiereFactura,
                                             metodoPago: "**** ****",
                                             horaPago: "0:00am", id: "", idProd: "", idFac: "")
                self.delegate?.cobroExitosoFinish(pago: pagoActual)
            }
        }
        alertIhm.addAction(okAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    
    //MARK: - Memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- TextField Delegate
extension ConfirmarPagoVC: UITextFieldDelegate {
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
