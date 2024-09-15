//
//  ViewController.swift
//  MovieApp
//
//  Created by Priyansh on 18/03/24.
//  Student ID: 158341214
//  Email: pparikh8@myseneca.ca

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableview: UITableView!
    
    
    var listMovie = [Movie]()
    var searching = false
    var searchedMovie = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie1 = Movie(mName: "Iron Man", mYear: "Year: 2008", mPoster: "IronMan", mimbdID: "ImdbID: tt0371746", mType: "Type: Action Movie")
        listMovie.append(movie1)
        
        let movie2 = Movie(mName: "Captain America: The First Avenger", mYear: "Year: 2011", mPoster: "CaptainAmerica", mimbdID: "ImdbID: tt0458339", mType: "Type: Action Movie")
        listMovie.append(movie2)
        
        let movie3 = Movie(mName: "Thor", mYear: "Year: 2011", mPoster: "Thor", mimbdID: "ImdbID: tt0800369", mType: "Type: Action Movie")
        listMovie.append(movie3)
        
        let movie4 = Movie(mName: "Spider-Man: No Way Home", mYear: "Year: 2021", mPoster: "SpiderMan", mimbdID: "ImdbID: tt10872600", mType: "Type: Action Movie")
        listMovie.append(movie4)
        
        let movie5 = Movie(mName: "The Avengers", mYear: "Year: 2012", mPoster: "Avengers", mimbdID: "ImdbID: tt0848228", mType: "Type: Action Movie")
        listMovie.append(movie5)
        
        let movie6 = Movie(mName: "Avengers: Infinity War", mYear: "Year: 2018", mPoster: "InfinityWar", mimbdID: "ImdbID: tt4154756", mType: "Type: Action Movie")
        listMovie.append(movie6)
        
        let movie7 = Movie(mName: "Avengers: Endgame", mYear: "Year: 2019", mPoster: "Endgame", mimbdID: "ImdbID: tt4154796", mType: "Type: Action Movie")
        listMovie.append(movie7)
        
        let movie8 = Movie(mName: "The Incredible Hulk", mYear: "Year: 2008", mPoster: "IncredibleHulk", mimbdID: "ImdbID: tt0800080", mType: "Type: Action Movie")
        listMovie.append(movie8)
        
        configureSerachController()
        
    }
    
    
    @IBAction func AddMovie(_ sender: UIBarButtonItem) {
        
    }
    
    private func configureSerachController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search Movie by Name"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching 
        {
            return searchedMovie.count
        }
        else
        {
            return listMovie.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "MovieDetails") as? MovieDetails {
            if searching {
                let selectedMovie = searchedMovie[indexPath.row]
                vc.movieTitle = selectedMovie.title
                vc.img = UIImage(named: selectedMovie.posterURL) ?? UIImage()
                vc.movieYear = selectedMovie.year
                vc.imdbID = selectedMovie.imdbID
                vc.movieType = selectedMovie.type
            } else {
                let selectedMovie = listMovie[indexPath.row]
                vc.movieTitle = selectedMovie.title
                vc.img = UIImage(named: selectedMovie.posterURL) ?? UIImage()
                vc.movieYear = selectedMovie.year
                vc.imdbID = selectedMovie.imdbID
                vc.movieType = selectedMovie.type
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableview.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! MyTableViewCell
        
        if searching
        {
            cell.MovieName.text = searchedMovie[indexPath.row].title
            cell.MovieYear.text = searchedMovie[indexPath.row].year
            cell.MovieImage.image = UIImage(named: searchedMovie[indexPath.row].posterURL)
        }
        else
        {
            cell.MovieName.text = listMovie[indexPath.row].title
            cell.MovieYear.text = listMovie[indexPath.row].year
            cell.MovieImage.image = UIImage(named: listMovie[indexPath.row].posterURL)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let deletedMovie: Movie
                if searching {
                    deletedMovie = searchedMovie.remove(at: indexPath.row)
                } else {
                    deletedMovie = listMovie.remove(at: indexPath.row)
                }
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                // Show an undo option
                let alert = UIAlertController(title: "Movie Deleted", message: "The movie \(deletedMovie.title) has been deleted.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Undo", style: .default, handler: { action in
                    if self.searching {
                        self.searchedMovie.insert(deletedMovie, at: indexPath.row)
                    } else {
                        self.listMovie.insert(deletedMovie, at: indexPath.row)
                    }
                    tableView.reloadData()
                }))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching=false
        searchedMovie.removeAll()
        movieTableview.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
            searching=true
            searchedMovie.removeAll()
            for movie in listMovie
            {
                if movie.title.lowercased().contains(searchText.lowercased())
                {
                    searchedMovie.append(movie)
                }
            }
        }
        else
        {
            searching=false
            searchedMovie.removeAll()
            searchedMovie=listMovie
        }
        movieTableview.reloadData()
    }
}


