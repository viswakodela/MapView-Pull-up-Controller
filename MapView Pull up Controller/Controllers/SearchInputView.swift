//
//  SearchInputView.swift
//  MapView Pull up Controller
//
//  Created by Viswa Kodela on 6/20/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SearchInputView: UIView {
    
    // MARK:- Properties
    var indicatorView: UIView!
    var expansionState: ExpansionStatus!
    
    enum ExpansionStatus {
        case notExpanded
        case partiallyExpanded
        case fullyExpanded
        case expandedToSearch
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        configureGestureRecogniger()
        
        self.expansionState = .notExpanded
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.indicatorView.layer.cornerRadius = indicatorView.frame.size.height / 2
    }
    
    // MARK:-  Helper Methods
    fileprivate func configureViewComponents() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.indicatorView = UIView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = UIColor(white: 0.8, alpha: 1)
        addSubview(indicatorView)
        indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 6).isActive = true
    }
    
    func configureGestureRecogniger() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUpGesture))
        swipeUpGesture.direction = .up
        addGestureRecognizer(swipeUpGesture)
        
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUpGesture))
        swipeDownGesture.direction = .down
        addGestureRecognizer(swipeDownGesture)
        
    }
    
    func anmiateInputView(to targetPosition: CGFloat, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.y = targetPosition
        }, completion: completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error intializing the Search Input View")
    }
    
}

// MARK:-  Swipe Gestures handlers
extension SearchInputView {
    
    @objc func handleSwipeUpGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            
            if expansionState == .notExpanded {
                self.anmiateInputView(to: self.frame.origin.y - 250) { (_) in
                    self.expansionState = .partiallyExpanded
                }
            } else if expansionState == .partiallyExpanded {
                self.anmiateInputView(to: self.frame.origin.y - 300) { (_) in
                    self.expansionState = .fullyExpanded
                }
            }
            
        } else {
            if expansionState == .fullyExpanded {
                anmiateInputView(to: self.frame.origin.y + 300) { (_) in
                    self.expansionState = .partiallyExpanded
                }
            } else if expansionState == .partiallyExpanded {
                anmiateInputView(to: self.frame.origin.y + 250) { (_) in
                    self.expansionState = .notExpanded
                }
            }
        }
    }
}
