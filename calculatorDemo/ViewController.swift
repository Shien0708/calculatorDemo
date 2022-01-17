//
//  ViewController.swift
//  calculatorDemo
//
//  Created by 方仕賢 on 2022/1/15.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    
    @IBOutlet weak var allClearButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    //儲存尚未使用的符號
    var unusedSymbols = [String]()
    
    //儲存使用過的符號
    var usedSymbols = [String]()
    
    //最後一個被呼喚的符號
    var symbol = ""
    
    //尚在編輯的數字
    var tempNum = String()
    
    //儲存完成編輯的數字
    var nums = [Float]()
    
    //是否有使用負號
    var negativeOn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.isHidden = true
        
        // Do any additional setup after loading the view.
      
    }

    
    //除去原本顯示的 0
    func removeZero() {
        
        if displayLabel.text == "0" {
            
            displayLabel.text = ""
            
        }
    }
    
    //將正在輸入的數字集合起來
    func addNumToTemp(stringNum: String){
        
        removeZero()
        tempNum += stringNum
        displayLabel.text! = tempNum
        
    }
    
    //使用到加減乘除時，將計算過的第二個數字刪除。且將符號暫存後刪除。
    func fourSymbols() {
        
        nums.remove(at: 1)
        usedSymbols.append(symbol)
        unusedSymbols.remove(at: 0)
        
    }
    
    //用符號判斷兩個數字的計算或一個數字的變換
    func calculate() {
        
        symbol = unusedSymbols.first ?? ""
        
        
        switch symbol{
            
        case "+":
            
            nums[0] += nums[1]
            fourSymbols()
            
        case "-":
            
            nums[0] -= nums[1]
            fourSymbols()
            
        case "*":
            
            nums[0] *= nums[1]
            fourSymbols()
            
        case "/":
            
            nums[0] /= nums[1]
            fourSymbols()
        
          
        
        default:
            
            tempNum += ""
            
        }
        
        
        //判斷計算完的數字是否為浮點數
        if nums.count > 0 {
            
        
            if nums[0] - Float(Int(nums[0])) == 0 {
            
            displayLabel.text = String(Int(nums[0]))
            
            } else {
            
            displayLabel.text = String(nums[0])
                
            }
            
        }
        
        
    }
    
    //使用到加減乘除時，要計算兩個數字
    func useFourSymbols(symbol: String) {
        
        if unusedSymbols.count < 2 {
            
            unusedSymbols.append(symbol)
            
        }
        
        if nums.count == 2 {
            
            calculate()
            
        }
        
        tempNum = ""
        
    }

    
    //按任何按鈕會在這裡做事
    @IBAction func button(_ sender: UIButton) {
        
        clearButton.isHidden = false
        allClearButton.isHidden = true
        
        
            switch sender {
                
            case button0:
                addNumToTemp(stringNum: "0")
                
            case button1:
                addNumToTemp(stringNum: "1")
          
            case button2:
                addNumToTemp(stringNum: "2")
                
            case button3:
                addNumToTemp(stringNum: "3")
                
            case button4:
                addNumToTemp(stringNum: "4")
                
            case button5:
                addNumToTemp(stringNum: "5")
                
            case button6:
                addNumToTemp(stringNum: "6")
                
            case button7:
                addNumToTemp(stringNum: "7")
                
            case button8:
                addNumToTemp(stringNum: "8")
                
            case button9:
                addNumToTemp(stringNum: "9")
                
            case buttonDot:
                
                //當按到小數點，判斷數字字串中沒有小數點
                if !tempNum.contains(".") {
                 
                    //判斷顯示的是默認的 0 且目前暫存中沒有數字
                    if displayLabel.text == "0" && tempNum == ""{
                        
                        tempNum += "0"
                        
                    }
                        
                        tempNum += "."
                    
                        displayLabel.text! = tempNum
                 
                }
                
            //對當下的數字進行百分比
            case percentButton:
                    
                    //當數字字串有值的時候
                    if tempNum != "" {
                        
                        //先把字串浮點化除以 10 在存入數字矩陣裡
                        nums.append(Float(tempNum)! / 10)
                        
                        //顯示更新數值
                        displayLabel.text = String(nums.last!)
                        
                        //改變原本字串
                        tempNum = String(nums.last!)
                        
                        //將剛剛的數值刪除，因為還不確定要不要計算或是繼續百分比
                        nums.removeLast()
                       
                    }
                
            //代表已經完成編輯數字，將數字存進矩陣裡
            default:
                
                //判斷即將要計算的數字是否小於兩個且並非只有負號
                if nums.count < 2 && tempNum != "-" {
                    
                    if tempNum != "" {
                        
                        nums.append(Float(tempNum)!)
                        
                        print(nums)
                    }
                    
                   
                }
               
            }
        
        
            //按計算符號的按鈕
            switch sender {
                
            case divisionButton:
                
               useFourSymbols(symbol: "/")
                
            case multiButton:
                
                useFourSymbols(symbol: "*")
                
            case minusButton:
                
                useFourSymbols(symbol: "-")
                
            case plusButton:
                
                useFourSymbols(symbol: "+")
                
                
            //按等號按鈕時，除了計算之外，還要初始化
            case equalButton:
                
                if nums.count == 2 {
                    
                    calculate()
                    
                }
                
                if !allClearButton.isHidden {
                    
                    unusedSymbols.removeLast()
                    
                }
                
                tempNum = ""
                allClearButton.isHidden = false
                clearButton.isHidden = true
                
            
                
         
            case negativeButton:
                
                //這邊判斷是否正在進行運算中使用到負號
                if nums.count > 0 && tempNum != ""{
                    
                    //如果是正號，改為負號
                    if !negativeOn {
                        
                        negativeOn = true
                        
                        //判斷更改的數字是否為浮點數，然後換成負數
                        if tempNum.contains(".") {
                            
                            displayLabel.text = String((Float(tempNum) ?? 0) - 2 * (Float(tempNum) ?? 0))
                            
                        } else {
                            
                            displayLabel.text = String((Int(tempNum) ?? 0) - 2 * (Int(tempNum) ?? 0))
                            
                        }
                        
                        
                        tempNum = displayLabel.text ?? "0"
                        
                        //因為原本編輯好的數字已經被存起來，但換成負數所以要移除原本的正數，到時候會以複數取代它
                        nums.removeLast()
                        
                    } else {
                         //負號改為正號
                        negativeOn = false
                        
                        if tempNum.contains(".") {
                            
                            displayLabel.text = String((Float(tempNum) ?? 0) - 2 * (Float(tempNum) ?? 0))
                            
                        } else {
                            
                            displayLabel.text = String((Int(tempNum) ?? 0 ) - 2 * (Int(tempNum) ?? 0))
                            
                        }
                    
                        tempNum = displayLabel.text ?? "0"
                        nums.removeLast()
                        
                     }
                    
                //如果顯示只有負號
                } else if displayLabel.text == "-" {
                    
                    tempNum = ""
                    
                    displayLabel.text = "0"
                
                //如果為初始狀態
                } else {
                    
                   tempNum += "-"
                    
                    displayLabel.text = "-"
                    
                }
                
            default:
                
                tempNum += ""
                
            }
      
    }
    
    
    //刪除功能，有刪除當下數字及重新的方法
    @IBAction func clear(_ sender: UIButton) {
        
        if sender == clearButton {
            
            allClearButton.isHidden = false
            clearButton.isHidden = true
            
            unusedSymbols.append(usedSymbols.last ?? "")
            
            displayLabel.text = "0"
            tempNum = ""
            negativeOn = false
            
        } else if sender == allClearButton {
            
            displayLabel.text = "0"
            tempNum = ""
            nums = []
            unusedSymbols = []
            usedSymbols = []
            negativeOn = false
            
        }
       
    }
    

}


