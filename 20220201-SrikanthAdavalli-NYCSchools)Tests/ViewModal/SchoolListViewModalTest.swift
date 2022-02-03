//
//  SchoolListViewModalTest.swift
//  20220201-SrikanthAdavalli-NYCSchools)Tests
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
@testable import _0220201_SrikanthAdavalli_NYCSchools_
import XCTest

class SchoolListViewModalTest: XCTest {
    var viewModal: MockSchoolListViewModal?
    
    override func setUp() {
        viewModal = MockSchoolListViewModal()
    }
    
    func testFetch() {
        guard let fetchIsCalled = viewModal?.fetchIsCalled else {
            XCTFail("failed to fetch data")
            return
        }
        XCTAssertTrue(fetchIsCalled)
    }
    
    func testSetup() {
        let expectedSchools = [
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
        
        XCTAssertEqual(viewModal?.title, "Test")
        XCTAssertEqual(viewModal?.filteredSchools, [expectedSchools[0]])
        XCTAssertEqual(viewModal?.totalSchools, expectedSchools)
        XCTAssertEqual(viewModal?.schools, [expectedSchools[0]])
        XCTAssertEqual(viewModal?.cellCount, 10)
    }
}
