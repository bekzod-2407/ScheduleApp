//
//  ScheduleViewController.swift
//  ScheduleApp
//
//  Created by Bekzod Qahhorov on 01/08/22.
//

import UIKit
import FSCalendar

class SheduleViewController: UIViewController {
    var calendarHeight: NSLayoutConstraint!
    
    private lazy var calendar: FSCalendar = {
       var view = FSCalendar()
        view.scope = .week
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var showHideButton: UIButton = {
       var view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Show", for: .normal)
        view.titleLabel?.font = .monospacedSystemFont(ofSize: 11, weight: .medium)
        view.setTitleColor(.systemGray6, for: .normal)
        view.backgroundColor = .purple
        view.layer.cornerRadius = 15
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Schedule"
        calendar.dataSource = self;
        calendar.delegate = self;
        setupSubView()
        addTargets()
    }
    
   func addTargets() {
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
       
       let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
       swipeUP.direction = .up
       calendar.addGestureRecognizer(swipeUP)
       
       let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
       swipeDown.direction = .down
       calendar.addGestureRecognizer(swipeDown)
    }
    @objc private func swipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up: showHideButtonTapped()
        case .down: showHideButtonTapped()
        default:
            break
        }
    }
    @objc private func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close", for: .normal)
        } else if calendar.scope == .month  {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Show", for: .normal)
        }
    }
}
extension SheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        view.layoutIfNeeded()
    }
}
//MARK: - adding Constrains with action
extension SheduleViewController {
    func setupSubView() {
        view.addSubview(calendar)
        view.addSubview(showHideButton)
         calendarHeight = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeight)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

