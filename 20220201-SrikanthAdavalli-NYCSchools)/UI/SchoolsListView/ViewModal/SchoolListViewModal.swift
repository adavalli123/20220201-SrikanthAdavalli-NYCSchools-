//
//  SchoolListViewModal.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation
import Combine

protocol SchoolListViewModalInput {
    var repository: SchoolListRepository? { get }
    var title: String { get }
    var cellCount: Int { get }
    var schools: [School] { get }
    var isFiltering: Bool { get }
    var filteredSchools: [School] { get }
    var totalSchools: [School] { get }
    
    func fetch()
}

class SchoolListViewModal: NSObject, SchoolListViewModalInput {
    var repository: SchoolListRepository?
    
    var title: String { "Schools".uppercased() }
    var cellCount: Int { schools.count }
    var isFiltering = false
    
    var filteredSchools: [School] = [] {
        didSet { updateSchools() }
    }
    var totalSchools: [School] = [] {
        didSet { updateSchools() }
    }
    
    @Published var schools: [School] = []
    
    convenience init(repository: SchoolListRepository? = SchoolListRepository()) {
        self.init()
        self.repository = repository
    }
    
    func fetch() {
        repository?.fetch(.schools) { [weak self] result in
            switch result {
            case .success(let schools):
                self?.totalSchools = schools
            case .failure(_): break
            }
        }
    }
    
    private func updateSchools() {
        schools = !filteredSchools.isEmpty ? filteredSchools : totalSchools
    }
}
