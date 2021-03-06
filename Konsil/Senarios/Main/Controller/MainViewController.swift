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
    var specialities: [Speciality]?
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        auth()
        getAllSpecialities()
    }
    
    // Get Specialities From API
    func getAllSpecialities(){
        DispatchQueue.main.async {
            self.startAnimating()
            APIClient.allSpeciailies { [weak self] (Result, status) in
                self?.stopAnimating()
                switch Result {
                case .success(let response):
                    self?.specialities = response.data
                    self?.categoriesCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
                    }
                }
            }
        }
    }
    
    // Show Sidemenu
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if "Lang".localized == "ar" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "RightSideMenuNav") as? SideMenuNavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.settings = Shared.settings(view: self.view)
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuNavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.settings = Shared.settings(view: self.view)
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK:- CollectionView SetUp
extension MainViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialities?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! MainCategoriesCollectionViewCell
        if let spec = specialities?[indexPath.row] {
            //Replace space in url with %
            let url = spec.image_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            cell.catImage.sd_setImage(with: URL(string: url ?? ""), placeholderImage: nil, options: .retryFailed) { (image, error, type, url) in
                if image != nil {
                    cell.indicator.stopAnimating()
                }
            }
            cell.catName.text = spec.title
        }
        
        cell.imageSize.constant = self.view.frame.width/2 - 100
        
        // Round Cell Corners
        if "Lang".localized == "ar"{
            
            if indexPath.row == 1 {
                Rounded.topLeft(view: cell.backView)
            }
            else if indexPath.row == 0 {
                Rounded.topRight(view: cell.backView)
            } else {
                Rounded.normalView(view: cell.backView)
            }
            if specialities?.count ?? 0 % 2 == 0 {
                if indexPath.row == (specialities?.count ?? 1000)-1{
                    Rounded.botRight(view: cell.backView)
                }
                if indexPath.row == (specialities?.count ?? 1000)-2{
                    Rounded.botLeft(view: cell.backView)
                }
            } else {
                if indexPath.row == (specialities?.count ?? 1000)-1{
                    Rounded.botRight(view: cell.backView)
                }
            }
            
        } else {
            
            if indexPath.row == 0 {
                Rounded.topLeft(view: cell.backView)
            } else {
                Rounded.normalView(view: cell.backView)
            }
            if indexPath.row == 1 {
                Rounded.topRight(view: cell.backView)
            }
            if (specialities?.count ?? 0) % 2 == 0 {
                if indexPath.row == (specialities?.count ?? 1000)-2{
                    Rounded.botRight(view: cell.backView)
                }
                if indexPath.row == (specialities?.count ?? 1000)-1{
                    Rounded.botLeft(view: cell.backView)
                }
            } else {
                if indexPath.row == (specialities?.count ?? 1000)-1{
                    Rounded.botLeft(view: cell.backView)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Doctors List") as? DoctorsViewController {
            vc.specialityID = specialities?[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: self.view.frame.width/2 - 35, height: self.view.frame.width/2 - 20)
        return cellSize
    }
}
