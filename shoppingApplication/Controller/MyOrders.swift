//
//  MyOrders.swift
//  shoppingApplication

import UIKit
import Alamofire
import AlamofireImage

class MyOrders: UITableViewController {
    
    var myOrderListArray: [OrderListElement]? = []
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        getMyOrders()
        sender.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Siparişlerim"
        self.tableView.rowHeight = 200
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getMyOrders()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myOrderListArray!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrdersCell", for: indexPath) as! MyOrdersCell
        
        let item = myOrderListArray![indexPath.row]
        cell.orderImage.image = UIImage(named: "shopping")
        
        let imageUrl = URL(string: item.normal)!
        AF.request(imageUrl).responseImage(completionHandler: {(response) in
            
            DispatchQueue.main.async {
                //  cell.orderImage.af_setImage(withURL: imageUrl)
                if case .success(let image) = response.result {
                    cell.orderImage.image = image
                }
            }
        })
        //   cell.orderImage.loadImage(fromURL: imageUrl, placeHolderImage: "shopping")
        
        
        
        
        //        let imageUrl = URL(string: item.normal)!
        //        let data = try? Data(contentsOf: imageUrl.asURL())
        //        let image = UIImage(data: data!)!
        //        let imageData = image.jpegData(compressionQuality: 1.0)
        //        cell.orderImage.image = UIImage(data : imageData!)
        
        //        DispatchQueue.global().async { [weak self] in
        //                    if let data = try? Data(contentsOf: URL(string: item.normal)!) {
        //                        if let image = UIImage(data: data) {
        //                            DispatchQueue.main.async {
        //                               // self?.image = image
        //                                cell.orderImage.image = image
        //                            }
        //                        }
        //                    }
        //                }
        cell.orderNameText.text = item.urunAdi
        cell.orderPriceText.text = "\(item.fiyat) ₺"
        
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
        func getMyOrders(){
            let customerId = UserDefaults.standard.value(forKey: "userID")!
    
            let url = "https://jsonbulut.com/json/orderList.php"
            let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "musterilerID": customerId]
    
            print("customerID: \(customerId)")
    
            let request = AF.request(url, method: .get, parameters: params).validate()
            request.responseJSON {(myData) in
    
                //print(myData)
    
                if(myData.response?.statusCode == 200){
                    let orderList = try? JSONDecoder().decode(OrderList.self, from: myData.data!)
                    print("******")
                    print(self.myOrderListArray!.count)
                    if orderList != nil {
                        self.myOrderListArray = orderList?.orderList[0]
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
    
    
                }
    
            }
        }
    
//    func getMyOrders(){
//        let customerId = UserDefaults.standard.value(forKey: "userID")!
//        let url = "https://jsonbulut.com/json/orderList.php"
//        let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "musterilerID": customerId]
//
//        let request = AF.request(url, parameters: params, requestModifier: { $0.timeoutInterval = 5 }).validate()
//        request.responseJSON { (data) in
//            print(data)
//        }
//
//        request.responseDecodable(of: OrderList.self) { (response) in
//            switch response.result {
//            case .success(let model):
//                self.myOrderListArray = model.orderList.last
//                print(self.myOrderListArray!)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.tableView.tableFooterView = UIView(frame: .zero)
//                }
//
//            case .failure(let error):
//                print(error)
//                print("failure failure..........")
//                print(self.myOrderListArray!)
//                print("order api results can not be return")
//
//            }
//        }
//    }
    
}
