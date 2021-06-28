//
//  BaseViewController.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var baseVwModel: BaseViewModel?
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
