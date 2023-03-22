//
//  ViewController.swift
//  challenge
//
//  Created by Davit Natenadze on 22.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttonsStack = UIStackView()
    
    private var imageView: UIImageView = {
       let iv = UIImageView()
        
        return iv
    }()
     
    private var mainTitle: UILabel = {
       let label = UILabel()
        label.text = "Some text for now?"
        return label
    }()
     
    private var trueButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("True", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 7
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    private var falseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("False", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.backgroundColor = .systemGreen
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }


}


extension ViewController {
    
    func style() {
        //
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 7
    }
    
    func layout() {
        buttonsStack.addArrangedSubview(trueButton)
        buttonsStack.addArrangedSubview(falseButton)
        view.addSubview(buttonsStack)
        
        buttonsStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor, paddingLeft: 24, paddingBottom: 16, paddingRight: 24)
    }
    
}
