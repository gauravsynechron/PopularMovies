//
//  ViewController.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!{
        didSet {
            submitBtn.layer.cornerRadius = 8.0
            submitBtn.isEnabled = false
            submitBtn.backgroundColor = .lightGray
            submitBtn.addTarget(self, action: #selector(self.submitButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var passwordTextfield: UITextField! {
        didSet {
            passwordTextfield.delegate = self
            passwordTextfield.addTarget(self, action: #selector(self.buttonOnEditing), for: .editingChanged)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet {
            emailTextField.autocorrectionType = .no
            emailTextField.delegate = self
            emailTextField.addTarget(self, action: #selector(self.buttonOnEditing), for: .editingChanged)
        }
    }
    
    var viewModel:LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func submitButtonAction() {
        self.view.endEditing(true)
        self.navigateToMovieScreen()
    }
    
    func navigateToMovieScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController else { return }
        controller.viewModel = MovieViewModel()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func buttonOnEditing() {
        if viewModel.validateEmailAndPassword(emailAddress: emailTextField.text, password: passwordTextfield.text) == true {
            self.setButtonEnabled(isEnabled: true)
        } else {
            self.setButtonEnabled(isEnabled: false)
        }
    }
    
    func setButtonEnabled(isEnabled: Bool) {
        submitBtn.isEnabled = isEnabled
        submitBtn.backgroundColor = isEnabled ? .tintColor : .lightGray
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





