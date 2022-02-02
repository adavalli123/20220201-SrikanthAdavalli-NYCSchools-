//
//  SchoolSATViewController.swift
//  20220201-SrikanthAdavalli-NYCSchools)
//
//  Created by Srikanth Adavalli on 2/1/22.
//

import UIKit
import Combine

class SchoolSATViewController: UIViewController {
    var viewModel: SchoolSATScoreViewModal!
    private var cancellables: Set<AnyCancellable> = []
    
    init(school: School) {
        super.init(nibName: nil, bundle: nil)
        viewModel = SchoolSATScoreViewModal(school: school)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        fetchSatScores()
    }
    
    func fetchSatScores() {
        viewModel.fetchSatScores()
        viewModel.$satScore
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] _ in
                self?.handleParse()
        }).store(in: &cancellables)
    }
    
    func handleParse() {
        for elements in self.viewModel.parse() {
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
    
    func buildHorizontalSATScoreStackView(from info: SATInformation) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        
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
    
    func buildVerticalSchoolInformationStackView(from info: SATInformation) {
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
    
    func setupScrollView(){
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
