//
//  QuestionModel.swift
//  challenge
//
//  Created by Davit Natenadze on 22.03.23.
//

import UIKit


struct QuestionModel {
    let imageName: String
    let answer: Bool
}

struct QuestionsBrain {
    
    var Questions = [QuestionModel(imageName: "tree", answer: true),
                     QuestionModel(imageName: "car", answer: true),
                     QuestionModel(imageName: "mug", answer: true)]
    
}
