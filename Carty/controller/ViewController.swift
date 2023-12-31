//
//  ViewController.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//

import UIKit
import Cosmos
import Kingfisher
import Reachability
class ViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var price: UIButton!
    @IBOutlet weak var stock: UIButton!
    @IBOutlet weak var brand: UIButton!
    @IBOutlet weak var discount: UIButton!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var ColHeight: NSLayoutConstraint!
    var constantHeight: CGFloat?

    var product: jsonProduct?
    let reachability = try! Reachability()
    var flag: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        constantHeight = max(self.view.bounds.height, self.view.bounds.width) * 0.4
        setUP()
        reachability.whenReachable = { _ in
            self.whenReached()
            self.reachability.stopNotifier()
        }
        reachability.whenUnreachable = { _ in
            self.goBack()
        }
        
        do{
            try self.reachability.startNotifier()
        }catch{
            print("unable to start")
        }
        
    }
    
    func whenReached(){
        imagesCollection.delegate = self
        imagesCollection.dataSource = self
        imagesCollection.reloadData()
        KF.url(URL(string: product!.thumbnail)).set(to: productImage)
        productImage.layer.cornerRadius = productImage.frame.height / 2
        productImage.layer.borderWidth = 2
        productImage.layer.borderColor = UIColor.systemGray4.cgColor
        let favProduct = CoreManager.CM.fetch(id: product!.id)
        var favButton: UIBarButtonItem
        if favProduct.count > 0{
            favButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(favClicked))
            flag = false
        }else{
            favButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(favClicked))
            flag = true
        }
        favButton.tintColor = UIColor(named: "AppPink")
        navigationItem.rightBarButtonItem = favButton
    }
    func goBack(){
        let alert = UIAlertController(title: "error", message: "No Internet!,please go back", preferredStyle: .alert)
        let action = UIAlertAction(title: "go back", style: .destructive){
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc func favClicked(_ sender: UIBarButtonItem){
        if flag!{
            let data = productImage.image?.jpegData(compressionQuality: 1.0)
            
            CoreManager.CM.addProduct(id: product!.id, title: product!.title, thumbnail: data!)
            sender.image = UIImage(systemName: "heart.fill")
            flag = !flag!
        }else{
            CoreManager.CM.removeProduct(id: product!.id)
            sender.image = UIImage(systemName: "heart")
            flag = !flag!
        }
    }
    
    func setUP(){
        navigationItem.title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        productLabel.text = product!.title
        starsView.rating = product!.rating
        descriptionLabel.text = product!.description
        price.setTitle(String(product!.price), for: .normal)
        stock.setTitle(String(product!.stock), for: .normal)
        brand.setTitle(product!.brand, for: .normal)
        discount.setTitle(String(product!.discountPercentage)+"%", for: .normal)
        ColHeight.constant = constantHeight!
        view.layoutIfNeeded()
    }
}

// collection delegate and data source methods
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product!.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollection.dequeueReusableCell(withReuseIdentifier: "ColCell", for: indexPath) as! ColCell
        KF.url(URL(string: product!.images[indexPath.row])).set(to: cell.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constantHeight!, height: constantHeight!)
    }
    
}

