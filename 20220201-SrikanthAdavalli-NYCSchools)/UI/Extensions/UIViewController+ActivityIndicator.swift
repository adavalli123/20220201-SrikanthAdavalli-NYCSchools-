//
//  UIViewController+ActivityIndicator.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import UIKit
// source code is from ==> https://www.appcodezip.com/2021/06/iOS-UIActivityIndicatorView.html

struct ProgressDialog {
    static var alert = UIAlertController()
    static var progressView = UIProgressView()
    static var progressPoint : Float = 0{
        didSet{
            if(progressPoint == 1){
                ProgressDialog.alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
extension UIViewController{
   func loadingStart(){
        ProgressDialog.alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
       loadingIndicator.style = UIActivityIndicatorView.Style.large
    loadingIndicator.startAnimating();

    ProgressDialog.alert.view.addSubview(loadingIndicator)
    present(ProgressDialog.alert, animated: true, completion: nil)
  }

  func loadingStop(){
    ProgressDialog.alert.dismiss(animated: true, completion: nil)
  }
}
