//
//  ViewController.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = SchoolListViewModal(repository: SchoolListRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchListOfSchools()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(cell: UITableViewCell.self)
    }
    
    private func fetchListOfSchools() {
        viewModel.fetch { [weak self] in self?.reloadData() }
    }
    
    private func configureView() {
        configureTableView()
        title = viewModel.title
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.schools[indexPath.row].name
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
