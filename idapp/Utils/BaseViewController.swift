//
//  BaseViewController.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 04/12/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    //MARK: - Varibles
    var loading:NVActivityIndicatorView!
    var lblLoadingStatus:UILabel!
    var viewLoadingBackground:UIView!
    var isLoading: Bool = false
    
    //MARK: - Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoading()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: - Controller
    func initLoading(){
        loading = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), type: .ballClipRotatePulse, color: UIColor.white, padding: 0)
        loading.center = CGPoint(x:UIScreen.main.bounds.width/2, y:UIScreen.main.bounds.height/2)
        lblLoadingStatus = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        lblLoadingStatus.textAlignment = .center
        lblLoadingStatus.font = UIFont.systemFont(ofSize: 17)
        lblLoadingStatus.textColor = .white
        lblLoadingStatus.center = CGPoint(x:UIScreen.main.bounds.width/2, y:(UIScreen.main.bounds.height/2)+80)
        viewLoadingBackground = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        viewLoadingBackground.backgroundColor = UIColor.black
        viewLoadingBackground.alpha = 0
    }
    
    func showLoading(){
        if !isLoading{
            isLoading = true
            DispatchQueue.main.async(execute:
                {
                    UIApplication.shared.keyWindow?.addSubview(self.viewLoadingBackground)
                    UIApplication.shared.keyWindow?.addSubview(self.loading)
                    UIApplication.shared.keyWindow?.addSubview(self.lblLoadingStatus)
                    self.viewLoadingBackground.alpha = 0.6
                    self.loading.alpha = 1
                    self.lblLoadingStatus.alpha = 0
                    self.loading.startAnimating()
                    self.lblLoadingStatus.alpha = 1
                    
                    self.view.isUserInteractionEnabled = false
            })
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async(execute: {
            self.loading.alpha = 0
            self.loading.stopAnimating()
            self.loading.alpha = 1
        
            self.lblLoadingStatus.alpha = 0
            self.viewLoadingBackground.alpha = 0
            self.viewLoadingBackground.removeFromSuperview()
            self.loading.removeFromSuperview()
            self.lblLoadingStatus.removeFromSuperview()
        
            self.isLoading = false
            self.view.isUserInteractionEnabled = true
        })
    }
}
