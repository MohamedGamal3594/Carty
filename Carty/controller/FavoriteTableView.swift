//
//  FavoriteTableView.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//

import UIKit

class FavoriteTableView: UITableViewController {
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        products = CoreManager.CM.fetchProducts()
        tableView.reloadData()
        
    }


}

extension FavoriteTableView{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.products.count > 0{
            self.restore()
        }else{
            let image = UIImage(systemName: "trash")
            
            self.setEmptyView(title: "No saved products!", messageImage: image!)
        }
        return self.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoritesTableCell
        let image = UIImage(data: products[indexPath.row].thumbnail!)
        cell.favImage.image = image
        cell.label.text = products[indexPath.row].title!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "confirm", message: "Are you sure you want to delete it?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default){ _ in
                CoreManager.CM.removeProduct(id: self.products[indexPath.row].id)
                self.products = CoreManager.CM.fetchProducts()
                self.tableView.reloadData()
            }
            
            let noAction = UIAlertAction(title: "No", style: .destructive)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.present(alert, animated: true)
        }
    }
    
}
