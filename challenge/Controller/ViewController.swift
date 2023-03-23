//
//  ViewController.swift
//  challenge
//
//  Created by Davit Natenadze on 22.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var questions = Questions.questions
    
    private var questionNumber = 0
    private var finalScore = 0
    
    var gameOver = false {
        didSet {
            let alert = UIAlertController(title: "Final Score", message: "\(finalScore) \\ \(questions.count)", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                
                self.questionNumber = 0
                self.finalScore = 0
                self.nextQuestion()
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
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
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        nextQuestion()
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
    
    func checkAnswer(userAnswer: Bool) {
        let question = questions[questionNumber]
        if userAnswer == question.answer {
            finalScore += 1
            questionNumber += 1
            showAnswerAlert(title: "Correct!", text: "You got this right!")
            return
        }
        questionNumber += 1
        showAnswerAlert(title: "Incorrect!", text: "You got this wrong!")
    }
    
    func showAnswerAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next question", style: .default) { _ in
            if self.questionNumber == self.questions.count {
                self.gameOver.toggle()
                return
            }
            self.nextQuestion()
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    func nextQuestion() {
        imageView.image = UIImage(named: questions[questionNumber].imageName)
        mainTitle.text = questions[questionNumber].questionText
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
        checkAnswer(userAnswer: true)
    }
    
    @objc func falseTapped() {
        checkAnswer(userAnswer: false)
    }
}
