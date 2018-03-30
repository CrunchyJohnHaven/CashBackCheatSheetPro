//
//  CategoryPickerVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 3/29/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData //>> refactor to modularize

class CategoryPickerVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var categoryPicked = "Grocery Stores"
    var categoryArr = [Category]()
    var cardArr = [Card]()
    var rankingCardInCategoryArr = [RankingCardWithinCategory]()
    var image: [UIImage] = [#imageLiteral(resourceName: "AmexBlueCashE.png"),#imageLiteral(resourceName: "DiscoverIT.png"),#imageLiteral(resourceName: "ChaseFreedom.png"),#imageLiteral(resourceName: "AmexBlueCashE.png"),#imageLiteral(resourceName: "SavorBlueDining.png"),#imageLiteral(resourceName: "CitiDoubleCash.png"),#imageLiteral(resourceName: "ChaseFreedomUnlimited.png"),#imageLiteral(resourceName: "WellsFargoCash.png")]
    var image1: Dictionary = ["Amex Preferred" : 0, "Discover it" : 1, "Chase Freedom" : 2, "AmEx Blue Cash Everyday": 3, "Savor® Dining Rewards": 4, "Citi® Double Cash Card": 5, "Chase Freedom Unlimited": 6, "Wells Fargo Cash Wise Visa Card": 7]
    var cardArray: [String] = []
    var fullCardArray: [Card] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
//                        seedCards(string: self.categoryPicked)
//                        seedCategories()
//                        seedRankingCardWithinCategory()
        pullFunction()
        cardArr = CardModel.shared.getAll()
        categoryArr = CategoryModel.shared.getAll()
        rankingCardInCategoryArr = RankingCardWithinCategoryModel.shared.getAll()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        pickerView.delegate = self
        pickerView.dataSource = self


    }
    override func viewWillAppear(_ animated: Bool){
//        refreshView()
//        pullFunction()
    }
    
    func pullFunction() {
        print("PullFunction")
        cardArray = []
        for i in cardArr {
            self.cardArray.append(i.title!)
        }
        for i in cardArr {
            
            self.fullCardArray.append(i)
            print("self.fullCardArray: ", self.fullCardArray[0].title!)
        }
        print("*****End Pull Function*****")
    }
    func refreshView() {
        print("*****refreshView*****")
//        deleteAllCards(cards: cardArr)
//        deleteAllCategories(categories: categoryArr)
//        deleteAllRankings(rankings: rankingCardInCategoryArr)
//        tableView.reloadData()
    }
    func deleteAllCategories(categories: [Category]) {
        print("***** Delete All Categories*****")
        for i in categories {
            CategoryModel.shared.delete(i)
        }
    }
    func deleteAllRankings(rankings: [RankingCardWithinCategory]) {
        print("***** Delete All Categories*****")
        for i in rankings {
            RankingCardWithinCategoryModel.shared.delete(i)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        print("categoryArr.count: ", categoryArr.count)
        return categoryArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
//        print("categoryArr[row]: ", categoryArr[row])
        return categoryArr[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print( "picker ar:", categoryArr[row].cards_word! )
        cardArr = CardModel.shared.getAll( for: categoryArr[row].cards_word! )
//        cardArr = CardModel.shared.getAll( for: "amxp" )

        tableView.reloadData()
        }

    func seedCategories(){
        print("***** SeedCategories ******")
        let categories = [
            "Grocery Stores",
            "Restaurants & Coffee",
            "Gas",
            "Pharmacies",
            "Wholesale Clubs",
            "Select Department Stores",
            "Taxi",
            "Other",
        ]
        let cards_word = [
            "amxp-diit-chfp-cidc-chfu-wfcw",
            "svrd-cidc-chfu-wfcw",
            "amxp-amxe-cidc-chfu-wfcw",
            "cidc-chfu-wfcw",
            "cidc-chfu-wfcw",
            "cidc-chfu-wfcw",
            "cidc-chfu-wfcw",
            "cidc-chfu-wfcw",
        ]
        for i in 0..<categories.count {
            print("CATEGORIES CREATED: ", i)
            CategoryModel.shared.create( name: categories[i], cards_word: cards_word[i] )
        }

        categoryArr = CategoryModel.shared.getAll()
//        for i in categoryArr {
//            print("category seeded with:", i.name )
//        }
        print("***** End SeedCategories ******")
    }
    
    func seedCards(string: String){
        print("****seed cards ****", self.categoryPicked)

        let cards = [
            [
                "card_title": "Amex Preferred",
                "annual_fee": "$95",
                "cash_back_terms": "6% cash back at U.S. supermarkets (on up to $6,000 per year in purchases, then 1%). 3% cash back at U.S. gas stations and at select U.S. department stores, 1% back on other purchases.",
                "link_to_apply": "https://www.americanexpress.com/us/credit-cards/card-application/apply/amex-everyday-preferred-credit-card/25330-10-0?pmccode=",
                "other_terms": "Terms Apply",
                "category_code": "amxp"
                ],
            [
                "card_title": "Discover it",
                "annual_fee": "No annual fee",
                "cash_back_terms": "APR - JUN 2018 - Grocery Stores. Earn 5% Cashback Bonus at Grocery Stores from April - June 2018, on up to $1,500 in purchases when you activate. Earn 5% cash back at different places each quarter like gas stations, grocery stores, restaurants, Amazon.com, or wholesale clubs up to the quarterly maximum each time you activate. Earn 1% unlimited cash back automatically on all other purchases.",
                "link_to_apply": "https://www.discovercard.com/application/apply?srcCde=GAYP&mboxPage=product_consumer_it",
                "other_terms": "A first-year cash back match for new cardmembers",
                "category_code": "diit"
            ],
            [
                "card_title": "Chase Freedom",
                "annual_fee": "No annual fee",
                "cash_back_terms": "APR - JUN 2018 - Grocery Stores, not including Walmart and Target. Earn 5% cash back on up to $1,500 in combined purchases in bonus categories each quarter you activate",
                "link_to_apply": "https://applynow.chase.com/FlexAppWeb/renderApp.do?SPID=FQYC&CELL=6TKX&PROMO=DF01",
                "other_terms": "0% intro APR for 15 months from account opening on purchases and balance transfers.† Same page link to Pricing and Terms After that, 16.24%–24.99% variable APR.",
                "category_code": "chfp"
            ],
            [
                "card_title": "AmEx Blue Cash Everyday",
                "annual_fee": "No annual fee",
                "cash_back_terms": "3% cash back at U.S. supermarkets (on up to $6,000 per year in purchases, then 1%). 2% cash back at U.S. gas stations and at select U.S. department stores, 1% back on other purchases.",
                "link_to_apply": "https://www.americanexpress.com/us/credit-cards/card-application/apply/blue-cash-everyday-credit-card/25330-10-0?pmccode=",
                "other_terms": "APR: 0% for 15 months on purchases and balance transfers, then a variable rate, currently 14.49% to 25.49%.",
                "category_code": "amxe"
            ],
            [
                "card_title": "Savor® Dining Rewards",
                "annual_fee": "No annual fee",
                "cash_back_terms": "Earn unlimited 3% cash back on dining, 2% on groceries and 1% on all other purchases",
                "link_to_apply": "https://applynow.capitalone.com/?productId=2739",
                "other_terms": "0% intro APR for 9 months; 15.74% - 24.49% variable APR after that",
                "category_code": "svrd"
            ],

            [ // INDEX 5
                "card_title": "Citi® Double Cash Card",
                "annual_fee": "No annual fee",
                "cash_back_terms": "Earn cash back on your purchases with one of Citi's best cash back credit cards. The Citi Double Cash card lets you earn cash back twice — 1% unlimited on purchases and an additional 1% as you pay for those purchases.",
                "link_to_apply": "https://www.citicards.com/cards/credit/application/flow.action?app=UNSOL&t=t&sc=4T5ZMEH8&m=31A8L10203W&B=M&ID=3000&uc=H28&ProspectID=PR4pg4EY6vJwsZH22S04ezIAgxhuPiRB&intc=7~7~66~1~PDP~1~citi-double-cash-credit-card~4T5ZMEH831A8L10203W&cmv=426&pid=142&walletSegment=C171_02&rCode=I000",
                "other_terms": "Terms Apply",
                "category_code": "cidc"
            ],

            [
                "card_title": "Chase Freedom Unlimited",
                "annual_fee": "No annual fee",
                "cash_back_terms": "Earn unlimited cash back Earn unlimited 1.5% cash back on every purchase – it's automatic. No minimum to redeem for cash back.",
                "link_to_apply": "https://creditcards.chase.com/cash-back-credit-cards/chase-freedom-unlimited?CELL=6TKX&IP3H=Y71UH0&SP4R=FH24R8&F42G=Y538C4",
                "other_terms": "0% intro APR for 12 months from account opening on purchases and balance transfers.† Same page link to Pricing and Terms After that, 14.24%–24.99% variable APR.† Same page link to Pricing and Terms Balance transfer fee is 5% of the amount transferred with a minimum of $5.",
                "category_code": "chfu"
            ],

            [
                "card_title": "Wells Fargo Cash Wise Visa Card",
                "annual_fee": "No annual fee",
                "cash_back_terms": "Earn unlimited 1.5% cash rewards on purchases",
                "link_to_apply": "https://www.wellsfargo.com/wf/product/apply?prodSet=APP2K&prodCode=CC-CW&sub_channel=WEB&vendor_code=WF",
                "other_terms": "Terms apply",
                "category_code": "wfcw"
            ],


        ]
        for i in cards {
            print("CARDS CREATED: ", i)
            CardModel.shared.create( title: i["card_title"]!, annual_fee: i["annual_fee"]!, cash_back_terms: i["cash_back_terms"]!, link_to_apply: i["link_to_apply"]!, other_terms: i["other_terms"]!, category_code: i["category_code"]! )
        }
        
        cardArr = CardModel.shared.getAll()
//        for i in cardArr {
//            print( "card seeded with:", i.title, i.annual_fee, i.cash_back_terms, i.link_to_apply, i.other_terms )
//        }
    }
    func deleteAllCards(cards: [Card]) {
        print("***** Delete All Cards*****")
        for i in cards {
            CardModel.shared.delete(i)
        }
    }
    
    func seedRankingCardWithinCategory() {
        let ranks = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
        
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[0], category: categoryArr[0] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[1], category: categoryArr[0] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[2], category: categoryArr[0] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[3]), card: cardArr[5], category: categoryArr[0] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[4]), card: cardArr[6], category: categoryArr[0] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[5]), card: cardArr[7], category: categoryArr[0] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[4], category: categoryArr[1] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[5], category: categoryArr[1] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[6], category: categoryArr[1] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[3]), card: cardArr[7], category: categoryArr[1] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[0], category: categoryArr[2] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[3], category: categoryArr[2] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[5], category: categoryArr[2] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[3]), card: cardArr[6], category: categoryArr[2] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[4]), card: cardArr[7], category: categoryArr[2] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[5], category: categoryArr[3] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[6], category: categoryArr[3] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[7], category: categoryArr[3] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[5], category: categoryArr[4] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[6], category: categoryArr[4] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[7], category: categoryArr[4] )
        
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[5], category: categoryArr[5] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[6], category: categoryArr[5] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[7], category: categoryArr[5] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[5], category: categoryArr[6] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[6], category: categoryArr[6] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[7], category: categoryArr[6] )

        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[0]), card: cardArr[5], category: categoryArr[7] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[1]), card: cardArr[6], category: categoryArr[7] )
        RankingCardWithinCategoryModel.shared.create( rank: Int16(ranks[2]), card: cardArr[7], category: categoryArr[7] )


        var rankingCardInCategoryArr = [RankingCardWithinCategory]()
//        for i in rankingCardInCategoryArr {
//            print( "ranking seeded with:", i.rank, i.card?.title, i.category?.name )
//        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        performSegue(withIdentifier: "cardDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexRow = sender as? Int {
        let cardDetailsVC = segue.destination as! CardDetailsVC
        cardDetailsVC.card_title = "\(self.fullCardArray[indexRow].title!)"
        cardDetailsVC.annual_fee = "\(self.fullCardArray[indexRow].annual_fee!)"
        cardDetailsVC.cash_back_terms = "\(self.fullCardArray[indexRow].cash_back_terms!)"
        cardDetailsVC.link_to_apply = "\(self.fullCardArray[indexRow].link_to_apply!)"
        cardDetailsVC.other_terms = "\(self.fullCardArray[indexRow].other_terms!)"
        cardDetailsVC.image = self.image[indexRow]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CategoryPickerVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("******* TableDelegate  ******* cardArr.count: ", cardArr.count)
        return cardArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("******* Start CellForRowAt *******")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.cardImage.image = self.image[indexPath.row]
        print("self.image1: ", self.image1)
        for key in self.image1 {
            print("KEY: ", key)
            if cardArray[indexPath.row] == "\(key)" {
                print("*********MATCH*********")
                cell.cardImage.image = self.image[indexPath.row]
            }
        }

        cell.cardTitleLabel.text = "\(cardArray[indexPath.row])"
        

//        cell.cardImage.image = // PLACEHOLDER FOR THE IMAGE
        print("******* End CellForRowAt *******")
        return cell
    }
}

//    // Create Mutable Set
//    let users = account.mutableSetValue(forKey: #keyPath(Account.users))
//
//    // Add User
//    users.add(user)
////        Card - To Many - (ranking_within_category - RankingCardWithinCategory - card)
//let cardrank = RankingCardWithinCategory(context: managedObjectContext)
////        Category - To Many - ( ranking_of_cards - RankingCardWithinCategory - categories)
//let categoryrank = RankingCardWithinCategory(context: managedObjectContext)
////        RankingCardWithinCategory - to One (category - Category - ranking_of_cards)
//
////        RankingCardWithinCategory() To One (card - Card - ranking_of_categories)
