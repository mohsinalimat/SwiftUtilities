//
//  LEOFullscreenImageViewController.swift
//  MedicalApp
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

/* 
  Last update 
 
 Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
 Target: x86_64-apple-macosx10.9
 
 For more help : https://github.com/bogardon/GGFullscreenImageViewController
 
 
 Rotation things are left
 */


import UIKit
let  kAnimationDuration : Double = 0.3;


class LEOFullscreenImageViewController: UIViewController , UIScrollViewDelegate , CAAnimationDelegate
{
    
    
    // MARK: Outlets
    

    // MARK: Variables
    
   var liftedImageView : UIImageView? = nil
    
    var scrollView : UIScrollView?
    var containerView : UIView?
    var imageView : UIImageView? = nil
    
    var fromOrientation : UIInterfaceOrientation?
    var toOrientation : UIInterfaceOrientation?
    
  
    // MARK: CLC
    
    
    
    override func loadView() {
        
        super.loadView()
        
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.backgroundColor = .black
        
        self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView?.delegate = self
        self.scrollView?.maximumZoomScale = 1;
        self.scrollView?.autoresizingMask = self.view.autoresizingMask;
        self.view.addSubview(self.scrollView!)
        
        self.containerView = UIView(frame: self.view.bounds)
        self.containerView?.autoresizingMask = self.view.autoresizingMask;
        
        self.scrollView?.addSubview(self.containerView!)
     
        
        self.imageView =  UIImageView(frame: (self.containerView?.bounds)!)

        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onDismiss(_:)))
        self.scrollView?.addGestureRecognizer(tap)
        
        
        
    }
    
    func onDismiss(_ sender: UITapGestureRecognizer)
    {
        self.dismiss(animated: false, completion:nil)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("Here I come first viewDidLoad")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
    
        print("Here I come first viewWillAppear")
        super.viewWillAppear(true )

        let window = UIApplication.shared.keyWindow
       
        if (self.liftedImageView != nil &&  ((self.liftedImageView?.image!) != nil))
        {
            self.liftedImageView?.isHidden = true
           
            self.imageView?.image = self.liftedImageView?.image!
            self.imageView?.contentMode = (self.liftedImageView?.contentMode)!
            self.imageView?.clipsToBounds = (self.liftedImageView?.clipsToBounds)!;
        }
      
       
        
        let startFrame : CGRect = (self.liftedImageView?.convert(self.liftedImageView!.frame, to: window))!
        
        self.imageView?.layer.position = CGPoint(x: startFrame.origin.x + floor(startFrame.size.width / CGFloat( 2.0)),
                                                 y: startFrame.origin.y + floor(startFrame.size.height / CGFloat( 2.0)))
            
            
        let orientation : UIInterfaceOrientation = UIApplication.shared.statusBarOrientation;
        
        
        
    
        
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            self.imageView?.layer.bounds = CGRect(x: 0, y: 0, width: startFrame.size.width, height: startFrame.size.height)
                
                
            
        } else
        {
              self.imageView?.layer.bounds = CGRect(x: 0, y: 0, width: startFrame.size.height, height: startFrame.size.width)
            
           
        }
        

        
        
        if (orientation == .portraitUpsideDown)
        {
            self.imageView?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1);
        } else if (orientation == .landscapeLeft) {
            self.imageView?.layer.transform = CATransform3DMakeRotation(-(CGFloat)(M_PI_2), 0, 0, 1);
        } else if (orientation == .landscapeRight) {
            self.imageView?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1);
        } else {
            self.imageView?.layer.transform = CATransform3DIdentity;
        }
        
        window?.addSubview(self.imageView!)

        //[window addSubview:self.imageView];
        
        self.fromOrientation = UIApplication.shared.statusBarOrientation;
        self.toOrientation = self.presentingViewController?.preferredInterfaceOrientationForPresentation;
        
        
       
        
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
         print("Here I come first viewDidAppear")
        
        
        
        
        
        
        
        
        
        let window = UIApplication.shared.keyWindow
        
        
         let endFrame : CGRect = (self.containerView?.convert(self.containerView!.bounds, to: window))!
        
      //  CGRect endFrame = [self.containerView convertRect:self.containerView.bounds toView:window];
        
      
        let center  : CABasicAnimation = CABasicAnimation(keyPath: "position")
        center.fromValue = self.imageView?.layer.position
        center.toValue = CGPoint(x: floor(endFrame.size.width/CGFloat( 2.0)),
                                 y: floor(endFrame.size.height/CGFloat( 2.0)))
        
     //   center.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position];
       // center.toValue = [NSValue valueWithCGPoint:CGPointMake(floorf(endFrame.size.width/2),floorf(endFrame.size.height/2))];
        
        
        let scale  : CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        scale.fromValue = self.imageView?.layer.bounds
        
        
        
       // CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"bounds"];
        //scale.fromValue = [NSValue valueWithCGRect:self.imageView.layer.bounds];
        
        
        let rotate  : CABasicAnimation = CABasicAnimation(keyPath: "transform")
        rotate.fromValue = self.imageView?.layer.transform
        
        
        //CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:"transform"];
       // rotate.fromValue = self.imageView.layer.transform;
        
        let from : UIInterfaceOrientation  = self.fromOrientation!;
        let  to  : UIInterfaceOrientation = self.toOrientation!;
        
        
        
        
       let imageSize : CGSize = self.liftedImageView!.image!.size;
        
        var  maxHeight : CGFloat = 0;
        var  maxWidth : CGFloat = 0;
        
        if (UIInterfaceOrientationIsPortrait(to))
        {
            // 570/323 = 320/y
            maxHeight = min(endFrame.size.height, endFrame.size.width*imageSize.height/imageSize.width)
            //(endFrame.size.height,endFrame.size.width*imageSize.height/imageSize.width);
            maxWidth = max(endFrame.size.width, endFrame.size.height*imageSize.width/imageSize.height);
            
        } else {
            // 570/323 = x/568
            maxHeight = min(endFrame.size.width,endFrame.size.height*imageSize.height/imageSize.width);
            maxWidth = max(endFrame.size.height, endFrame.size.width*imageSize.width/imageSize.height);
        }
        scale.toValue = CGRect(x: 0, y: 0, width: maxWidth, height: maxHeight)
        
            
       //     [NSValue valueWithCGRect:CGRectMake(0, 0, maxWidth, maxHeight)];
        
       // NSInteger factor = RadianDifference(from, to);
        
        //rotate.toValue = CATransform3DRotate(self.imageView!.layer.transform, (CGFloat(M_PI_2)) , 0, 0, 1)
        
            
            //[NSValue valueWithCATransform3D:CATransform3DRotate(self.imageView.layer.transform, factor*M_PI_2, 0, 0, 1)];
        
        
        
        let group  : CAAnimationGroup = CAAnimationGroup()
        
        
        
       // CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = kAnimationDuration;
        group.delegate = self;
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
           // [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.animations = [scale,rotate,center];
        
        group.setValue("expand", forKey: "type")
        
        //[group setValue:@"expand" forKey:@"type"];
        
        self.imageView?.layer.position =  center.toValue as! CGPoint
        
        self.imageView?.layer.bounds = scale.toValue as! CGRect
        
            
           // [scale.toValue CGRectValue];
     
        
        //self.imageView?.layer.transform = rotate.toValue  as! CATransform3Dtr
            
            
         //   [rotate.toValue CATransform3DValue];
        
        self.imageView?.layer.add(group, forKey: nil)
        
        
       // [self.imageView.layer addAnimation:group forKey:nil];
        
        
        
        
        
        
        
        
        
        
        
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        
        super.viewWillDisappear(true )
        
         print("Here I come first viewWillDisappear")
        
        
        
        
        
      let window = UIApplication.shared.keyWindow
      
        
         let startFrame : CGRect = (self.containerView?.convert(self.imageView!.frame, to: window))!
        
        //CGRect startFrame = [self.containerView convertRect:self.imageView.frame toView:window];
        
        self.imageView?.layer.position =  CGPoint(x: startFrame.origin.x + floor(startFrame.size.width / CGFloat( 2.0)),
                                                  y: startFrame.origin.y + floor(startFrame.size.height / CGFloat( 2.0)))
        
        
        
        
        let orientation : UIInterfaceOrientation = UIApplication.shared.statusBarOrientation;
        
        
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            self.imageView?.layer.bounds = CGRect(x: 0, y: 0, width: startFrame.size.width, height: startFrame.size.height)
            
            
            
        } else
        {
            self.imageView?.layer.bounds = CGRect(x: 0, y: 0, width: startFrame.size.height, height: startFrame.size.width)
            
            
        }
        
        
      
        if (orientation == .portraitUpsideDown)
        {
            self.imageView?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1);
        } else if (orientation == .landscapeLeft) {
            self.imageView?.layer.transform = CATransform3DMakeRotation(-(CGFloat)(M_PI_2), 0, 0, 1);
        } else if (orientation == .landscapeRight) {
            self.imageView?.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1);
        } else {
            self.imageView?.layer.transform = CATransform3DIdentity;
        }
        
        
       window?.addSubview(self.imageView!)
        
        
        
        self.fromOrientation = UIApplication.shared.statusBarOrientation;
        self.toOrientation = self.presentingViewController?.preferredInterfaceOrientationForPresentation;
    
        
        
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true )
        
         print("Here I come first viewDidDisappear")
        
        
        
        
        
        let window = UIApplication.shared.keyWindow
        
         let endFrame : CGRect = (self.liftedImageView?.superview?.convert(self.liftedImageView!.frame , to: window))!
        
        //CGRect endFrame = [self.liftedImageView.superview convertRect:self.liftedImageView.frame toView:window];
        
       // CABasicAnimation *center = [CABasicAnimation animationWithKeyPath:@"position"];
      //  center.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position];
      //  center.toValue = [NSValue valueWithCGPoint:CGPointMake(endFrame.origin.x + floorf(endFrame.size.width/2),
       //                                                         endFrame.origin.y + floorf(endFrame.size.height/2))];
        
        
        let center  : CABasicAnimation = CABasicAnimation(keyPath: "position")
        center.fromValue = self.imageView?.layer.position
        center.toValue = CGPoint(x: endFrame.origin.x  + floor(endFrame.size.width/CGFloat( 2.0)),
                                 y: endFrame.origin.y + floor(endFrame.size.height/CGFloat( 2.0)))
        
        
        
        
        let scale  : CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        scale.fromValue = self.imageView?.layer.bounds
        
        
       // CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"bounds"];
       // scale.fromValue = [NSValue valueWithCGRect:self.imageView.layer.bounds];
      
        
        let rotate  : CABasicAnimation = CABasicAnimation(keyPath: "transform")
        rotate.fromValue = self.imageView?.layer.transform
        
        
        //CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform"];
        //rotate.fromValue = [NSValue valueWithCATransform3D:self.imageView.layer.transform];
        
        let from : UIInterfaceOrientation  = self.fromOrientation!;
        let  to  : UIInterfaceOrientation = self.toOrientation!;
        
        if (UIInterfaceOrientationIsPortrait(to)) {
            scale.toValue =  CGRect(x: 0, y: 0, width: endFrame.size.width, height: endFrame.size.height)
                
                //[NSValue valueWithCGRect:CGRectMake(0, 0, endFrame.size.width, endFrame.size.height)];
        } else {
            
            scale.toValue = CGRect(x: 0, y: 0, width: endFrame.size.height, height: endFrame.size.width)
                //[NSValue valueWithCGRect:CGRectMake(0, 0, endFrame.size.height, endFrame.size.width)];
        }
        
      //  NSInteger factor = RadianDifference(from, to);
       // rotate.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.imageView.layer.transform, factor*M_PI_2, 0, 0, 1)];
        
          let group  : CAAnimationGroup = CAAnimationGroup()
        group.duration = kAnimationDuration;
        group.delegate = self;
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.animations = [scale,rotate,center];
        
        group.setValue("contract", forKey: "type")
        
        
//        CAAnimationGroup *group = [CAAnimationGroup animation];
//        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        group.duration = kAnimationDuration;
//        group.delegate = self;
//        group.animations = @[scale,rotate,center];
//        [group setValue:@"contract" forKey:@"type"];
        
        self.imageView?.layer.position = center.toValue as! CGPoint ;
        self.imageView?.layer.bounds =  scale.toValue as! CGRect ;
       // self.imageView.layer.transform = [rotate.toValue CATransform3DValue];
       // [self.imageView.layer addAnimation:group forKey:nil];
    
        self.imageView?.layer.add(group, forKey: nil)
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    

    // MARK: Actions

    // MARK: Functions
    
    
    
   // MARK: - CAAnimationDelegate
    
    func animationDidStart(_ anim: CAAnimation)
    {
        if anim.value(forKey: "type") as! String  == "expand"
        {
            self.liftedImageView?.isHidden = true
        }
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        if anim.value(forKey: "type") as! String  == "contract"
        {
            self.liftedImageView?.isHidden = false;
            
            self.imageView?.removeFromSuperview()
            
        }
        else if anim.value(forKey: "type") as! String  == "expand"
        {
            self.imageView?.layer.position = (self.containerView?.layer.position)!;
            
           self.imageView?.layer.transform = CATransform3DIdentity;
            
            self.containerView?.addSubview(self.imageView!)
            
        }
       
    }
    // MARK: ScrollView Delegate 
    
     func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.containerView;

    }
}
