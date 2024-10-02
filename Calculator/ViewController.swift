//
//  ViewController.swift
//  Calculator
//
//  Created by ChanHyuc on 9/27/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupButtons()
    }
    
    private func setupButtons() {
        let buttonTitles = ["0", "00", ".", "=", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "×", "AC", "CE", "+/-", "÷"]
        
        for i in 0..<buttonTitles.count {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(buttonTitles[i], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.backgroundColor = .darkGray
            
            if i % 4 == 3 {
                button.backgroundColor = .systemOrange
            } else if i > 15 && i % 4 != 3 {
                button.backgroundColor = .systemGray
                button.setTitleColor(.black, for: .normal)
            }
            
            
            view.addSubview(button)
            
            let row = i / 4
            let column = i % 4
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.22),
                button.heightAnchor.constraint(equalTo: button.widthAnchor),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -CGFloat(row) * (view.bounds.width / 4) - 30),
                button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(column) * (view.bounds.width / 4) + 5),
            ])
        }
        
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // 버튼 클릭 처리
        if let title = sender.title(for: .normal) {
            print("Button \(title) tapped")
        }
    }
}
