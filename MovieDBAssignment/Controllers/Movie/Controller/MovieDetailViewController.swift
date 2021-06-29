//
//  MovieDetailViewController.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    lazy var viewModel: MovieDetailViewModel = {
        let obj = MovieDetailViewModel()
        self.baseVwModel = obj
        return obj
    }()
    
    //MARK:- @IBOutlets
    @IBOutlet weak var tblViewMovieDetail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .red
        registerCells()
        viewModel.getCastAndCrews()
        viewModel.reloadListViewClosure = {() in
            DispatchQueue.main.async {
                self.tblViewMovieDetail.reloadData()
            }
        }
    }
    
    func registerCells(){
        self.tblViewMovieDetail.register(UINib(nibName: MovieDetailHeaderTableViewCell.className, bundle: nil), forCellReuseIdentifier: MovieDetailHeaderTableViewCell.className)
        self.tblViewMovieDetail.register(UINib(nibName: SectionTitleTableViewCell.className, bundle: nil), forCellReuseIdentifier: SectionTitleTableViewCell.className)
        self.tblViewMovieDetail.register(UINib(nibName: ReviewTableViewCell.className, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.className)
    }
    
}

//MARK:- UITableView Delegates and Datasources
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.className) as! SectionTitleTableViewCell
        cell.lblTitle.text = viewModel.titleForSection(section: section)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 :25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MovieDetailCell(rawValue: indexPath.section){
        case .movieDetail:
            return movieDetailHeaderTableViewCell(tableView, cellForRowAt: indexPath)
        case .castAndCrew, .similarMovies:
            return castAndMovieListTableViewCell(tableView, cellForRowAt: indexPath)
        case .reviews:
            return reviewTableViewCell(tableView, cellForRowAt: indexPath)
        case .none:
            return UITableViewCell()
        }
    }
    
    //Custom table view Cells
    func movieDetailHeaderTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailHeaderTableViewCell.className) as! MovieDetailHeaderTableViewCell
        if let movie = viewModel.cellForRowAt(indexPath: indexPath) as? Results {
            cell.configureCell(movie: movie)
        }
        return cell
    }
    
    func reviewTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.className) as! ReviewTableViewCell
        if let review = viewModel.cellForRowAt(indexPath: indexPath) as? Review {
            cell.configureCell(review: review)
        }
        return cell
    }
    
    func castAndMovieListTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastAndMovieTableViewCell.className) as! CastAndMovieTableViewCell
        cell.collectionViewCastAndMovie.delegate = self
        cell.collectionViewCastAndMovie.dataSource = self
        cell.collectionViewCastAndMovie.tag = (indexPath.section == 1) ? MovieDetailCell.castAndCrew.rawValue : MovieDetailCell.similarMovies.rawValue
        cell.collectionViewCastAndMovie.reloadData()
        return cell
    }
}

//MARK:- UICollectionView Delegates and Datasources
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(section: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastAndMovieCollectionViewCell.className, for: indexPath) as! CastAndMovieCollectionViewCell
        if (MovieDetailCell(rawValue: collectionView.tag) == .castAndCrew) {
            if let cast = viewModel.itemAtIndexPath(indexPath: indexPath, type: .castAndCrew) as? Cast {
            cell.configureCastCell(cast: cast)
        }
        }else {
            if let movie = viewModel.itemAtIndexPath(indexPath: indexPath, type: .similarMovies) as? Results {
                cell.configureMovieCell(movie: movie)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(MovieDetailCell(rawValue: collectionView.tag) == .similarMovies){
            let controller = self.getController(controllerId: MovieDetailViewController.className) as! MovieDetailViewController
            controller.viewModel.movie = viewModel.itemAtIndexPath(indexPath: indexPath, type: .similarMovies) as? Results
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
