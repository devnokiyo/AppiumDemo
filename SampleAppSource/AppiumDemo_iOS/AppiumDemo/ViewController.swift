//
//  ViewController.swift
//  AppiumDemo
//
//  Created by devnokiyo on 2018/12/05.
//  Copyright © 2018 devnokiyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtPassword.isSecureTextEntry = true
    }

    @IBAction func tabLogin(_ sender: Any) {
        if let id = txtId.text, let password = txtPassword.text {
            if id == "devnokiyo" && password == "abcd1234" {
                present(storyboard!.instantiateViewController(withIdentifier: "WelcomeViewController"), animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "認証エラー", message: "IDまたはパスワードが違います。", preferredStyle:  UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

