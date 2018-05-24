//
//  ViewController.swift
//  Stretchy Snacks
//
//  Created by Alejandro Zielinsky on 2018-05-24.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var customNavBar: UIView!
    
    var horizontalStackView : UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var snacks = [String]()
    
    var centerYClosedConstraint :NSLayoutConstraint!
    
    var centerYOpenConstraint : NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpStackView()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil)
    {
        switch sender?.view?.tag
        {
        case 1:
            print("Oreo Tapped")
            snacks.append("Oreo");
        case 2:
            print("Pizza Tapped")
            snacks.append("Pizza Pocket");
        case 3:
            print("Pop Tarts Tapped")
            snacks.append("Pop Tart");
        case 4:
            print("popsicle Tapped")
             snacks.append("Popsicle");
        case 5:
            print("ramen Tapped")
             snacks.append("Ramen");
        default:
            print("Unknown Tag");
        }
        
        tableView.reloadData()
    }
    
    func setUpStackView()
    {
        let snacksLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        snacksLabel.text = "Snacks!"
        snacksLabel.font = snacksLabel.font.withSize(25)
        snacksLabel.textAlignment = .center
        snacksLabel.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.addSubview(snacksLabel);
        snacksLabel.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor).isActive = true;
       // snacksLabel.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor).isActive = true;
        centerYClosedConstraint = NSLayoutConstraint(item: snacksLabel, attribute: .centerY, relatedBy: .equal, toItem: customNavBar, attribute: .centerY, multiplier: 1.0, constant: 0)
        centerYClosedConstraint.isActive = true;
        
      centerYOpenConstraint = NSLayoutConstraint(item: snacksLabel, attribute: .centerY, relatedBy: .equal, toItem: customNavBar, attribute: .centerY, multiplier: 1.0, constant: -40)
        centerYOpenConstraint.isActive = false;
   
        
        let imageViewOne = UIImageView()
        imageViewOne.image = UIImage(named: "oreos")
        imageViewOne.isUserInteractionEnabled = true
        imageViewOne.tag = 1;
        let oreoTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageViewOne.addGestureRecognizer(oreoTapped)
        
        let imageViewTwo = UIImageView()
        imageViewTwo.isUserInteractionEnabled = true
        imageViewTwo.tag = 2;
        imageViewTwo.image = UIImage(named: "pizza_pockets")
        let pizzaTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageViewTwo.addGestureRecognizer(pizzaTapped)
        
       
        let imageViewThree = UIImageView()
        imageViewThree.isUserInteractionEnabled = true
        imageViewThree.tag = 3;
        imageViewThree.image = UIImage(named: "pop_tarts")
        let popTartsTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageViewThree.addGestureRecognizer(popTartsTapped)
        

        let imageViewFour = UIImageView()
        imageViewFour.isUserInteractionEnabled = true
        imageViewFour.tag = 4;
        imageViewFour.image = UIImage(named: "popsicle")
        let popsicleTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageViewFour.addGestureRecognizer(popsicleTapped)

        let imageViewFive = UIImageView()
        imageViewFive.isUserInteractionEnabled = true
        imageViewFive.tag = 5;
        imageViewFive.image = UIImage(named: "ramen")
        let ramenTapped = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageViewFive.addGestureRecognizer(ramenTapped)


        
        horizontalStackView = UIStackView(arrangedSubviews: [imageViewOne,imageViewTwo,imageViewThree,imageViewFour,imageViewFive])
        horizontalStackView.frame = CGRect(x: 0, y: 0, width: customNavBar.bounds.width, height: 30)
        horizontalStackView.axis = UILayoutConstraintAxis.horizontal;
        horizontalStackView.distribution = UIStackViewDistribution.fillEqually;
        horizontalStackView.alignment = UIStackViewAlignment.center;
        horizontalStackView.spacing = 1;
        
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false;
        
        customNavBar.addSubview(horizontalStackView);
        

        horizontalStackView.widthAnchor.constraint(equalToConstant:customNavBar.bounds.width).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: customNavBar.bottomAnchor).isActive = true
        
        horizontalStackView.isHidden = true;
    }

    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    
    @IBAction func addButtonPressed(_ sender: Any)
    {
        var rotation:CGFloat!;
        var height:CGFloat!;
        
        if(self.navBarHeightConstraint.constant == 66)
        {
            rotation = CGFloat(Double.pi/4.0)
            height = 200;
            centerYClosedConstraint.isActive = false;
            centerYOpenConstraint.isActive = true;
            
            horizontalStackView.isHidden = false;
        }
        else
        {
            rotation = CGFloat(-(Double.pi/2.0))
            height = 66;
            
            centerYOpenConstraint.isActive = false;
            centerYClosedConstraint.isActive = true;
            horizontalStackView.isHidden = true;
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.navBarHeightConstraint.constant = height// Some value
            self.plusButton.transform = CGAffineTransform(rotationAngle: rotation);
           // self.plusButton.transform = CGAffineTransform(rotationAngle: 90);
            self.view.layoutIfNeeded()
        })
        
    }
    
}

extension ViewController : UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath);
        cell.textLabel?.text = snacks[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
}

