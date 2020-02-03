//
//  MainViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SDWebImage
import SideMenu
import BiometricAuthentication
class MainViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK:- Variables
    var catImage: [String]?
    var catName: [String]?
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        catImage = Categories.catImage
        catName = Categories.catName
        auth()
    }
    
    func auth(){
        if Shared.BiometricAuthEnabled == true {
            if BioMetricAuthenticator.canAuthenticate() {
                BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (Response) in
                    switch Response {
                    case .success(let res):
                        if res == true {
                            print("Auth Done")
                        } else {
                            print("Wrong")
                        }
                    case .failure(let error ):
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            }
        }
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuNavigationController {
            vc.modalPresentationStyle = .overFullScreen
            vc.settings = Shared.settings(view: self.view)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

//MARK:- CollectionView SetUp
extension MainViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! MainCategoriesCollectionViewCell
        
        cell.catImage.image = UIImage(named: catImage?[indexPath.row] ?? "")
        cell.catName.text = catName?[indexPath.row].localized
        
        
        cell.imageSize.constant = self.view.frame.width/2 - 60
        if indexPath.row == 0 {
            Rounded.topLeft(view: cell.backView)
        } else {
            Rounded.normalView(view: cell.backView)
        }
        if indexPath.row == 1 {
            Rounded.topRight(view: cell.backView)
        }
        if indexPath.row == (catImage?.count ?? 1000)-1{
            Rounded.botRight(view: cell.backView)
        }
        if indexPath.row == (catImage?.count ?? 1000)-2{
            Rounded.botLeft(view: cell.backView)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Doctors List") as? DoctorsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: self.view.frame.width/2 - 35, height: self.view.frame.width/2)
        return cellSize
    }
}
