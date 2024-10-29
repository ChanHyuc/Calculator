import UIKit

class ViewController: UIViewController {
    
    private let inputTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.textAlignment = .right
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.placeholder = "0"
        textField.setPlaceholder(color: .white)
        return textField
    }()
    
    private let operatorTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.textAlignment = .left
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        return textField
    }()
    
    private let calculatorTextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupButtons()
        operatorTextField.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        view.addSubview(operatorTextField)
        view.addSubview(inputTextField)
        view.addSubview(calculatorTextView)
        
        NSLayoutConstraint.activate([
            operatorTextField.topAnchor.constraint(equalTo: calculatorTextView.bottomAnchor),
            operatorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            inputTextField.topAnchor.constraint(equalTo: calculatorTextView.bottomAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            inputTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            calculatorTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculatorTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.97),
            calculatorTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
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
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
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
        if let title = sender.title(for: .normal) {
            
            if title == "AC" {
                inputTextField.text?.removeAll()
                calculatorTextView.text.removeAll()
            } else if title == "CE" {
                if var text = inputTextField.text, !text.isEmpty {
                    text.removeLast()
                }
            } else if title == "+/-" {
                if operatorTextField.text == "+" {
                    operatorTextField.text = "-"
                } else if operatorTextField.text == "-" {
                    operatorTextField.text = "+"
                }
                
            } else if title == "+" || title == "-" || title == "*" || title == "/" {
                if let text = inputTextField.text, !text.isEmpty {
                    operatorTextField.text?.append(title)
                }
                
            } else {
                inputTextField.text?.append(title)
            }
            
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 현재 텍스트 필드의 문자 수를 확인
        let currentText = textField.text ?? ""
        
        // 새로 입력된 문자열이 1개 초과인지 확인하고, 현재 텍스트가 비어있는지 확인하여 입력을 제어
        let newLength = currentText.count + string.count - range.length
        return newLength <= 1
    }
}
