//
//  DetallePagoVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class DetallePagoVC: UIViewController {
    //MARK: - Variables
    var detalle : Pago!
    var dataFactura : DatosFactura!
    var tittles : [String] = [String]()
    var subtittles : [String] = [String]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewGeneral: UIView!
    @IBOutlet weak var viewSuperior: UIView!
    @IBOutlet weak var viewDatosFacturacion: UIView!
    @IBOutlet weak var viewOpFacturar: UIView!
    @IBOutlet weak var tableViewDetalle: UITableView!
    @IBOutlet weak var buttonVerFactura: UIButton!
    @IBOutlet weak var buttonReenviarFactura: UIButton!
    @IBOutlet weak var buttonOtrosDatos: UIButton!
    @IBOutlet weak var buttonGenerarFac: UIButton!
    
    @IBOutlet weak var lblRazonSocial: UILabel!
    @IBOutlet weak var lblRFC: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    
    //MARK: - IBActions
    @IBAction func goToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToViewFactura(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Principal", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FacturaVC") as! FacturaVC
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBar()
        self.llenarDatos()
        self.tableViewDetalle.delegate = self
        self.tableViewDetalle.dataSource = self
        tableViewDetalle.register(UINib(nibName: "DetallePagoTableViewCell", bundle: nil), forCellReuseIdentifier: "DetallePagoTableViewCell")
        
        self.buttonBack.layer.cornerRadius = 10
        self.buttonBack.clipsToBounds = true
        
        self.buttonGenerarFac.layer.cornerRadius = 8
        self.buttonGenerarFac.clipsToBounds = true
        
        self.viewGeneral.layer.cornerRadius = 10
        self.viewGeneral.clipsToBounds = true
        self.viewGeneral.layer.borderColor = UIColor.grisDetallePago().cgColor
        self.viewGeneral.layer.borderWidth = 1
        
        self.buttonVerFactura.underline()
        self.buttonReenviarFactura.underline()
        
        if detalle.facturado{
            self.viewDatosFacturacion.isHidden = false
            self.viewOpFacturar.isHidden = true
        }else{
            self.viewDatosFacturacion.isHidden = true
            self.viewOpFacturar.isHidden = false
        }
        
        print("Datos para facturar o reenviar idProd\(detalle.idFac) idFac: \(detalle.idFac)")
        
        
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
    
    func llenarDatos(){
        tittles.removeAll()
        tittles.append("Monto pagado:")
        tittles.append("Concepto:")
        tittles.append("Método de pago:")
        tittles.append("Fecha de pago:")
        tittles.append("Hora de pago:")
        tittles.append("Facturado:")
        
        subtittles.removeAll()
        subtittles.append("$" + detalle.monto)
        subtittles.append(detalle.concepto)
        if detalle.metodoPago == "paypal"{
           subtittles.append(detalle.metodoPago)
        }else{
           subtittles.append("**** **** **** " + detalle.metodoPago)
        }
        subtittles.append(detalle.fechaPago)
        subtittles.append(detalle.horaPago)
        if detalle.facturado{
            subtittles.append("Si")
            
        }else{
            subtittles.append("No")
        }
        
        self.lblRazonSocial.text = dataFactura.razonSocial
        self.lblRFC.text = dataFactura.rfc
        self.lblDireccion.text = dataFactura.direccion
    }
    
    //MARK: - Memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableView DataSource
extension DetallePagoVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DetallePagoTableViewCell = tableViewDetalle.dequeueReusableCell(withIdentifier: "DetallePagoTableViewCell") as! DetallePagoTableViewCell
        
        cell.tittle.text = tittles[indexPath.row]
        
        if indexPath.row == 0{
            cell.detalleOne.isHidden = false
            cell.detalleTwo.isHidden = true
            cell.detalleOne.text = subtittles[indexPath.row]
        }else{
            cell.detalleOne.isHidden = true
            cell.detalleTwo.isHidden = false
            cell.detalleTwo.text = subtittles[indexPath.row]
        }
        
        cell.selectionStyle = .none
        return cell
    }
}


//MARK: - UITableView Delegate
extension DetallePagoVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewSuperior.bounds.height / 6
    }
}
