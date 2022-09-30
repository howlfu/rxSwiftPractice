//
//  HorizontalViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//

import UIKit
import RxSwift
import RxCocoa
class HorizontalViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel: HorizontalViewModel!
    @IBOutlet weak var tableView: UITableView!
    private lazy var tableViewRowHeight = tableView.frame.height / 2
//    var collectionView: UICollectionView {
//
//
//    }
    override func viewDidLoad() {
        initTableView()
        bindAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func initTableView() {
        self.tableView.separatorStyle = .none
//        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = tableViewRowHeight
        
    }
    
    private func bindAll() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.rx.event.bind(onNext: { recognizer in
            self.viewModel.backToMain()
        }).disposed(by: disposeBag)
        
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(tapGesture)
        bindTableView()
    }
    
    private func bindTableView() {
        let items = viewModel.getCellItems()
        items.bind(to: tableView.rx.items) { [weak self] (tableView, row, element) in
            let cell = UITableViewCell()
            if row == 0 {
                self?.getCollecionCell(tableCell: cell)
                return cell
            }
            let bkView = UIView()
            let image = UIImageView()
            image.image = UIImage(named: element)
            image.translatesAutoresizingMaskIntoConstraints = false
            bkView.backgroundColor = .white
            bkView.addSubview(image)
            bkView.contentMode = .scaleAspectFit
            bkView.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.contentView.addSubview(bkView)
            
            //layout
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: bkView.topAnchor),
                image.bottomAnchor.constraint(equalTo: bkView.bottomAnchor),
                image.leftAnchor.constraint(equalTo: bkView.leftAnchor),
                image.rightAnchor.constraint(equalTo: bkView.rightAnchor),
                
                bkView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                bkView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
                bkView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor),
                bkView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor)
            ])
            return cell
            
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("item: \(indexPath.row) is selected")
        }).disposed(by: disposeBag)
        
//        tableView.rx.modelSelected(UIImage.self).subscribe(onNext: { item in
//
//        })

    }
    
    private func getCollecionCell(tableCell: UITableViewCell){
        let itemSize =  CGSize(width: self.tableView.frame.width , height: tableViewRowHeight)
        let layout = UICollectionViewFlowLayout()
        layout
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = itemSize
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
//        collectionView.isUserInteractionEnabled = true
//        collectionView.isScrollEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collCell")
//        collectionView.scrollToItem(at:  IndexPath(item: 0, section: 0), at: .right, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        tableCell.contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tableCell.contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: tableCell.contentView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: tableCell.contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: tableCell.contentView.rightAnchor),
            
        ])
        let items = viewModel.getCollectionItems()
        items.bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let colCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
                    
            let bkView = UIView()
            let image = UIImageView()
            image.image = UIImage(named: element)
            image.translatesAutoresizingMaskIntoConstraints = false
            bkView.backgroundColor = .white
            bkView.addSubview(image)
            bkView.contentMode = .scaleAspectFit
            bkView.translatesAutoresizingMaskIntoConstraints = false
            colCell.backgroundColor = .white
            colCell.contentView.addSubview(bkView)
            //layout
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: bkView.topAnchor, constant: 10),
                image.bottomAnchor.constraint(equalTo: bkView.bottomAnchor, constant: -10),
                image.leftAnchor.constraint(equalTo: bkView.leftAnchor, constant: 10),
                image.rightAnchor.constraint(equalTo: bkView.rightAnchor, constant: -10),
                
                bkView.topAnchor.constraint(equalTo: colCell.contentView.topAnchor),
                bkView.bottomAnchor.constraint(equalTo: colCell.contentView.bottomAnchor),
                bkView.leftAnchor.constraint(equalTo: colCell.contentView.leftAnchor),
                bkView.rightAnchor.constraint(equalTo: colCell.contentView.rightAnchor)
            ])
            
            return colCell
         }.disposed(by: disposeBag)
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("collection item: \(indexPath.row) is selected")
        }).disposed(by: disposeBag)
    }
}
