//
//  SignInViewController.swift
//  EstudoTextField
//
//  Created by Marcylene Barreto on 26/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInViewController: UIViewController {

    // MARK: Properties
    let db = Firestore.firestore()
    
    // MARK: Outlets
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: Actions
    @IBAction func btnEntrar(_ sender: Any) {
        
        guard let email = textFieldEmail.text, let password = textFieldSenha.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print("==> Erro")
            }
            else {
                print("usuario logado com sucesso \(authResult?.user.uid)")
                
                guard let userId = authResult?.user.uid else {return}
                
                self.db.collection("users").document(userId).getDocument() { (document, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        print("==> Usuário \(document?.data())")
                        }
                    }
                }
            }
        }
        // Logout 
//        try? Auth.auth().signOut()
    
    @IBAction func btnCriarConta(_ sender: Any) {
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Methods
    private func setupUI() {
        title = "Fazer login"
    }
}

