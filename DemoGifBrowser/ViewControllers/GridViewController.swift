//
//  GridViewController.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GridViewController: UICollectionViewController {

    //dependencies
    var viewModel: GridViewModel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        fetchItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GridCollectionViewCell
    
        let cellViewModel = viewModel.cellViewModel(at: indexPath.item)
        
        cell.viewModel = cellViewModel
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    

}

//MARK: Configure view

extension GridViewController {
    
    func configureView() {
        
        configureCollectionViewLayout()
    }
    
    func configureCollectionViewLayout() {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(width: 44.0, height: 44.0)        
    }
}

//MARK: View States

extension GridViewController {
    
    func updateView(with error: Error) {
        
        showErrorAlert(with: error.localizedDescription)
    }
    
    func updateView() {
        
        collectionView?.reloadData()
    }
}

//MARK: Other actions

extension GridViewController {

    func fetchItems() {
        
        viewModel.fetchItems { [weak self] error in
            
            guard let err = error else {
                
                self?.updateView()
                
                return
            }
            
            self?.updateView(with: err)
        }
    }
    
    func showErrorAlert(with message: String) {
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
