//
//  LoginViewController.swift
//  Dependencias
//
//  Created by usuario on 10/5/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter credentials", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "username"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "password"
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let usernameTextField = alert.textFields?.first, let passwordTextField = alert.textFields?.last, usernameTextField.text == "usuario", passwordTextField.text == "pass" else {
                let alert = UIAlertController(title: "Wrong credentials", message: "Please try again", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.performSegue(withIdentifier: "welcome-segue", sender: nil)
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "userIsLoggedIn")
            userDefaults.synchronize()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
