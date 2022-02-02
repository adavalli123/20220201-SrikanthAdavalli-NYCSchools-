//
//  SchoolSATViewController.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import UIKit
import Combine

class SchoolSATViewController: UIViewController {
    private (set) var viewModel: SchoolSATScoreViewModal!
    private var cancellables: Set<AnyCancellable> = []
    
    private let scrollView = UIScrollView(showsVerticalScrollIndicator: false)
    private let mainStackView = UIStackView(axis: .vertical)
    
    init(school: School) {
        super.init(nibName: nil, bundle: nil)
        viewModel = SchoolSATScoreViewModal(school: school)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        fetchSatScores()
    }
    
    private func fetchSatScores() {
        viewModel.fetchSatScores()
        viewModel.$satScore
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] _ in
                self?.buildUI()
            }).store(in: &cancellables)
    }
    
    private func buildUI() {
        for elements in self.viewModel.uiContent() {
            for info in elements.0 {
                if elements.isVertical == true {
                    self.buildVerticalSchoolInformationStackView(from: info)
                } else {
                    let stackView = self.buildHorizontalSATScoreStackView(from: info)
                    self.mainStackView.addArrangedSubview(stackView)
                    self.mainStackView.setCustomSpacing(5, after: stackView)
                }
            }
        }
    }
    
    private func buildHorizontalSATScoreStackView(from info: SATInformation) -> UIStackView {
        let stack = UIStackView(spacing: 20, axis: .horizontal)
        
        if let title = info.key {
            let titleLabel = UILabel(.secondary, alignment: .left)
            titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            titleLabel.text = title
            stack.addArrangedSubview(titleLabel)
        }
        
        if let value = info.value {
            let scoreLabel = UILabel(.description, alignment: .left)
            scoreLabel.text = value
            stack.addArrangedSubview(scoreLabel)
        }
        
        return stack
    }
    
    private func buildVerticalSchoolInformationStackView(from info: SATInformation) {
        if let title = info.key {
            let titleLabel = UILabel(.primary)
            titleLabel.text = title.uppercased()
            self.mainStackView.addArrangedSubview(titleLabel)
            self.mainStackView.setCustomSpacing(10, after: titleLabel)
        }
        
        if let value = info.value {
            let scoreLabel = UILabel(.description, alignment: info.isCenter ? .center : .natural)
            scoreLabel.text = value
            self.mainStackView.addArrangedSubview(scoreLabel)
            self.mainStackView.setCustomSpacing(25, after: scoreLabel)
        }
    }
    
    private func setupScrollView(){
        view.add(view: scrollView, spacing: .default)
        scrollView.add(view: mainStackView)
        
        let mainStackViewCenterYAnchor = mainStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        let mainStackViewHeightAnchor = mainStackView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        [mainStackViewHeightAnchor, mainStackViewCenterYAnchor].forEach { $0.priority = .defaultLow }
        
        [
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackViewHeightAnchor,
            mainStackViewHeightAnchor
        ].forEach { $0.isActive = true }
    }
}
