//
//  FacturaVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 19/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class FacturaVC: BaseViewController {
    //MARK: - Variables
    var timer = Timer()
    var seconds = 0
    
    //MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var buttonBack: UIButton!
    
    //MARK: - IBActions
    @IBAction func backToDetalle(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        self.buttonBack.layer.cornerRadius = 8
        self.buttonBack.clipsToBounds = true
        
        self.configNavBar()
        self.loadFactura()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(loadingTimer), userInfo: nil, repeats: true)
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
    
    func loadFactura(){
        let urlstr:String = "https://serautonomo.net/wp-content/uploads/2008/11/factura-de-ventas.pdf"
        
        let url = URL(string: urlstr)!
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    @objc func loadingTimer(){
        self.seconds = self.seconds + 1
        print("second \(self.seconds)")
        if self.seconds == 2 {
            self.timer.invalidate()
            self.hideLoading()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FacturaVC: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Finish Load.....")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Swift.Error) {
        if let err = error as? URLError {
            
            switch(err.code) {  //  Exception occurs on this line
            case .cancelled:
                print("cancelled...")
                alertError(menssage: "Peticion cancelada")
                break
            case .cannotFindHost:
                print("cannotFindHost...")
                alertError(menssage: "Servidor no encontrado")
                break
            case .notConnectedToInternet:
                print("notConnectedToInternet...")
                alertError(menssage: "No hay conexion de Internet")
                break
            case .resourceUnavailable:
                print("resourceUnavailable...")
                alertError(menssage: "Rechazo del servidor")
                break
            case .timedOut:
                print("timedOut...")
                alertError(menssage: "El servidor no responde")
            default:
                print("not controler...")
                print("error code: " + String(describing: err.code) + "  does not fall under known failures")
                alertError(menssage: "Error no controlado")
            }
        }
    }
    
    func alertError(menssage:String){
        let alertController = UIAlertController(title: "Error", message: menssage, preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(aceptar)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

