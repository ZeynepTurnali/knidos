//
//  SignUp.swift
//  shoppingApplication


import UIKit
import Alamofire

class SignUp: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userSurnameText: UITextField!
    @IBOutlet weak var userPhoneText: UITextField!
    @IBOutlet weak var userMailText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let name = userNameText.text!
        let surName = userSurnameText.text!
        let phone = userPhoneText.text!
        let mail = userMailText.text!
        let password = userPasswordText.text!
        
        getRegister(userName: name, userSurName: surName, userPhone: phone, userMail: mail, userPassword: password)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    
    func getRegister(userName : String, userSurName: String, userPhone: String, userMail: String, userPassword: String){
        let url = "https://jsonbulut.com/json/userRegister.php"
        
        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "userName": userName, "userSurname": userSurName, "userPhone": userPhone, "userMail": userMail, "userPass": userPassword]
        
        let request = AF.request(url, method: .get, parameters: params).validate()
        request.responseJSON {(myData) in
            //  print(myData)
            
            if(myData.response?.statusCode == 200){
                let userSignUp = try? JSONDecoder().decode(UserSignUp.self, from: myData.data!)
                let status = userSignUp?.user[0].durum
                let message = userSignUp?.user[0].mesaj
                let id = userSignUp?.user[0].kullaniciID
                
                if(status == false){
                    print("Hata!: \(message!)")
                    // TODO: popup içerisine mesajı bastır. her hatada farklı bir text geliyor zaten
                    
                } else {
                    print(message!)
                    UserDefaults.standard.setValue(id, forKey: "userID")
                    self.performSegue(withIdentifier: "register", sender: nil)
                }
            }
            
        }
        
        
    }
    
}
