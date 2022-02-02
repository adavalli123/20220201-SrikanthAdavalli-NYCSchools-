//
//  SchoolListViewModal.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import Foundation

class SchoolListViewModal: NSObject {
    var repository: SchoolListRepository?
    var schools: [School] = []
    
    var title: String { "Schools" }
    var cellCount: Int { schools.count }
    
    convenience init(repository: SchoolListRepository? = SchoolListRepository()) {
        self.init()
        self.repository = repository
    }
    
    func fetch(_ closure: @escaping () -> ()) {
        repository?.fetch(.schools) { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools
                closure()
            case .failure(_): break
                // handle error
            }
        }
    }
}
