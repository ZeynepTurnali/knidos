//
//  ProductPage.swift
//  shoppingApplication

import UIKit
import Alamofire

class ProductPage: UITableViewController {
    
    var productsArray: [BilgilerProduct]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.title = "Ürünler"
        tableView.rowHeight = 200
        
        getProducts()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let item = productsArray![indexPath.row]
        let imageUrl = URL(string: item.images[0].normal)!
    //    let data = try? Data(contentsOf: imageUrl.asURL())
        
        cell.productImage.loadImage(fromURL: imageUrl, placeHolderImage: "shopping")
      //  cell.productImage?.image = UIImage(data: data!)
        cell.productNameLabel.text = item.productName
        cell.productPriceLabel.text = "\(item.price) ₺"
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailProduct", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailProduct") {
            let vc = segue.destination as! ProductDetail
            vc.detailArray = self.productsArray!
            vc.selected = sender as! Int
        }
    }
    
    
    
    func getProducts(){
        let url = "https://jsonbulut.com/json/product.php"
        let params = ["ref": "5380f5dbcc3b1021f93ab24c3a1aac24", "start": "0"]
        
        let request = AF.request(url, method: .get, parameters: params).validate()
        request.responseJSON {(myData) in
            // print(myData)
            
            if(myData.response?.statusCode == 200){
                let productList = try? JSONDecoder().decode(Products.self, from: myData.data!)
                let status = productList?.products[0].durum
                let message = productList?.products[0].mesaj
                
                if (status == true) {
                    self.productsArray = productList?.products[0].bilgiler
                    print(message!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print(message!)
                }
            }
        }
        
        
    }
}
