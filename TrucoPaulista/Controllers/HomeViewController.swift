//
//  HomeViewController.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var svForm: UIScrollView?
    
    @IBOutlet var txtCardOne: UITextField?
    @IBOutlet var txtCardTwo: UITextField?
    @IBOutlet var txtCardThree: UITextField?
    @IBOutlet var txtCardFour: UITextField?
    @IBOutlet var txtCardFive: UITextField?
    @IBOutlet var txtCardSix: UITextField?
    @IBOutlet var txtCardSeven: UITextField?
    @IBOutlet var txtCardEight: UITextField?
    @IBOutlet var txtCardNine: UITextField?
    @IBOutlet var txtCardTen: UITextField?
    @IBOutlet var txtRotationCard: UITextField?
    
    @IBOutlet var btnSubmit: UIButton?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.svForm?.contentSize = CGSize(width: self.view.frame.size.width, height: (self.btnSubmit?.frame.maxY ?? 0) + 20)
        }
        
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        btnSubmit?.applyGradient(colors: [UIColor(red: 0.29, green: 0.33, blue: 0.39, alpha: 1.00).cgColor, UIColor(red: 0.73, green: 0.75, blue: 0.79, alpha: 1.00).cgColor])
    }
    
    func loadUI() {
        
    }
    
    @IBAction func clear() {
        txtCardOne?.text = ""
        txtCardTwo?.text = ""
        txtCardThree?.text = ""
        txtCardFour?.text = ""
        txtCardFive?.text = ""
        txtCardSix?.text = ""
        txtCardSeven?.text = ""
        txtCardEight?.text = ""
        txtCardNine?.text = ""
        txtCardTen?.text = ""
        txtRotationCard?.text = ""
    }
    
    @IBAction func submit() {
        
        if let rotationCard = txtRotationCard?.text, rotationCard == "" {
            Util.showMessage(title: "", message: "Define a Rotation Card", type: .warning)
            return
        }
        
        var cards: Array<String> = []
        cards.append(txtCardOne?.text ?? "")
        cards.append(txtCardTwo?.text ?? "")
        cards.append(txtCardThree?.text ?? "")
        cards.append(txtCardFour?.text ?? "")
        cards.append(txtCardFive?.text ?? "")
        cards.append(txtCardSix?.text ?? "")
        cards.append(txtCardSeven?.text ?? "")
        cards.append(txtCardEight?.text ?? "")
        cards.append(txtCardNine?.text ?? "")
        
        let cardsFiltered = cards.filter({$0 != ""})
        
        RequestManager().getCards(cards: cardsFiltered) { (success, response, message) in
            
            if success {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let cardsVC = storyboard.instantiateViewController(identifier: "CardsView") as CardsViewController
                cardsVC.deckID = response?.id
                cardsVC.rotationCard = self.txtRotationCard?.text ?? ""
                cardsVC.cardCount = cardsFiltered.count
                
                self.present(cardsVC, animated: true, completion: nil)
            }else{
                // Deu ruim
            }
                
        }
    }
}

