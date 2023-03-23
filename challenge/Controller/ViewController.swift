//
//  ViewController.swift
//  challenge
//
//  Created by Davit Natenadze on 22.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let buttonsStack = UIStackView()
    private var imageView = UIImageView()
    
    private var mainTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return label
    }()
    
    private lazy var trueButton: UIButton = {
        let btn = createButton(withTitle: "True")
        btn.addTarget(self, action: #selector(trueTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var falseButton: UIButton = {
        let btn = createButton(withTitle: "False")
        btn.addTarget(self, action: #selector(falseTapped), for: .touchUpInside)
        return btn
    }()
    
    private var questions = Questions()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions.delegate = self
        style()
        layout()
        showQuestion()
    }
    
    
    // MARK: - Helpers
    
    func createButton(withTitle title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btn.backgroundColor = .systemGreen
        return btn
    }
    
    // MARK: - Logic Functions
    
    func showQuestion() {
        guard let currentQuestion = questions.showNextQuestion() else { return }
        imageView.image = currentQuestion.image
        mainTitle.text = currentQuestion.questionText
    }
    
    func showAlert(result: Bool) {
        let title = result   ? "Correct!" : "Incorrect!"
        let message = result ? "You got this right" : "You got this wrong!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next Question", style: .default) { _ in
            self.showQuestion()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}


extension ViewController {
    
    func style() {
        
        // Buttons
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 16
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(mainTitle)
        buttonsStack.addArrangedSubview(trueButton)
        buttonsStack.addArrangedSubview(falseButton)
        view.addSubview(buttonsStack)
        
        // imageView
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor,
                         bottom: mainTitle.topAnchor, right: view.rightAnchor, paddingBottom: 48)
        //title
        mainTitle.anchor(left: buttonsStack.leftAnchor, bottom: buttonsStack.topAnchor,
                         right: buttonsStack.rightAnchor, paddingBottom: 80)
        // buttons
        buttonsStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor, paddingLeft: 24, paddingBottom: 32, paddingRight: 24)
    }
    
}

// MARK: - Actions

extension ViewController {
    
    @objc func trueTapped() {
       let result = questions.checkAnswer(userAnswer: true)
        showAlert(result: result)
    }
    
    @objc func falseTapped() {
      let result = questions.checkAnswer(userAnswer: false)
        showAlert(result: result)
    }
}


extension ViewController: QuestionsDelegate {
    
    func showFinalScore() {
        let alert = UIAlertController(title: "Final Score", message: "\(questions.userScore) \\ \(questions.quiz.count)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            
            self.showQuestion()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
