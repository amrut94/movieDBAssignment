//
//  SearchViewController.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class SearchViewController: BaseViewController {
    
    lazy var viewModel: SearchViewModel = {
        let obj = SearchViewModel()
        self.baseVwModel = obj
        return obj
    }()

    //@IBOutlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tblViewSearch: UITableView!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarWithSearch()
        registerCells()
        closureSetup()
        viewModel.filterMovies(searchQuery: "")
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Functions
    func setNavigationBarWithSearch(){
        self.setupNavigationBar()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.titleView = searchBar
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.textColor = UIColor.white
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    func registerCells(){
        self.tblViewSearch.register(UINib(nibName: MovieListTableViewCell.className, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.className)
        self.tblViewSearch.register(UINib(nibName: SectionTitleTableViewCell.className, bundle: nil), forCellReuseIdentifier: SectionTitleTableViewCell.className)
    }
    func closureSetup(){
        viewModel.reloadListViewClosure = {() in
            DispatchQueue.main.async {
                self.tblViewSearch.reloadData()
            }
        }
        
        viewModel.redirectControllerClosure = {(movie) in
            DispatchQueue.main.async {
                let controller = self.getController(controllerId: MovieDetailViewController.className) as! MovieDetailViewController
                controller.viewModel.movie = movie as? Results
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

//MARK:- UITableView Delegates and Datasources
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.className) as! SectionTitleTableViewCell
        cell.lblTitle.text = viewModel.titleForSection()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (viewModel.isSearchActive) {
            return 0.0
        }
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.className) as! MovieListTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
}


//MARK:- UISearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(searchQuery: searchText)
    }
}
