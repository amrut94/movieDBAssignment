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
    var refreshControl = UIRefreshControl()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        closureSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Functions
    
    func initialSetup(){
        setNavigationBarWithSearch()
        registerCells()
        getMovies()
        setupRefreshControl()
    }
    
    func closureSetup(){
        viewModel.reloadListViewClosure = {() in
            DispatchQueue.main.async {
                self.dismissLoader()
                self.tblViewMovieList.reloadData()
                self.tblViewMovieList.tableFooterView?.isHidden = true
                self.refreshControl.endRefreshing()
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
    
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: StringConstant.pullToRefresh, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblViewMovieList.addSubview(refreshControl)
    }
    
    //MARK:- @IBActions
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.pullDownRefresh()
    }
    //MARK:- API Calls
    
    func getMovies(){
        self.showLoader()
        viewModel.getMovies()
    }
    
}


//MARK:- UITableView Delegates & Datasources
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && viewModel.isLoadMore{
            let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tblViewMovieList.tableFooterView = spinner
            self.tblViewMovieList.tableFooterView?.isHidden = false
        }
    }
}

//MARK:- UISearch bar delegate
extension DashboardViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let controller = self.getController(controllerId: SearchViewController.className) as! SearchViewController
        controller.viewModel.downloadedMovies = self.viewModel.arrMovies
        self.navigationController?.pushViewController(controller, animated: true)
        return false
    }
}
