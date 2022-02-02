//
//  SchoolListViewModal.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation
import Combine

class SchoolListViewModal: NSObject {
    var repository: SchoolListRepository?
    
    var title: String { "Schools".uppercased() }
    var cellCount: Int { schools.count }
    
    @Published var schools: [School] = []
    
    convenience init(repository: SchoolListRepository? = SchoolListRepository()) {
        self.init()
        self.repository = repository
    }
    
    func fetch() {
        repository?.fetch(.schools) { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools
            case .failure(_): break
            }
        }
    }
}
