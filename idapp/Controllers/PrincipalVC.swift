//
//  PrincipalVC.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit

class PrincipalVC: UIViewController {
    //MARK: - Variables
    var dataPago = [Pago]()
    var dataFactura = [DatosFactura]()
    let real : RealTimeService = RealTimeService()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var buttonNuevoPago: UIButton!
    @IBOutlet weak var tableViewPagos: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tableViewMenu: UITableView!
    
    
    //MARK: - IBActions
    @IBAction func goToNuevoPago(_ sender: UIButton) {
        print("Ir a nuevo pago..")
        let storyboard = UIStoryboard(name: "Principal", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RealizarPagoVC") as! RealizarPagoVC
        controller.delegateP = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewPagos.delegate = self
        self.tableViewPagos.dataSource = self
        
        self.tableViewMenu.delegate = self
        self.tableViewMenu.dataSource = self
        
        tableViewPagos.register(UINib(nibName: "PagosTableViewCell", bundle: nil), forCellReuseIdentifier: "PagosTableViewCell")
        
        tableViewMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        self.configNavBar()
        self.buttonNuevoPago.layer.cornerRadius = 10
        self.buttonNuevoPago.clipsToBounds = true
        
        self.getPayments(pickerTextField: UITextField())
        
//        self.addBlurEffect(view: self.menuView)
    }
    
    
    //MARK: - Funciones Controller
    func configNavBar(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(UIImage(named: "icoMenu"), for: UIControlState.normal)
        button.frame = CGRect(x: (customView.frame.width - 25), y: 8, width: 32, height: 32)
        button.addTarget(self, action: #selector(self.didTapButton(sender:)), for: UIControlEvents.touchUpInside)
        customView.addSubview(button)
        let rightButton = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func mostrarErrorAlert(msj:String){
        let alertIhm = UIAlertController (title: "Error", message: msj, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertIhm.addAction(okAction)
        self.present(alertIhm, animated: true, completion: nil)
    }
    
    func addBlurEffect(view:UIView){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    
    //MARK: - Funciones WS
    func getPayments(pickerTextField: UITextField){
        let uid = UserDefaults.standard.value(forKey: "UID") as! String
        real.getPayments(uid: uid) { (data, error) in
            if let _ = error{
                self.mostrarErrorAlert(msj: (error?.localizedDescription)!)
            }else{
                self.responsePayments(response: data!)
            }
        }
    }
    
    func responsePayments(response:[Payment]){
        self.dataPago.removeAll()
        self.dataFactura.removeAll()
        
        for obj in response{
            let fechaPago = formatDateToFirebase(serverDate: obj.created_at!)
            let horaPago = formatOurToFirebase(timeStamp: obj.created_at!)
            
            let resp = Pago(concepto: ("Pago de Colegiatura"),
                            fechaPago: fechaPago,
                            monto: obj.amount?.stringValue ?? "0.0",
                            facturado: (obj.dataFactura?.first?.facturado?.boolValue ?? false ),
                            metodoPago: obj.charges?.first?.data?.first?.payment_method?.first?.last4 ?? "****",
                            horaPago: horaPago)
            
            dataPago.append(resp)
            
            let fac = DatosFactura.init(razonSocial: obj.customer_info?.first?.name ?? "",
                                        rfc: obj.customer_info?.first?.object ?? "",
                                        direccion: obj.customer_info?.first?.email ?? "")
            dataFactura.append(fac)
        }
        self.tableViewPagos.reloadData()
    }
    
    
    //MARK: - Formatos
    func formatDateToFirebase(serverDate:NSNumber)->String{
        let unixTimestamp = serverDate.doubleValue
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-6") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
    func formatOurToFirebase(timeStamp : NSNumber) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp.doubleValue)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: "GMT-6")
        dayTimePeriodFormatter.locale = NSLocale.current
        //        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        let ourString = dayTimePeriodFormatter.string(from: date as Date)
        
        return ourString
    }
    
    
    //MARK: - Gestures
    @objc func didTapButton(sender: UITapGestureRecognizer){
        print("MENU..")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - UITableView DataSource
extension PrincipalVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewPagos{
            return dataPago.count
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewPagos{
            let cell: PagosTableViewCell = tableViewPagos.dequeueReusableCell(withIdentifier: "PagosTableViewCell") as! PagosTableViewCell
            
            cell.concepto.text = dataPago[indexPath.row].concepto
            cell.fechaPago.text = dataPago[indexPath.row].fechaPago
            cell.montoPago.text = "$" + dataPago[indexPath.row].monto
            if dataPago[indexPath.row].facturado{
                cell.imageFacturado.image = #imageLiteral(resourceName: "icoFacturadoOk")
            }else{
                cell.imageFacturado.image = #imageLiteral(resourceName: "icoFacturadoFail")
            }
            
            if indexPath.row % 2 == 0 {
                cell.view.backgroundColor = UIColor.grisCeldaPago()
            }else{
                cell.view.backgroundColor = UIColor.white
            }
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell: MenuTableViewCell = tableViewMenu.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
            
            cell.titleOption.text = "Opción menú \(indexPath.row)"
            cell.selectionStyle = .none
            return cell
        }
    }
}


//MARK: - UITableView Delegate
extension PrincipalVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewPagos{
            let storyboard = UIStoryboard(name: "Principal", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetallePagoVC") as! DetallePagoVC
            
            controller.detalle = dataPago[indexPath.row]
            controller.dataFactura = dataFactura[indexPath.row]
            
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            print("Opción \(indexPath.row) del menú")
        }
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if tableView == tableViewPagos{
                return 120
            }else{
                return self.menuView.frame.height / 6
            }
        }
}


//MARK: - Protocolo ConfirmPago
extension PrincipalVC: ConfirmPagoDelegate{
    func cobroExitosoFinish(pago: Pago) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dataPago.append(pago)
        self.tableViewPagos.reloadData()
    }
}

