//
//  FeedController.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/19/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    private let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdhdnp3ZWF5dXdyZ21sd2t2d3FqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIxOTgwNzQsImV4cCI6MjA0Nzc3NDA3NH0.C66tH0cvY_nJaa4izwMh9OpH9Xp4oNHaGFGUrwVxXuc"
    
    private var selectedLabel:String = Category.mobile.rawValue
    private var feedData:APIDTOModel = []
    private var filteredFeedData: APIDTOModel = []
    private var feedUIData: [FeedUIModel] = []
    
    @IBOutlet weak var customSegment: CustomSegment! {
        didSet{
            customSegment.delegate = self
        }
    }
    
    @IBOutlet weak var feedCollection: UICollectionView! {
        didSet{
            feedCollection.collectionViewLayout = layoutGenerator()
            feedCollection.delegate = self

        }
    }
    
    private func reloadData(){
        var snapshoot = NSDiffableDataSourceSnapshot<Int, FeedUIModel>()
        snapshoot.appendSections([0])
        snapshoot.appendItems(feedUIData, toSection: 0)
        dataSource.apply(snapshoot)
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, FeedUIModel> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, FeedUIModel>(collectionView: feedCollection) { [unowned self] collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
            let item = feedUIData[indexPath.row]
            cell.configureCell(with: item)
            return cell
        }
        
        return dataSource
    }()
    
    private lazy var progress:UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.hidesWhenStopped = true
        progress.color = .brandLight
        progress.style = .large
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private func layoutGenerator () ->UICollectionViewLayout{
        
        let sectionProvider:UICollectionViewCompositionalLayoutSectionProvider = { section,enviroment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(330))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(330))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 20
            
            return section
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
        
        return compositionalLayout
    }
    
    
    @IBAction func menuButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MenuView", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {return}
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func loadView() {
        super.loadView()
        fetch()
    }
    
    private func fetch(){
        let urlString = "https://gavzweayuwrgmlwkvwqj.supabase.co/rest/v1/newsfeed"
        guard let url = URL(string: urlString) else {return}
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.setValue(key, forHTTPHeaderField: "apikey")
        progress.startAnimating()
        let session = URLSession.shared.dataTask(with: urlReq) {[weak self] data, response, error in
            guard let data, let self else {return}
            
            if let error = error {
                print("Request Error: \(error)")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(APIDTOModel.self, from: data)
                feedData = decodedData
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    progress.stopAnimating()
                    filterFeedData()
                    
                }
            }catch {
                print("Error decoding JSON: \(error)")
            }
        }
        session.resume()
    }
}

extension FeedController:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideRightPresenter(presentedViewController: presented, presenting: presenting)
    }
}

extension FeedController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailsView", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() as? DetailsController else {return}
        let item = filteredFeedData[indexPath.row]
        guard
            let title = item.title,
            let details = item.details,
            let urlString = item.image,
            let image = URL(string: urlString)
        else {return}
        vc.singleModel = .init(title: title, details: details, imageUrl: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FeedController:CustomSegmentDelegate{
    func didSelect(name: String) {
        filterFeedData(name: name)
    }
    
    private func filterFeedData(name:String = "mobile") {
        filteredFeedData = feedData.filter { $0.category!.rawValue == name.lowercased()}
        feedUIData = filteredFeedData.compactMap({ model -> FeedUIModel? in
            guard
                let id = model.id,
                let title = model.title,
                let description = model.description,
                let urlString = model.image,
                let image = URL(string: urlString)
            else {return nil}
            return .init(id: id, title: title, description: description, imageUrl: image)
        })
        reloadData()
    }
    
}
