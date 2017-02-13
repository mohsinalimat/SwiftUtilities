//
//  LeoExtentions.swift
//  MedicalApp
//
//  Created by Apple on 07/01/17.
//  Copyright © 2017 vijayvirSingh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    
    class func hexStr(hexStr: NSString, alpha: CGFloat) -> UIColor
    {
        
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        
        let scanner = Scanner(string: hexStr as String)
        
        var color: UInt32 = 0
        
        if scanner.scanHexInt32(&color)
        {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        else
        {
            print("invalid hex string", terminator: "")
            return UIColor.white
        }
    }
}

extension String
{
    
    func random6DigitString() -> String
    {
        let min: UInt32 = 100_000
        let max: UInt32 = 999_999
        let i = min + arc4random_uniform(max - min + 1)
        return String(i)
    }
    
    enum Header: String
    {
        case http = "http://"
        
        case https = "https://"
        
    }
    
    func isValidForUrl() -> Bool
    {
        
        if self.hasPrefix("http") || self.hasPrefix("https")
        {
            return true
        }
        return false
    }
    
    func validUrl(header: Header) -> String
    {
        if !self.hasPrefix("http")
        {
            return header.rawValue + self
        }
            
        else
        {
            return self
        }
        
    }
    
}

extension UIImage
{
    func base64Leo(compressionQuality: CGFloat) -> String
    {
        
        let imageData = UIImageJPEGRepresentation(self, compressionQuality)
        
        let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64String ?? ""
        
        // let some =  base64String!.replacingOccurrences(of: "\\/", with: "/")
        
        // return  some.replacingOccurrences(of: "\\/", with: "")
        
    }
    
    func base64ToImageLeo(_ base64String: String) -> UIImage
    {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0))
        
        let decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
    // prgm mark ----
    
    // convert images into base64 and keep them into string
    
}

extension UIView
{
    func addBorderApp()
    {
        
        self.layer.borderColor = AppColor.general.color.cgColor
        
        self.layer.borderWidth = 2
        
        self.layer.cornerRadius = 5
        
    }
    
}

var LeoAssociateKeyToolbarDone = "LeoAssociateKeyToolbarDone"
var LeoAssociateKeydToolbarNext = "LeoAssociateKeydToolbarNext"
var LeoAssociateKeydToolbarNextPrevious = "LeoAssociateKeydToolbarNextPrevious"

extension UIScrollView
{
    /**
     This method will add tool bar based on array
     
     - on:  array must be sorted according to your need
     
     */
    func leoToobar(on: [UIView])
    {
        
        if on.count > 0
        {
            registerKeyboardObserversForToolbar()
        }
        for (_, some) in on.enumerated()
        {
            if let textField = some as? UITextField
            {
                
                let toolbar = UIToolbar()
                
                toolbar.sizeToFit()
                
                let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
                
                objc_setAssociatedObject(donebutton, &LeoAssociateKeyToolbarDone, some, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
                var arraybutton: [UIBarButtonItem] = []
                
                if let index = on.index(of: some)
                {
                    
                    if index != 0, on[index - 1] is UITextField, let nextObject = on[index - 1] as? UITextField
                    {
                        let donebutton = UIBarButtonItem(title: "Previous", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
                        
                        objc_setAssociatedObject(donebutton, &LeoAssociateKeydToolbarNextPrevious, nextObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        
                        arraybutton.append(donebutton)
                    }
                    
                }
                
                if let index = on.index(of: some)
                {
                    
                    if index < on.count - 1, on[index + 1] is UITextField, let nextObject = on[index + 1] as? UITextField
                    {
                        let donebutton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
                        
                        objc_setAssociatedObject(donebutton, &LeoAssociateKeydToolbarNext, nextObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        
                        arraybutton.append(donebutton)
                    }
                    
                }
                
                arraybutton.append(space)
                
                arraybutton.append(donebutton)
                
                toolbar.setItems(arraybutton, animated: true)
                
                textField.inputAccessoryView = toolbar
                
            }
            
        }
    }
    
    func menuButtonTapped(sender: UIBarButtonItem)
    {
        
        if let done = objc_getAssociatedObject(sender, &LeoAssociateKeyToolbarDone) as! UITextField?
        {
            done.resignFirstResponder()
            
        }
        
        if let next = objc_getAssociatedObject(sender, &LeoAssociateKeydToolbarNext) as! UITextField?
        {
            next.becomeFirstResponder()
            
        }
        if let previous = objc_getAssociatedObject(sender, &LeoAssociateKeydToolbarNextPrevious) as! UITextField?
        {
            previous.becomeFirstResponder()
            
        }
        
    }
    
    func registerKeyboardObserversForToolbar()
    {
        print("registerKeyboardObserversForToolbar ")
        
        NotificationCenter.default.addObserver(self, selector: #selector(leoKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(leoKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    /**
     call this method  denit of class
     
     */
    
    func removeKeyboardObserversForToolbar()
    {
        print("removeKeyboardObserversForToolbar ")
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func leoKeyboardWillShow(notification: NSNotification)
    {
        print("Show toolbar ")
        
        if let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
            
        }
        else
        {
            print("Please see LeoExterntion for scrollview  leoKeyboardWillShow ")
            
        }
        
        //        if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        //            CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        //            [scrollView setContentOffset:scrollPoint animated:YES];
        //        }
        
    }
    
    func leoKeyboardWillHide(notification: NSNotification)
    {
        print("Hide toolbar ")
        
        if (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect) != nil
        {
            let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
            
            self.contentInset = contentInsets
            
            self.scrollIndicatorInsets = contentInsets
        }
        else
        {
            print("Please see LeoExterntion for scrollview leoKeyboardWillHide ")
            
        }
    }
    
}

//
// @IBDesignable extension UIView {
//    @IBInspectable var borderColor:UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor:color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var borderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
// }
