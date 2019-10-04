//
//  main.swift
//  Text Adventure
//
//  Created by Ian Bailey on 9/30/19.
//  Copyright © 2019 Ian Bailey. All rights reserved.
//

import Foundation

//Persona 5 combat sim

//impliment enemy combat skill
//check rubric for completion

/*
 
 Use a for loop in your code
 Have at least one opportunity where the user will enter a number (see converting Strings to numbers)
 
 */



let speechLines: [String] = ["Persona!", "Arsene!","Come!", "Let's go."]
var itemCount = 6
var rakundaCount = 0
var joker = (hattack: 50.0, hdefense: 50.0, health: 3000.0, sp: 50.0)
var pixie = (e1attack: 60.0, e1defense: 100.0, health: 100.0)
var archAngel = (e2attack: 70.0, e2defense: 200.0, health: 200.0)
var itemHeal = Double((60...100).randomElement() ?? 1)

func items () {
    itemCount -= 1
    joker.health += itemHeal
    
}

func eiha () {
    joker.sp -= 4
    pixie.health -= 100
    archAngel.health -= 200
}


func attack () {
    pixie.health -= ((joker.hattack) * (100/(100+pixie.e1defense))).rounded()
    archAngel.health -= ((joker.hattack) * (100/(100+archAngel.e2defense))).rounded()
}

func pixieAttack () {
    joker.health -= ((pixie.e1attack) * (100/(100+joker.hdefense))).rounded()
}

func archAngelAttack () {
    joker.health -= ((archAngel.e2attack) * (100/(100+joker.hdefense))).rounded()
}

func rakunda () {
joker.sp -= 12
if pixie.e1defense > 50 && joker.sp > 10  {
    pixie.e1defense = (pixie.e1defense / 2)
    archAngel.e2defense = (archAngel.e2defense / 2)
    rakundaCount = 5
}
}

func rakundaDrop () {
    if rakundaCount <= 5 {
    rakundaCount -= 1
        if rakundaCount == 0 && pixie.e1defense <= 50 && archAngel.e2defense <= 100   {
        pixie.e1defense = (pixie.e1defense * 2)
            archAngel.e2defense = (archAngel.e2defense * 2)
        print("enemy defenses return to normal")
}
}
}

print("Welcome to the Persona 5 combat sim")

difficultySelectLoop: while pixie.health >= 0 {
    print("Choose your Difficulty: Enter 1 or 2")
    let difficulty = readLine()!
    switch difficulty{
        
    case "1":
        print("Pixie selected")
        sleep(1)
        print("Pixie draws near!")
        sleep(1)
        
         combatLoopP: while pixie.health >= 0 {
            print("Attack, Persona, Item")
            let input = readLine()?.lowercased() ?? "attack"
            switch input {
            case "attack".lowercased():
                if pixie.health > 0 {
                    attack()
                    print("Pixie has \(pixie.health)HP remaining")
                    }
            case "item".lowercased() :
                if itemCount > 0 {
                    items()
                } else {
                    print("ran out of Items")
                }
                
                
            case "persona".lowercased():
                let speech = speechLines.randomElement()
                print(speech!)
                print("Eiha(Light Damage) " + " Rakunda(Enemy Defense down)")
                let skillSelect = readLine()?.lowercased() ?? "Eiha"
                switch skillSelect {
                    
                case "eiha":
                    if joker.sp >= 4 {
                        eiha()
                        print("Pixie has \(pixie.health)HP remaining")
                    } else {
                        print("not enough sp")
                    }
                  
                case "rakunda":
                    if joker.sp >= 10 {
                        rakunda()
                        print("enemy defense fell")
                    } else {
                        print("not enough sp")
                    }
                    
                    
                    
                default:
                    print("I don't understand")
                    continue combatLoopP
                }
            default :
                print("I don't understand")
                continue combatLoopP
            }
            if joker.health > 0 {
                rakundaDrop()
                pixieAttack()
                print("Joker has \(joker.health)HP remaining")
            }
            
            if joker.health <= 0 {
                print("You fell in combat")
                exit(32)
            }
            
            if pixie.health <= 0 {
                print("You are victorious")
                sleep(1)
                endingLoop: while pixie.health <= 0 {
                print("Do you want to play again? Y/N")
                let playAgain = readLine()!.lowercased()
                switch playAgain {
                case "y":
                    joker = (hattack: 50.0, hdefense: 50.0, health: 3000.0, sp: 50.0)
                    pixie = (e1attack: 60.0, e1defense: 100.0, health: 100.0)
                    archAngel = (e2attack: 70.0, e2defense: 200.0, health: 100.0)
                    continue difficultySelectLoop
                case "n" :
                    exit(32)
                default :
                    continue endingLoop
                }
            }
        }
    }
        

        
    case "2" :
        print("ArchAngel selected")
        sleep(1)
        print("ArchAngel draws near!")
        sleep(1)
        combatLoopAA: while archAngel.health >= 0 {
                
            print("Attack, Persona, Item")
                    let input = readLine()?.lowercased() ?? "attack"
                    switch input {
                    case "attack".lowercased():
                        if archAngel.health > 0 {
                            attack()
                            print("ArchAngel has \(archAngel.health)HP remaining")
                            }
                    case "item".lowercased() :
                        if itemCount > 0 {
                            items()
                        } else {
                            print("ran out of Items")
                        }
                        
                        
                    case "persona".lowercased():
                        let speech = speechLines.randomElement()
                        print(speech!)
                        print("Eiha(Light Damage) " + " Rakunda(Enemy Defense down)")
                        let skillSelect = readLine()?.lowercased() ?? "Eiha"
                        switch skillSelect {
                            
                        case "eiha":
                            if joker.sp >= 4 {
                                eiha()
                                print("ArchAngel has \(archAngel.health)HP remaining")
                            } else {
                                print("not enough sp")
                            }
                          
                        case "rakunda":
                            if joker.sp >= 10 {
                                rakunda()
                                print("enemy defense fell")
                            } else {
                                print("not enough sp")
                            }
                            
                            
                            
                        default:
                            print("I don't understand")
                            continue combatLoopAA
                        }
                    default :
                        print("I don't understand")
                        continue combatLoopAA
                    }
                    if joker.health > 0 {
                        rakundaDrop()
                        archAngelAttack()
                        print("Joker has \(joker.health)HP remaining")
                    }
                    
                    if joker.health <= 0 {
                        print("You fell in combat")
                        exit(32)
                    }
                    
                    if archAngel.health <= 0 {
                        print("You are victorious")
                        sleep(1)
                        print("You beat the hardest difficulty!")
                endingLoop: while archAngel.health <= 0 {
                     print ("Enter your name!")
                            let name = readLine()!
                            sleep(1)
                     print("Enter your age!")
                    let age = readLine()!
                    if let ageForced = Int(age) {
                        
                            sleep(1)
                         
                            for _ in 1...3 {
                                print("Hurrah! \(name) age: \(ageForced)")
                            
                            }
                        exit(32)
                        }
                    }
                }
            }
        
            default:
            print("I don't know what you mean")
            
        }

    continue difficultySelectLoop
}






