//
//  ViewController.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: SchoolListViewModal = {
       let vm = SchoolListViewModal(repository: SchoolListRepository())
        return vm
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchListOfSchools()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        tableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.gray
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(cell: UITableViewCell.self)
    }
    
    private func fetchListOfSchools() {
        viewModel.fetch()
        loadingStart()
        viewModel.$schools.dropFirst().receive(on: DispatchQueue.main) .sink { [weak self] _ in
            self?.tableView.reloadData()
            self?.loadingStop()
        }.store(in: &cancellables)
    }
    
    private func configureView() {
        configureTableView()
        setupSearchController()
        title = viewModel.title
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.schools[indexPath.row].name.uppercased()
        content.textProperties.font = .boldSystemFont(ofSize: 17)
        content.secondaryText = viewModel.schools[indexPath.row].overview
        content.secondaryTextProperties.numberOfLines = 5
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let satVC = SchoolSATViewController(school: viewModel.schools[indexPath.row])
        navigationController?.pushViewController(satVC, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
      
      func filterContentForSearchText(_ searchText: String,
                                      category: School? = nil) {
          viewModel.filteredSchools = viewModel.schools.filter { (result: School) -> Bool in
          return result.name.lowercased().contains(searchText.lowercased())
        }
      }
}
