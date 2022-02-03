//
//  MockSchoolListViewModal.swift
//  20220201-SrikanthAdavalli-NYCSchools)Tests
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
@testable import _0220201_SrikanthAdavalli_NYCSchools_

class MockSchoolListViewModal: SchoolListViewModalInput {
    var filteredSchools: [School] {
        [
            School(name: "St. John High School",
                   dbn: "0002", overview: "Kings land is located in poway san austin",
                   location: "12 ABC road, Austin, Texas",
                   phoneNumber: "333-444-2222",
                   website: "www.xyz.com")
        ]
    }
    
    var totalSchools: [School] {
        [
            School(name: "St. Gabriel High School",
                   dbn: "0001", overview: "Highschool is located in poway san diego",
                   location: "1234 XYZ road, Dallas, Texas",
                   phoneNumber: "000-111-2222",
                   website: "www.fakeNumber.com"),
            School(name: "St. John High School",
                   dbn: "0002", overview: "Kings land is located in poway san austin",
                   location: "12 ABC road, Austin, Texas",
                   phoneNumber: "333-444-2222",
                   website: "www.xyz.com")
        ]
    }
    
    var isFiltering: Bool = true
    var fetchIsCalled = false
    var repository: SchoolListRepository?
    
    var title: String { "Test" }
    var cellCount: Int { 10 }
    var schools: [School] {
        return isFiltering ? filteredSchools : totalSchools
    }
    
    func fetch() {
        fetchIsCalled = true
    }
}
