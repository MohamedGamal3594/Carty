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
    
    var product: jsonProduct?
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        reachability.whenReachable = { _ in
            self.whenReached()
            self.reachability.stopNotifier()
        }
        reachability.whenUnreachable = { _ in
            self.goBack()
        }
        
        do{
            try reachability.startNotifier()
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
        if favProduct.count > 0{
            let favButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(favClicked))
            favButton.tintColor = UIColor(named: "AppPink")
            navigationItem.rightBarButtonItem = favButton
        }else{
            let favButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(favClicked))
            favButton.tintColor = UIColor(named: "AppPink")
            navigationItem.rightBarButtonItem = favButton
        }
    }
    
    @objc func favClicked(_ sender: UIBarButtonItem){
        if sender.image == UIImage(systemName: "heart"){
            let data = productImage.image?.jpegData(compressionQuality: 1.0)
            
            CoreManager.CM.addProduct(id: product!.id, title: product!.title, thumbnail: data!)
            sender.image = UIImage(systemName: "heart.fill")
        }else{
            CoreManager.CM.removeProduct(id: product!.id)
            sender.image = UIImage(systemName: "heart")
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
        ColHeight.constant = view.frame.height * 0.4
        view.layoutIfNeeded()
    }
}

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
        return CGSize(width: self.view.frame.width * 0.7, height: self.view.frame.width * 0.7)
    }
    
}

