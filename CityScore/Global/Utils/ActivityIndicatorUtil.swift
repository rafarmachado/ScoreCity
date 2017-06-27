
//
//  ActivityIndicatorUtil.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit

class ActivityIndicatorUtil: UIView {
    
    var overlayView: UIView?
    var mainView: UIView?
    var activityIndicator: UIActivityIndicatorView?
    
    convenience init(view: UIView) {
        
        self.init()
        mainView = view
        
        overlayView = UIView()
        overlayView?.frame = view.frame
        overlayView?.backgroundColor = UIColor.black
        overlayView?.alpha = 0.8
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = (overlayView?.center)!
        activityIndicator?.startAnimating()
    }
    
    func showActivityIndicator(){
        self.mainView?.addSubview(overlayView!)
        self.mainView?.addSubview(activityIndicator!)
    }
    
    func hideActivityIndicator(){
        self.overlayView?.removeFromSuperview()
        self.activityIndicator?.removeFromSuperview()
    }
    
    
    
}
