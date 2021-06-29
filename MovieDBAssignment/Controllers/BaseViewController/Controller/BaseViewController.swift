//
//  BaseViewController.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var baseVwModel: BaseViewModel?
    
    private let indicator = UIActivityIndicatorView()
    private let indicatorView = UIView()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupLoadingClosure(){
        baseVwModel?.loadingIndicator = {(status) in
            DispatchQueue.main.async {
                status ? self.showIndicator() : self.dismissIndicator()
            }
        }
    }
    
    //Controller object
    func getController(storyboard: String = "Main", controllerId: String)-> UIViewController{
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(identifier: controllerId)
    }
    
    //Navigation bar setup
    func setupNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.hidesBackButton = true
    }
    
    //Loading indicator show hide
    func showIndicator() {
        DispatchQueue.main.async { [self] in
            self.indicatorView.frame = view.frame
            self.indicator.center = indicatorView.center
            self.indicatorView.addSubview(self.indicator)
            self.indicator.hidesWhenStopped = true
            self.indicator.style = .large
            indicator.color = .white
            self.indicator.startAnimating()
            self.view.addSubview(self.indicatorView)
        }
    }
    
    func dismissIndicator() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicatorView.removeFromSuperview()
        }
    }
}
