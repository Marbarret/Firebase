//
//  SignUpViewController.swift
//  EstudoTextField
//
//  Created by Marcylene Barreto on 26/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    // MARK: Properties
    let db = Firestore.firestore()
    
    // MARK: Outlets
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: Actions
    @IBAction func btnCadastrar(_ sender: Any) {
        
        guard let name = textFieldNome.text,
              let email = textFieldEmail.text,
              let password = textFieldPassword.text,
              let confirmePassword = textFieldConfirmPassword.text
        else { return }
        
        if password != confirmePassword {
            showMessage(title: "Alerta", message: "As senhas estao diferentes")
            return
        }
        if !email.contains("@") {
            showMessage(title: "Alerta", message: "Este e-mail nao é válido")
            return
        }
        if name.count < 3 {
            showMessage(title: "Alerta", message: "Este nome é muito curto")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print("==> Erro \(error?.localizedDescription)")
            }
            else {
                print("Usuário Cadastrado")
                
                guard let userId = authResult?.user.uid else {return}
                
                // Add a new document with a generated ID
                self.db.collection("users").document(userId).setData([
                    "name": name,
                    "email": email,
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added")
                    }
                }
            }
        }
    }
    
    // MARK: Methods
    
    private func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupUI() {
        title = "Cadastrar"
    }
}
