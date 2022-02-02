//
//  SchoolSATScoreViewModal.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/2/22.
//

import Foundation
import Combine

class SchoolSATScoreViewModal: NSObject {
    var repository: SchoolSatScoreRepository?
    var school: School?
    
    @Published var satScore: SchoolSATScore?
    
    convenience init(school: School, repository: SchoolSatScoreRepository = SchoolSatScoreRepository()) {
        self.init()
        
        self.school = school
        self.repository = repository
    }
    
    func fetchSatScores() {
        guard let dbn = school?.dbn else { return }
        repository?.fetch(.sat(dbn: dbn)) { [weak self] result in
            switch result {
            case .success(let satScore):
                self?.satScore = satScore.first
            case .failure(_): break
            }
        }
    }
    
    // we can move constants or strings to extension
    // private extension String {
    //      static let location = "location"
    // }
    // but i am not re-using it so i had sending keys
    func uiContent() -> [([SATInformation], isVertical: Bool)] {
        return [
            ([
                SATInformation(key: school?.name, value: nil),
                SATInformation(key: nil, value: school?.overview, isCenter: false),
                SATInformation(key: "Location", value: school?.location),
                SATInformation(key: "Website", value: school?.website),
                SATInformation(key: "SAT Scores", value: nil),
            ], true),
            ([
                SATInformation(key: "Number of text taker", value: satScore?.numberOfTestTakers, isCenter: false),
                SATInformation(key: "Math average score", value: satScore?.mathAvgScore, isCenter: false),
                SATInformation(key: "Critical reading average score", value: satScore?.criticalReadingAvgScore, isCenter: false),
                SATInformation(key: "Writing average scrore", value: satScore?.writingAvgScore, isCenter: false),
                
            ], false)
        ]
    }
}
