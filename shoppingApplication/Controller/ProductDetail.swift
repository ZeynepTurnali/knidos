//
//  ProductDetail.swift
//  shoppingApplication

import UIKit
import Alamofire
import WebKit

class ProductDetail: UIViewController {

    var detailArray: [BilgilerProduct] = []
    var selected = 0
    
    @IBOutlet weak var productImageDetail: UIImageView!
    @IBOutlet weak var productPriceDetail: UILabel!
    @IBOutlet weak var productNameDetail: UILabel!
    @IBOutlet weak var productTextView: UITextView!
    @IBOutlet weak var productWebView: WKWebView!
    @IBOutlet weak var detailAddButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.title = "Siparişlerim"
        
        productWebView.loadHTMLString("https://www.youtube.com/watch?v=GEZhD3J89ZE", baseURL: nil)
        productNameDetail.text = detailArray[selected].productName
        let detailContext = detailArray[selected].bilgilerProductDescription
        if detailContext.contains("youtube"){
            self.productWebView.loadHTMLString(detailContext, baseURL: nil)
            productTextView.text = detailArray[selected].brief
            self.productWebView.translatesAutoresizingMaskIntoConstraints = true
            self.productWebView.frame = CGRect(x: 30, y: 520, width: 354, height: 200)
        } else if detailContext.contains("css"){
            productTextView.text = detailArray[selected].brief
            productWebView.alpha = 0
        } else {
            UIView.animate(withDuration: 1.0) {
                self.productTextView.text = detailContext
                self.productTextView.translatesAutoresizingMaskIntoConstraints = true
             self.productTextView.frame = CGRect(x: 30, y: 480, width: 354, height: 200)
            }
            productWebView.alpha = 0
        }
        productPriceDetail.text = "\(detailArray[selected].price) ₺"
        
        let img = detailArray[selected].images[0].normal
        let data = try? Data(contentsOf: img.asURL())
        productImageDetail.image = UIImage(data: data!)
        
        let myOrders = UIBarButtonItem(title: "Siparişlerim", style: .plain, target: self, action: #selector(myOrdersTapped))
        navigationItem.rightBarButtonItems = [myOrders]
        
        detailAddButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func getOrder(_ sender: UIButton) {
        let productId = detailArray[selected].productID
        let customerId = UserDefaults.standard.value(forKey: "userID")!
        
        let url = "https://jsonbulut.com/json/orderForm.php"
        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "customerId": customerId,"productId": productId, "html": productId]
        
        
        let request = AF.request(url, method: .get, parameters: params as Parameters).validate()
        request.responseJSON {(myData) in
           // print(myData)
            
            if(myData.response?.statusCode == 200){
                let order = try? JSONDecoder().decode(Order.self, from: myData.data!)
                let status = order?.order[0].durum
                let message = order?.order[0].mesaj
                print("status: \(status!)")
                print("message: \(message!)")
            }
        }
    }
    @objc func myOrdersTapped(){
        performSegue(withIdentifier: "myOrders", sender: nil)
    }
}
