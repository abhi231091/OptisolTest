//
//  ViewController.swift
//  SystemTest_Abhishek
//
//  Created by Abhishek Nagar on 31/07/20.
//  Copyright © 2020 Abhishek Nagar. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    //UI properties
    @IBOutlet weak var collectionView: UICollectionView!
    private var searchController : UISearchController?
    
    private var filteredTableData = [Value]()
    private var viewModel: CountryVM? {
        didSet {
            viewModel?.getServerData(offset: "0") { (_) in
                DispatchQueue.main.async {
                    self.title = self.viewModel?.dataTitle
                    self.collectionView.reloadData()
                }
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presentSearchController()
        setupViewModel()
    }
    //setup the ViewModel
    private func setupViewModel() {
        //setup the VM
        viewModel = CountryVM()
    }
    
}

// MARK: - ViewController Extension

extension ViewController {
    //setup SearchController
    private func presentSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Here"
        if #available(iOS 11.0, *){
            self.navigationItem.searchController = searchController
            searchController?.isActive = true
        }
        else{
            present(searchController!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Tap to full image
    func addImageViewWithImage(url: URL) {
        
        let imageView = ImageLoader(frame: self.view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.black
        imageView.isUserInteractionEnabled = true
        imageView.loadImageWithUrl(url)
        imageView.tag = 100
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(self.removeImage))
        dismissTap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(dismissTap)
        self.view.addSubview(imageView)
    }
    @objc func removeImage() {
        
        let imageView = (self.view.viewWithTag(100)! as! UIImageView)
        imageView.removeFromSuperview()
    }
    
    // MARK: - copy image to PasteBoard
    @objc func copyToPasteBoard( sender: UILongPressGestureRecognizer){
        if let image = (sender.view as? ImageLoader)?.image{
            UIPasteboard.general.image = image
        }
    }
}

// MARK: - ViewController : UISearchResultsUpdating Extension

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        guard let vm = viewModel else{return}
        filteredTableData = vm.dataValues.filter { ($0.name?.contains(searchText))! }
        collectionView.reloadData()
    }
}

// MARK: - ViewController : UICollectionView Extension

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController?.isActive == true ? filteredTableData.count : self.viewModel?.itemCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        let data = searchController?.isActive == true ? filteredTableData[indexPath.row] : self.viewModel?.item(indexPath)
        (cell.viewWithTag(2) as? UILabel)?.text = data?.name
        (cell.viewWithTag(3) as? UILabel)?.text = data?.datePublished
        if let localDate = data?.datePublished?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"){
            (cell.viewWithTag(4) as? UILabel)?.text = localDate
        }

        if let imgUrl = URL(string: data?.thumbnailURL ?? "") {
            (cell.viewWithTag(1) as? ImageLoader)?.loadImageWithUrl(imgUrl)
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.copyToPasteBoard(sender:)))
            longGesture.minimumPressDuration = 2
            (cell.viewWithTag(1) as? ImageLoader)?.addGestureRecognizer(longGesture)
        }
        //infinite scroll when reach to last cell
        if indexPath.row == (self.viewModel?.dataValues.count ?? 0) - 1 { // last cell
            if self.viewModel?.totalEstimatedMatches ?? 0 > (self.viewModel?.dataValues.count ?? 0) { // more items to fetch
                viewModel?.loadMoreData(offset: self.viewModel?.nextOffset ?? 20, completion: {
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                    }
                })
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( self.collectionView.frame.size.width - 60 ) / 3
        return CGSize(width: width,height: (260.0/128.0)*width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = searchController?.isActive == true ? filteredTableData[indexPath.row] : self.viewModel?.item(indexPath)
        if let imgUrl = URL(string: data?.contentURL ?? "") {
            addImageViewWithImage(url: imgUrl)
        }
    }
    
}
