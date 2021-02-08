//
//  SignIn.swift
//  shoppingApplication


import UIKit
import Alamofire

class SignIn: UIViewController {
    
    @IBOutlet weak var userEmailText: UITextField!
    
    @IBOutlet weak var userPasswordText: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(path)
        
        if let data = UserDefaults.standard.string(forKey: "userEmail"){
            print("data data data")
            print(data)
        }
        signInButton.layer.cornerRadius = 10.0
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let userEmail = userEmailText.text
        let userPassword = userPasswordText.text
        
        if userEmail != "" {
            if userPassword != "" {
                getSignIn(email: userEmail!, password: userPassword!)
            }else {
                print("user password can not be nil")
            }
        } else {
            print("user email can not be nil")
        }
    }
    
    func getSignIn(email: String, password: String){
        let url = "https://jsonbulut.com/json/userLogin.php"
        
        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "userEmail": email, "userPass": password, "face": "no"]
        
        let request = AF.request(url, method: .get, parameters: params).validate()
        request.responseJSON {(myData) in
            print(myData)
            
            if(myData.response?.statusCode == 200){
                let userLogin = try? JSONDecoder().decode(UserLogin.self, from: myData.data!)
                let status = userLogin?.user[0].durum
                let message = userLogin?.user[0].mesaj
                let id = userLogin?.user[0].bilgiler?.userID
                
                
                print("status: \(status!)")
                print("message: \(message!)")
                
                if(status == true){
                    UserDefaults.standard.setValue(id, forKey: "userID")
                    self.performSegue(withIdentifier: "signInToHome", sender: nil)
                }
                
                
            }
        }
        
    }
    
}
