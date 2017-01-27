//
//  GenericViewController.swift
//  MedicalApp
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class GenericViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.navigationController?.navigationBar.isHidden = true
       UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
      
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func actionBack(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
    }

    func showAlert(  _ message :String ,  on : UIViewController , completionHandler : (() -> Swift.Void)? = nil )
    {
        let keywindow = UIApplication.shared.keyWindow
        let mainController = keywindow?.rootViewController
        
        DispatchQueue.main.async
            {
               
                let alert = UIAlertController(title: "\(appName)", message: message, preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                    
                    print("Heloo ")
                    
                    completionHandler?()
                    
                }))

                on.present(alert,animated:     true ,completion:
                    {
                  })
                
        }
  
        
    }
    
    func showAlert(  _ message :String , completionHandler : (() -> Swift.Void)? = nil )
    {
        
        
        DispatchQueue.main.async
            {
            let keywindow = UIApplication.shared.keyWindow
            let mainController = keywindow?.rootViewController
            let alert = UIAlertController(title: "\(appName)", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                
                print("Heloo ")
                
                completionHandler?()
                
            }))
            
            mainController?.present(alert,animated:     true ,completion:
                {
                    
            })
            
            
        }
        
    
        
        
      
    }

}
