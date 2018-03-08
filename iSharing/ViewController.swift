//
//  ViewController.swift
//  iSharing
//
//  Created by 姜万宝 on 18/02/2018.
//  Copyright © 2018 姜万宝. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var signInButton: DesignableButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
//    @IBAction func signIn(_ sender: Any) {
//        let uploadViewController = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "uploadView") as UIViewController
//        self.navigationController?.pushViewController(uploadViewController, animated: true)
//    }
    
//    @IBAction func signIn(_ sender: Any) {
//        let uploadViewController = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "uploadView") as UIViewController
//        self.present(uploadViewController, animated: true, completion: nil)
//    }
    
    @IBAction func signIn(_ sender: Any) {
        if self.emailField.text == "" {
            print("please enter email address")
        }else{
//            let uploadViewController = UIStoryboard(name: "Main", bundle: nil)
//                .instantiateViewController(withIdentifier: "uploadView") as UIViewController
//            self.present(uploadViewController, animated: true, completion: nil)
           self.performSegue(withIdentifier: "enterUploadViewSegue", sender: nil)
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

