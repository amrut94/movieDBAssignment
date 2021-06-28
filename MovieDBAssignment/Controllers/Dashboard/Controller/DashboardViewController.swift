//
//  DashboardViewController.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class DashboardViewController: BaseViewController {

    lazy var viewModel: DashboardViewModel = {
        let obj = DashboardViewModel()
        self.baseVwModel = obj
        return obj
    }()
    
    //MARK:- @IBOutlets
    @IBOutlet weak var tblViewMovieList: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarWithSearch()
        registerCells()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Functions
    
    func setNavigationBarWithSearch(){
        setupNavigationBar()
        navigationItem.titleView = searchBar
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.textColor = UIColor.white
        searchBar.delegate = self
    }
    
    func registerCells(){
        self.tblViewMovieList.register(UINib(nibName: MovieListTableViewCell.className, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.className)
    }

}


//MARK:- UITableView Delegates & Datasources
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.className) as! MovieListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.getController(controllerId: MovieDetailViewController.className)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK:- UISearch bar delegate
extension DashboardViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let controller = self.getController(controllerId: SearchViewController.className)
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
}
