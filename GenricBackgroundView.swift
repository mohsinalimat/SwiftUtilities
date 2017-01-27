//
//  GenricBackgroundView.swift
//  MedicalApp
//
//  Created by Apple on 14/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation



import UIKit

protocol UIViewLoading {}

class GenricBackgroundView: UIView
{
    //let viewBackGround1  : UIView?
    
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect)
     {
     // Drawing code
        print("draw rect of genric view ")
     }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        print("init with frame of generic view ")
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
         print("init coder of Genric background view ")
 
    }

    func addBackBackground()
    {

        
        let screenSize: CGRect = UIScreen.main.bounds
        
          print("frame",self.frame)
        
        print(" bounds ",self.bounds)
        
        let viewBackGround = UIView(frame: CGRect(x: -self.frame.origin.x , y:  -self.frame.origin.y  , width:  screenSize.width, height: screenSize.height))
        
         print(" viewBackGround bounds ",viewBackGround.frame)
        
        viewBackGround.backgroundColor = UIColor.black
        
        viewBackGround.alpha = 0.5
        
        self.insertSubview(viewBackGround, at: 0)
        //
        
        viewBackGround.isUserInteractionEnabled = false
        
        viewBackGround.sendSubview(toBack: self)
    }
    
    // hitTest:withEvent:
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool
    {
        return true
    }
    
}


extension UIViewLoading where Self : UIView
{
    
    // note that this method returns an instance of type `Self`, rather than UIView
    static func loadFromNib() -> Self
    {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
}

// FIXME:  HOW TO USE IN view controller
/*

 
 phoneVerificationAlert = Bundle.main.loadNibNamed("PhoneVerifyAlert", owner: self, options: nil)?[0] as? PhoneVerifyAlert
 view.addSubview(phoneVerificationAlert!)
 phoneVerificationAlert!.center = view.center
  cancelSubscriptionView?.delegate = self
 */
