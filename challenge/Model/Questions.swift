//
//  Questions.swift
//  challenge
//
//  Created by Davit Natenadze on 22.03.23.
//

import UIKit

protocol QuestionsDelegate: AnyObject {
    func showFinalScore()
}

class Questions {
    
    // MARK: - Properties
    
    var quiz = [QuestionModel(image: UIImage(named: "tree")!, questionText: "Is this a Tree?", answer: true),
                QuestionModel(image: UIImage(named: "car")!, questionText: "Is this a Car?", answer: true),
                QuestionModel(image: UIImage(named: "mug")!, questionText: "Is this a Person?", answer: false)]
    
    var userScore = 0
    var questionNumber = 0
    
    weak var delegate: QuestionsDelegate?
    
    func showNextQuestion() -> QuestionModel? {
        if questionNumber == quiz.count {
            delegate?.showFinalScore()
            userScore = 0
            questionNumber = 0
            return nil
        }
        return quiz[questionNumber]
    }
    
    func checkAnswer(userAnswer: Bool) -> Bool {
        if userAnswer == quiz[questionNumber].answer {
            userScore += 1
            questionNumber += 1
            return true
        }
        questionNumber += 1
        return false
    }
    
    func resetStats() {
        userScore = 0
        questionNumber = 0
    }
    
    
}
