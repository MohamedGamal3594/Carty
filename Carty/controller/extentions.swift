//
//  extentions.swift
//  Carty
//
//  Created by Jimmy on 30/08/2023.
//

import UIKit

extension UITableViewController {
    
    func setEmptyView(title: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.tableView.center.x, y: self.tableView.center.y, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor(named: "AppPink")
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        messageImageView.tintColor = UIColor(named: "AppPink")
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        
        self.tableView.backgroundView = emptyView
    }
    
    func restore() {
        self.tableView.backgroundView = nil
    }
    
    func showOKAlert(message: String){
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension UIViewController{
    func goBack(){
        let alert = UIAlertController(title: "error", message: "No Internet!,please go back", preferredStyle: .alert)
        let action = UIAlertAction(title: "go back", style: .destructive){
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
