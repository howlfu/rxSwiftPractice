//
//  VerticalViewController.swift
//  rxSwiftPractice
//
//  Created by Howlfu on 2022/9/28.
//
import UIKit
import RxSwift
import RxCocoa

class VerticalViewController: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: VerticalViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        initTableView()
        bindAll()
    }
    
    private func initTableView() {
        self.tableView.separatorStyle = .none
//        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = self.tableView.frame.height / 2
        
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
        let items = viewModel.getItems()
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell()
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
}
