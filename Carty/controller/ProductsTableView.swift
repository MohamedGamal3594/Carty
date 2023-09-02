//
//  ProductsTableView.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//

import UIKit
import Reachability
import Kingfisher

class ProductsTableView: UITableViewController {
    var products = [jsonProduct]()
    let reachability = try! Reachability()
    var indicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = view.center
        view.addSubview(indicator)
        
        reachability.whenReachable = { _ in
            self.whenReached()
        }
        
        reachability.whenUnreachable = {_ in
            self.setEmptyView(title: "No Internet Connection!!", messageImage: UIImage(systemName: "wifi.slash")!)
        }
        
        do{
            try reachability.startNotifier()
        }catch{
            print("unable to start")
        }
    }
    
    func whenReached(){
        self.indicator.startAnimating()
        JsonManager.JM.getData { response in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
            guard let response = response as? [jsonProduct]else{
                let message = response as! String
                DispatchQueue.main.async {
                    self.showOKAlert(message: message)
                }
                return
            }
            
            
            self.products.append(contentsOf: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.restore()
            }
            self.reachability.stopNotifier()
        }
    }
    
    func showOKAlert(message: String){
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}

// table delegate and data source methods
extension ProductsTableView{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proCell") as! ProductsTableCell
        
        let product = products[indexPath.row]
        
        KF.url(URL(string: product.thumbnail)).set(to: cell.productImage)
        cell.productLabel.text = product.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let View = storyboard?.instantiateViewController(withIdentifier: "VC") as! ViewController
        View.product = products[indexPath.row]
        navigationController?.pushViewController(View, animated: true)
    }
}
