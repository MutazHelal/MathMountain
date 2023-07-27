import Random exposing (Generator)
import List.Extra

myShapes model =   (
                   case model.state of
                     
                     Title ->
                       let
                           titleBackground =
                              let 
                                skyColour = model.skyColour
                                sky = rect 300 300 |> filled skyColour
                                mountain = 
                                  [
                                    triangle 120 |> filled (rgb 71 60 50) |> rotate (degrees 90) |> move (0,-60)
                                  , triangle 35 |> filled white |> rotate (degrees 90) |> move (0,25)
                                  ] |> group
                              in
                                [ sky
                                , mountain
                                , rect 100 15  |> filled green |> makeTransparent 0.5 |> move (0, -7)
                                , text "MATH MOUNTAIN" |> centered |> filled red |> move (0,-10) 
                                , model.skierModel |> rotate (degrees -60) |> move (30,10) 
                                ] |> group
                       in
                         [
                           titleBackground 
                         , button "Play" |> move (0,-30) |> notifyTap GoToMainMenu 
                         , button "Day" |> move (-60,20) |> notifyTap (ChangeSky Day) 
                         , button "Night" |> move (-60,50) |> notifyTap (ChangeSky Night)
                         ]
                   
                     MainMenu -> 
                       [
                         rect 200 140 |> filled (rgb 186 222 227)
                       , rect 200 20   |> filled (rgb 166 209 227) |> move (0,46)
                       , rect 200 20  |> filled (rgb 143 184 201) |> move (0,55)  
                       , text ("Select a Level") |> centered |> filled (rgb 28 2 77) |> move (0, 50)  
                       , button "Easy" |> move (-65,15) |> scale 0.95 |> notifyTap (GoToCharacterCustomization Easy)
                       , button "Medium" |> move (0,15)  |> scale 0.95 |> notifyTap (GoToCharacterCustomization Medium)
                       , button "Hard" |> move (65,15)  |> scale 0.95 |> notifyTap (GoToCharacterCustomization Hard)
                       , circle 6 |> filled (rgb 149 204 133) |> move (-62,-7) 
                       , circle 6 |> filled (rgb 247 237 183) |> move (3,-7)
                       , circle 6 |> filled (rgb 255 120 120) |> move (62,-7) 
                       , button "Tutorial" |> move (0,-35) |> scale 1.1 |> notifyTap GoToIntro
                       , backButton model 
                           |> move (-85,53) 
                           |> notifyTap GoToTitle
                       ]
                       
                     TutorialIntro ->
                       [ 
                         rect 200 140
                          |> filled (rgb 166 209 227)
                       , text "The slope-intercept form of a linear equation looks like this:"
                          |> centered
                          |> filled (rgb 28 2 77)
                          |> move (0, 80)
                          |> scale 0.65
                       ,  text "y=mx+b"
                          |> centered
                          |> filled (rgb 217 139 37)
                          |> move (0,15)
                          |> scale 1.5
                       , arrow 
                          |> move (-10,0)
                       , arrow 
                          |> rotate (degrees 90)
                          |> move (55,25) 
                       , text "Slope"
                          |> filled black
                          |> move (-23,-10)
                          |> scale 0.7
                       , text "y-intercept"
                          |> filled black
                          |> move (82,40)
                          |> scale 0.7
                       , button "Example" |> move (0,-30) |> notifyTap GoToEqnExample
                       ]
                       
                     EqnExample ->
                       [
                        rect 200 140
                          |> filled (rgb 186 211 255)
                      , drawPositiveHill model 3 2 -4
                      , grid  
                      , yAxis 6 7 58
                      , xAxis 2 4 18.5
                      , rect 7 7
                          |> filled (rgb 186 228 232)
                          |> move (-55,50)
                      , rect 60 7
                          |> filled (rgb 186 228 232)
                          |> move (46,-38.5)
                      , text "y=(3/2)x-4"
                           |> filled black
                           |> move (-140, 80)
                           |> scale 0.6
                      , arrow 
                           |> scale 0.6
                           |> move (-72,35)
                      , text "The rise is 3 and the run is 2"
                           |> filled (rgb 140 1 145)
                           |> move (-180, 60)
                           |> scale 0.5
                      , arrow 
                           |> rotate (degrees 90)
                           |> scale 0.6
                           |> move (15,-42)
                      , text "The y-intercept is (0,-4)"
                           |> filled black
                           |> move (35, -80)
                           |> scale 0.5
                      , polygon [(40,20),(60,50)]
                           |> outlined (dotted 0.7) red
                      , triangle 2
                           |> filled red
                           |> rotate (degrees 45)
                           |> move (58,46)
                      , text "Since the slope is positive,"
                           |> filled red
                           |> move (10, 120)
                           |> scale 0.4
                      , text "the hill goes up!"
                           |> filled red
                           |> move (10, 108)
                           |> scale 0.4    
                      , polygon [(40,20),(60,20)]
                           |> outlined (solid 0.7) black
                      , triangle 3 
                           |> filled black
                           |> rotate (degrees 0)
                           |> move (60,20)
                      , text "2 units right"
                           |> filled (rgb 140 1 145)
                           |> move (70, 20)
                           |> scale 0.5
                      , polygon [(60,20),(60,50)]
                           |> outlined (solid 0.7) black
                      , triangle 3 
                           |> filled black
                           |> rotate (degrees 90)
                           |> move (60,50)
                       , text "3 units up"
                           |> filled (rgb 140 1 145)
                           |> move (125, 70)
                           |> scale 0.5 
                       , button "OK" |> move (-50,10)|> scale 0.8|> notifyTap GoToInstructions
                       ]
                       
                     Instructions ->
                       [
                         rect 200 140
                            |> filled (rgb 143 184 201)             
                       , rect 200 20   
                            |> filled (rgb 166 209 227) 
                            |> move (0,57)
                       , text "How to Play"
                            |> centered
                            |> filled (rgb 28 2 77)
                            |> move (0,50) 
                       , text "There are 3 levels (Easy, Medium, and Hard) to choose from."
                            |> centered
                            |> filled black
                            |> move (0,80)
                            |> scale 0.5     
                       , text ( "To complete a level, you must earn " ++ (Debug.toString maxCoins) ++ " coins." )
                            |> centered
                            |> filled black
                            |> move (0,65)
                            |> scale 0.5  
                       , text "For each correct question, you gain a coin."
                            |> centered
                            |> filled (rgb 8 82 31)
                            |> move (0,50)
                            |> scale 0.5     
                       , text "For each wrong question, you lose a coin."
                            |> centered
                            |> filled red
                            |> move (0,35)
                            |> scale 0.5 
                       ,  circle 5
                          |> filled (rgb 222 224 139)
                          |> move (70,30)
                       , text "Although you will lose a coin, you can retry incorrect questions."
                            |> centered
                            |> filled black
                            |> move (0,10)
                            |> scale 0.5  
                       , text "After completing a level, coins reset to 0."
                            |> centered
                            |> filled black
                            |> move (0,-5)
                            |> scale 0.5  
                       , text "Good luck!"
                            |> centered
                            |> filled (rgb 28 2 77)
                            |> move (0,-25)
                            |> scale 0.7       
                       , rect 200 10   
                            |> filled (rgb 166 209 227) 
                            |> move (0,-48)
                       , text "Hint: You must first convert the 'hard' questions into slope-intercept form!"
                           |> centered
                           |> filled (rgb 83 83 89)
                           |> move (0,-100)
                           |> scale 0.5  
                
                       , button "Main Menu" |> move (0,-34) |>scale 0.9 |> notifyTap GoToMainMenu
                       ]  
                       
                     ChooseEqnEasy ->
                       [
                         background model
                       , model.hillShape |> group
                       , grid
                       , yAxis 6 7 58
                       , xAxis 2 4 18.5
                       , buttonList model |> group |> scale 0.8
                       , button "Main Menu" |> move (-60,-50) |> scale 0.9 |> notifyTap GoToMainMenu
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       , rect 90 9  |> filled (rgb 165 221 230) |> makeTransparent 0.8 |> move (-50, 52)
                       , text ("What is the y-intercept of the hill?") |> filled black |> scale 0.55 |> move (-95,50)
                       ]
                       
                     ChooseEqnMedium -> 
                       [
                         background model
                       , model.hillShape |> group
                       , grid
                       , model.trajectories |> group
                       , yAxis 6 7 58
                       , xAxis 2 4 18.5
                       , buttonList model |> group |> scale 0.8
                       , button "Main Menu" |> move (-60,-50) |> scale 0.9 |> notifyTap GoToMainMenu
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       , rect 90 9  |> filled (rgb 165 221 230) |> makeTransparent 0.8 |> move (-50, 52)
                       , text ("Which hill should the skier take?") |> filled black |> scale 0.55 |> move (-95,50)
                       ]
                       
                     ChooseEqnHard ->
                       [
                         background model
                       , model.hillShape |> group
                       , grid
                       , model.trajectories |> group
                       , yAxis 6 7 58
                       , xAxis 2 4 18.5
                       , buttonList model |> group |> scale 0.8
                       , button "Main Menu" |> move (-60,-50) |> scale 0.9 |> notifyTap GoToMainMenu
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       , rect 90 9  |> filled (rgb 165 221 230) |> makeTransparent 0.8 |> move (-50, 52)
                       , text ("Which hill should the skier take?") |> filled black |> scale 0.55 |> move (-95,50)
                       ]
                       
                     CorrectEasy ->
                       [
                         background model
                       , chooseEqnHill model |> group
                       , button "Keep skiing" |> notifyTap NextLevel  -- go to new ChooseEquation state 
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 50 13  |> filled (rgb 165 221 230) |> makeTransparent 0.9 |> move (0, 23)
                       , text ("Correct!") |> filled black  |> move (-20,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     CorrectMedium -> 
                       [
                         background model
                       , chooseEqnHill model |> group
                       , button "Keep skiing" |> notifyTap NextLevel  -- go to new ChooseEquation state 
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 50 13  |> filled (rgb 165 221 230) |> makeTransparent 0.9 |> move (0, 23)
                       , text ("Correct!") |> filled black  |> move (-20,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50) 
                       ]
                       
                     CorrectHard ->
                       [
                         background model
                       , chooseEqnHill model |> group
                       , button "Keep skiing" |> notifyTap NextLevel  -- go to new ChooseEquation state 
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 50 13  |> filled (rgb 165 221 230) |> makeTransparent 0.9 |> move (0, 23)
                       , text ("Correct!") |> filled black  |> move (-20,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     IncorrectEasy ->
                       [
                         background model
                       , button "Retry" |> notifyTap RetryLevel  -- return to previous ChooseEquation state
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 60 15  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (2, 23)
                       , text ("Incorrect :(") |> filled black  |> move (-25,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     IncorrectMedium -> 
                       [ 
                         background model
                       , button "Retry" |> notifyTap RetryLevel  -- return to previous ChooseEquation state
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 60 15  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (2, 23)
                       , text ("Incorrect :(") |> filled black  |> move (-25,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     IncorrectHard ->
                       [
                         background model
                       , button "Retry" |> notifyTap RetryLevel  -- return to previous ChooseEquation state
                       , button "Main Menu" |> move (-60,-50) |> notifyTap GoToMainMenu
                       , rect 60 15  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (2, 23)
                       , text ("Incorrect :(") |> filled black  |> move (-25,20)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     LevelComplete ->
                       [ rect 200 140 |> filled (rgb 165 221 230) |> makeTransparent 0.6
                       , button "Main Menu" |> move (0,0) |> notifyTap GoToMainMenu
                       , text ("Congratulations!") |> centered |> filled black |> move (0,30)
                       , text ("You beat the level!") |> centered |> filled black |> move (0,15)
                       , rect 30 10  |> filled (rgb 165 221 230) |> makeTransparent 0.5 |> move (64, 53)
                       , text ("Coins: " ++ (Debug.toString model.coins)) |> filled black |> scale 0.7 |> move (50,50)
                       ]
                       
                     CharacterCustomization difficulty ->
                       [ rect 200 140 |> filled (rgb 186 222 227)
                       , rect 200 20   |> filled (rgb 166 209 227) |> move (0,46)
                       , rect 200 20  |> filled (rgb 143 184 201) |> move (0,55)  
                       , text ("Customize Your Skier") |> centered |> filled (rgb 28 2 77) |> move (0, 50)
                       , backButton model 
                           |> move (-85,53) 
                           |> notifyTap GoToMainMenu
                       , button "Start Skiing!" 
                           |> move (0,-50) 
                           |> notifyTap ( case difficulty of
                                            Easy -> EasyGame
                                            Medium -> MediumGame
                                            Hard -> HardGame ) 
                       , model.skierModel |> move (0,-10) |> scale 1.6
                       , colourButtons |> scale 0.8 |> move (-63,0)
                       , cap |> move (50,0) |> notifyTap (ChangeSkierHat Cap)
                       , none  |> move (50,20) |> notifyTap (ChangeSkierHat None)
                       , crown |> move (50,-15) |> notifyTap (ChangeSkierHat Crown)
                       ]
                     )
                      -- ++
                      -- [ text (Debug.toString model.choices) |> filled black |> scale 0.2 |> move (-95,50) 
                     -- , text ("level: " ++ Debug.toString model.level) |> filled black |> scale 0.2 |> move (-95,45) 
                     -- , text ("numberOfLevels: " ++ Debug.toString numberOfLevels) |> filled black |> scale 0.2 |> move (-95,40) 
                     -- [
                      -- text ("state: " ++ Debug.toString model.state) |> filled black |> scale 0.2 |> move (-95,40)
                      -- ]
                     
---------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------

grid = graphPaperCustom 10 0.05 (rgb 121 125 133)

maxCoins = 5

background model = rect 200 140 |> filled model.skyColour 

none =
    [
      circle 40 |> filled blank  -- for user interaction
    , circle 40 |> outlined (solid 7) red 
    , rectangle 80 7 |> filled red |> rotate (degrees -45)
    ] |> group |> scale 0.17

cap = 
    [
      curve (0,0) [Pull (35,80) (70,0) ]
        |> filled black
        |> move (-35,0)
    , roundedRect 100 8 4 
        |> filled red
        |> move (14.9,0)
    ] |> group |> scale 0.2
    
crown =
    let 
      crownColour = yellow
      point = 
        [ 
          rectangle 6 8 |> filled crownColour
        , triangle 6 |> filled crownColour |> rotate (degrees 90) |> move (0,5)
        , circle 2 |> filled yellow |> move (0,9)
        ] |> group
      jewel colour = 
          [
            ngon 8 5 |> filled grey
          , ngon 8 4 |> filled colour
          ] |> group
    in
      [
         roundedRect 40 15 4 |> filled crownColour
       , point |> move (-17,7.5)
       , point |> move (-5.7,7.5)
       , point |> move (5.7,7.5)
       , point |> move (17,7.5)
       , jewel green 
       , jewel red |> scale 0.6 |> move (-12,0)
       , jewel red |> scale 0.6 |> move (12,0)
      ] |> group |> scale 0.4

colourButtons =
    let
      gap = 23
      circleButton colour = circle 10 |> filled colour 
    in
      [
        circleButton red |> move (-gap,gap) |> notifyTap (ChangeSkierColour Red)
      , circleButton blue |> move (0,gap) |> notifyTap (ChangeSkierColour Blue)
      , circleButton yellow |> move (gap,gap) |> notifyTap (ChangeSkierColour Yellow)  
      , circleButton green |> move (-gap,0) |> notifyTap (ChangeSkierColour Green)
      , circleButton orange |> move (0,0) |> notifyTap (ChangeSkierColour Orange) 
      , circleButton purple |> move (gap,0) |> notifyTap (ChangeSkierColour Purple)
      , circleButton brown |> move (-gap,-gap) |> notifyTap (ChangeSkierColour Brown)
      , circleButton pink |> move (0,-gap) |> notifyTap (ChangeSkierColour Pink)
      , circleButton black |> move (gap,-gap) |> notifyTap (ChangeSkierColour Black)
      ] |> group

backButton model =
    let 
      arrowColour = black
      backArrow = 
           [
             roundedRect 20 3 2 |> filled arrowColour
           , arrowHead |> move (-10,0)
           ] |> group
      arrowHead = 
          [ 
            roundedRect 15 3 2 
              |> filled arrowColour
              |> move (7,0)
              |> rotate (degrees 45)
          , roundedRect 15 3 2 
              |> filled arrowColour
              |> move (-7,0)
              |> rotate (degrees -45)
          ] |> group |> rotate (degrees -90)
    in
    [
      circle 30 |> filled blank  -- in case clicks on the button cant be registered
    , circle 30 |> outlined (solid 2) arrowColour
    , backArrow |> scale 1.7
    ] |> group 
      |> scale 0.2 
      |> scale model.enlargeButton
      |> notifyEnter (ButtonHoverEffect Enlarge)
      |> notifyLeave (ButtonHoverEffect DefaultSize)
      
arrow = group [                 
         triangle 5
          |> filled (rgb 3 111 156)
          |> rotate (degrees -30)
          |> move (4, 15)
       , rect 3 12
          |> filled (rgb 3 111 156)
          |> move (4, 7.5)
      ]

tree = group [
              rect 4.5 15
                |> filled (rgb 120 84 22)
                |> move (0, 7.5)
              , triangle 12
                |> filled (rgb 55 138 30)
                |> rotate (degrees -30)
                |> move (0, 12.5)
              , triangle 12
                |> filled (rgb 55 138 30)
                |> rotate (degrees -30)
                |> move (0, 21.5) 
              ]

customSkier : SkierColour -> SkierHat -> Shape Msg
customSkier colour hat =
    (
    case colour of 
      Red -> skier (rgb 224 25 11) (rgb 145 15 6)
      Blue -> skier (rgb 12 12 194) (rgb 81 153 224)
      Yellow -> skier (rgb 250 250 95) (rgb 214 196 34)
      Green -> skier (rgb 84 235 70) (rgb 34 148 24)
      Orange -> skier (rgb 230 125 50) (rgb 176 95 37)
      Purple -> skier (rgb 215 95 245) (rgb 124 46 143)
      Brown -> skier (rgb 176 109 19) (rgb 222 139 27)
      Black -> skier (rgb 26 23 21) (rgb 82 78 75)
      Pink -> skier (rgb 240 151 231) (rgb 184 118 177)
    )
    (
    case hat of 
      None -> group [] 
      Cap -> cap
      Crown -> crown
    )

skier body chest hat =  group [
                 roundedRect 20 2 3
                  |> filled blue        
                 ,roundedRect 2 5 2
                  |> filled blue  
                  |> move (9, 2)              
                 , roundedRect 4 13 3
                  |> filled chest 
                  |> move (-7, 13) 
                  |> rotate (degrees -10)   
                 , roundedRect 4 10 3
                  |> filled body
                  |> move (0, 6)
                , roundedRect 10 4 3
                  |> filled body
                  |> move (-3, 9)   
                , roundedRect 4 13 3
                  |> filled body
                  |> move (-9, 13) 
                  |> rotate (degrees -10)        
                , rect 15 2
                  |> filled (rgb 158 155 153)
                  |> move (-7, 15) 
               , triangle 2
                  |> filled (rgb 135 133 131)
                  |> rotate (degrees 180)
                  |> move (-15.5, 15) 
                , roundedRect 8 3 2
                  |> filled body
                  |> move (3, 15)    
                , roundedRect 4 10 3
                  |> filled body
                  |> rotate (degrees 55)
                  |> move (-3, 18) 
                , circle 3  -- head
                  |> filled body
                  |> move (-3, 25) 
                , hat |> scale 0.45 |> rotate (degrees 10) |> move (-3.5,27) 
              ]
              
-- TO DO: CHANGE VARIABLE NAMES - more descriptive 
yAxis start cycles yValue = 
            if cycles == 0 then (
             group 
               [
               polygon [(0,0),(0,130)]
                  |> outlined (solid 1) black
                  |> move (0, -65)
             ] ) else (
                  group
                  [
                  text (Debug.toString start)
                      |> size 6
                      |> filled black
                      |> move (-7,yValue)
                  , polygon [(0,0),(3,0)]
                      |> outlined (solid 0.6) black
                      |> move (-1.5, yValue+2)
                  , yAxis (start-2) (cycles-1) (yValue-20)
                  ]
                  )

xAxis start cycles xValue = 
            if cycles == 0 then (
             group 
             [
             polygon [(0,0),(140,0)]
                  |> outlined (solid 1) black   
             ] ) else (
            group
            [
            text (Debug.toString start)
                |> size 6
                |> filled black
                |> move (xValue,-7)
            , polygon [(0,0),(0,3)]
                |> outlined (solid 0.6) black
                |> move (xValue+1.5, -1.5)
            , xAxis (start+2) (cycles-1) (xValue+20)
            ]
            )

button : String -> Shape Msg
button name  = group [ 
                         roundedRect 50 15 5 
                          |> filled (rgb 117 177 186) 
                        , roundedRect 45 13 5 
                          |> filled (rgb 145 194 201)
                        , text name 
                          |> centered  
                          |> size 6
                          |> filled black
                          |> move (0,-2)
                      ]

-- Linear equation parser for each game difficulty
buttonList : Model -> List (Shape Msg)                         
buttonList model = 
                   let
                     slopeToText : Bool -> Int -> Int -> String
                     slopeToText negSlope rise run = 
                         if rise == 0 then "" 
                         else
                         if rise == run 
                         then ( if negSlope then "-" else "" ) ++ "x" 
                         else 
                           ( if negSlope then "-" else "" )
                           ++
                           "(" ++ ( String.fromInt rise ) ++ "/" ++ ( String.fromInt run ) ++ ")" ++ "x" 
                           
                     eqnToText : LinearEqn -> Int -> String
                     eqnToText linEqn coeff =
                         case model.state of
                           ChooseEqnEasy -> ( String.fromInt linEqn.bValue )

                           ChooseEqnMedium ->
                               "y = " 
                               ++
                               (slopeToText linEqn.negativeSlope linEqn.rise linEqn.run)
                               ++
                               ( if linEqn.bValue < 0 
                                 then String.fromInt (linEqn.bValue)
                                 else if linEqn.rise == 0 then (String.fromInt linEqn.bValue)
                                 else if linEqn.bValue == 0 then "" 
                                 else "+" ++ (String.fromInt linEqn.bValue) ) 
                             
                           ChooseEqnHard ->
                             ( if coeff == 1 
                               then "y"
                               else if coeff == -1
                               then "-y"
                               else (String.fromInt coeff) ++ "y" ) 
                             ++
                             ( 
                               if (coeff * linEqn.rise == 0) then "" else
                               if linEqn.negativeSlope 
                               then ( 
                                     if coeff < 0
                                     then ( "-" ++ (slopeToText False (coeff * linEqn.rise |> Basics.abs) linEqn.run) )
                                     else ( "+" ++ (slopeToText False (coeff * linEqn.rise |> Basics.abs) linEqn.run) ) 
                                    )
                               else (
                                     ( 
                                     if coeff < 0
                                     then ( "+" ++ (slopeToText False (coeff * linEqn.rise |> Basics.abs) linEqn.run) )
                                     else ( "-" ++ (slopeToText False (coeff * linEqn.rise |> Basics.abs) linEqn.run) )
                                     )
                                    )
                             )
                             ++
                             ( "= " ) ++ ( String.fromInt (coeff * linEqn.bValue) ) 
                             
                           _ -> ""
                     
                     buttonLocations : List (Shape Msg -> Shape Msg)
                     buttonLocations = [move (-90,40), move (-90,10), move (-90,-20)]
                     
                     buttonCorrectness : List (Shape Msg -> Shape Msg)
                     buttonCorrectness = List.map 
                                         ( \eqn -> if eqn.isCorrect 
                                                   then notifyTap CorrectEqn 
                                                   else notifyTap IncorrectEqn )
                                         model.choices
                     
                     listWithoutNotifyTap : List (Shape Msg)
                     listWithoutNotifyTap =
                         List.Extra.andMap
                         ( List.map2 ( \linEqn coeff -> eqnToText linEqn coeff) model.choices model.standardCoeff
                             |> List.map button )
                         buttonLocations
                   in
                     List.Extra.andMap listWithoutNotifyTap buttonCorrectness


randIdx : Model -> List a -> Int
randIdx model randList = ( ( List.length randList ) - 1 |> Basics.toFloat ) * ( sin model.time ) |> Basics.abs |> Basics.round

randIdx2 : Model -> List a -> Int
randIdx2 model randList = ( ( List.length randList ) - 1 |> Basics.toFloat ) * ( sin (model.time * 2)) |> Basics.abs |> Basics.round

randIdx3 : Model -> List a -> Int
randIdx3 model randList = ( ( List.length randList ) - 1 |> Basics.toFloat ) * ( (sin (model.time * 3)) ) |> Basics.abs |> Basics.round


createLinEqn : Int -> Int -> Int -> Bool -> Bool -> LinearEqn
createLinEqn rise run bValue slopeSign isCorrect = 
    { rise = rise
    , run = run
    , bValue = bValue
    , negativeSlope = slopeSign
    , isCorrect = isCorrect
    }

-- Randomly picks from list, instead of cycling through it
randLinEqnTriple : Model -> List LinearEqn
randLinEqnTriple model = 
    let 
      getTriple : List (List a) -> List a
      getTriple list = List.Extra.getAt (randIdx model list) list |> Maybe.withDefault [] 
    in
      List.map5 createLinEqn 
      ( getTriple randRise ) 
      ( getTriple randRun ) 
      ( getTriple bValueNoRepeat )
      ( getTriple randSign )
      ( getTriple randCorrect )

base model bValue skierVisibility = group 
                  [
                    rect 100 140
                        |> filled white  
                        |> move (-50,-70 + (bValue*10) )     
                  , tree
                       |> move (-47, (bValue*10))
                       |> makeTransparent skierVisibility       
                   , model.skierModel
                       |> move (-20, (bValue*10))
                       |> makeTransparent skierVisibility                    
                  ]

drawNegativeHill model rise run bValue skierVisibility = group 
                             [
                             rect 100 140
                                  |> filled white
                                  |> move (50,-70 - (rise*(10/run)*10) + (bValue * 10))
                             ,  polygon [(0,0),(0,rise*10), (run*10,0)]
                                  |> filled white
                                  |> scale (10/run)
                                  |> move (0, -((10/run)*rise*10) + (bValue * 10))
                             , base model bValue skierVisibility
                             , displayCoin model rise run bValue True 0
                             
                             ]

drawPositiveHill model rise run bValue = group 
                             [
                             polygon [(0,0),(run*10,0), (run*10,rise*10)]
                                  |> filled white
                                  |> scale (10/run)
                                  |> move (0, bValue * 10)
                             , rect 100 140
                                  |> filled white  
                                  |> move (50,-70 + (bValue*10))
                             , base model bValue 1
                             , displayCoin model rise run bValue False 0
                             ]
                             
chooseEqnHill : Model -> List (Shape Msg)
chooseEqnHill model = 
    let
      hillToDraw : LinearEqn
      hillToDraw = List.filter (\eqn -> eqn.isCorrect) model.choices 
                     |> List.head 
                     |> Maybe.withDefault {rise = 0, run = 1, bValue = 0, negativeSlope = False, isCorrect = False} -- fromJust
      
      eqnRise = hillToDraw.rise |> Basics.toFloat 
      eqnRun = hillToDraw.run |> Basics.toFloat
      eqnBValue = hillToDraw.bValue |> Basics.toFloat               
    in
      case model.state of 
        ChooseEqnEasy ->
            case hillToDraw.negativeSlope of
              True -> [drawNegativeHill model eqnRise eqnRun eqnBValue 1]
              False -> [drawPositiveHill model eqnRise eqnRun eqnBValue]
        ChooseEqnMedium ->
            case hillToDraw.negativeSlope of
              True -> [drawNegativeHill model eqnRise eqnRun eqnBValue 1]
              False -> [drawPositiveHill model eqnRise eqnRun eqnBValue]
        ChooseEqnHard ->  
            case hillToDraw.negativeSlope of
              True -> [drawNegativeHill model eqnRise eqnRun eqnBValue 1]
              False -> [drawPositiveHill model eqnRise eqnRun eqnBValue]
        CorrectEasy -> 
            [drawFullHill model eqnRise eqnRun eqnBValue hillToDraw.negativeSlope]
        CorrectMedium -> 
            [drawFullHill model eqnRise eqnRun eqnBValue hillToDraw.negativeSlope]
        CorrectHard -> 
            [drawFullHill model eqnRise eqnRun eqnBValue hillToDraw.negativeSlope]
        _ -> []

chooseEqnTrajectories : Model -> List (Shape Msg)
chooseEqnTrajectories model = 
    let
      -- Simpler way to do this in elm? Just trying to make rise negative if isNegative is True
      drawLineGraph rise run bValue colour isNegative = 
                       if isNegative == True then (
                       group 
                       [
                       polygon [(0,0),(run*10 * (10/run),(-rise)*10 * (10/run))]
                          |> outlined (dashed 0.6) colour
                          |> move (0, bValue*10)
                        ] ) else (
                       group
                       [
                       polygon [(0,0),(run*10 * (10/run), rise*10 * (10/run))]
                          |> outlined (dashed 0.6) colour
                          |> move (0, bValue*10)
                       ]
                       )
      
      -- Gets correct equation trajectory to be drawn, instead of all three
      correctTraj = List.filter (\eqn -> eqn.isCorrect == True) model.choices
    in 
      List.map5
      drawLineGraph
      (List.map (\eqn -> eqn.rise) correctTraj |> List.map Basics.toFloat)
      (List.map (\eqn -> eqn.run) correctTraj |> List.map Basics.toFloat)
      (List.map (\eqn -> eqn.bValue) correctTraj |> List.map Basics.toFloat)
      [red]
      (List.map (\eqn -> eqn.negativeSlope) correctTraj) 

displayCoin model rise run bValue isNegative skierVisibility = 
                 if isNegative == True then (
                               let y = ((-rise*10)/(run*10))*80 + (bValue*10)
                                   x = ((-50 - (bValue*10)) * (run*10))/(-rise*10)
                               in 
                               if y >= -50 then (
                               group [
                               circle 5
                                |> filled yellow
                                |> move (80, y)
                               , model.skierModel 
                               |> rotate -(atan2 (rise*10) (run*10))
                                 |> move (80, y)
                                 |> makeTransparent skierVisibility
                               ]
                               )
                               else (
                               group [
                               circle 5
                                |> filled yellow
                                |> move (x, -50)
                               , model.skierModel 
                                 |> rotate -(atan2 (rise*10) (run*10))
                                 |> move (x, -50)
                                 |> makeTransparent skierVisibility
                                
                                
                               ]
                              )  ) else (
                              
                               let y = ((rise*10)/(run*10))* (80) + (bValue*10)
                                   x = ((50 - (bValue*10)) * (run*10))/(rise*10)
                               in 
                               if y <= 50 then (
                               group [
                               circle 5
                                |> filled yellow
                                |> move (80, y)
                               , model.skierModel 
                               |> rotate (atan2 (rise*10) (run*10))
                                 |> move (80, y)
                                 |> makeTransparent skierVisibility
                               ]
                               )
                               else (
                               group [
                               circle 5
                                |> filled yellow
                                |> move (x, 50)
                              , model.skierModel
                              |> rotate (atan2 (rise*10) (run*10))
                                 |> move (x, 50)
                                 |> makeTransparent skierVisibility
                               ]
                              ) 
                                   ) 

drawFullHill model rise run bValue isNegative = 
                 if isNegative == True then (
                group [
                polygon [(0,bValue*10), (-100,bValue*10), (-100, (bValue*10) + ( (100/(run*10)) * (rise*10) )  )]
                   |> filled white
                , drawNegativeHill model rise run bValue 0
                , tree  
                  |> rotate -(atan2 (rise*10) (run*10))
                  |> move (0, (bValue*10))
                ,  tree  
                  |> rotate -(atan2 (rise*10) (run*10))
                  |> move (40, ((-rise*10)/(run*10))*40 + (bValue*10))
                ,  tree  
                  |> rotate -(atan2 (rise*10) (run*10))
                  |> move (-40, ((-rise*10)/(run*10))*(-40) + (bValue*10))
                ,  tree  
                  |> rotate -(atan2 (rise*10) (run*10))
                  |> move (80, ((-rise*10)/(run*10))*80 + (bValue*10))
                ,  tree  
                  |> rotate -(atan2 (rise*10) (run*10))
                  |> move (-80, ((-rise*10)/(run*10))*(-80) + (bValue*10))  
                  
                  
                , displayCoin model rise run bValue isNegative 1
                ]) else 
                ( group [
                
                polygon [(0,bValue*10), (-100, (bValue*10) -  ((100/(run*10)) * (rise*10))), (0, (bValue*10) -  ((100/(run*10)) * (rise*10)))]
                  |> filled white
               ,  rect 100 140
                  |> filled white  
                  |> move (-50,-70 + ((bValue*10) -  ((100/(run*10)) * (rise*10)))) 
               ,  polygon [(0,0),(run*10,0), (run*10,rise*10)]
                  |> filled white
                  |> scale (10/run)
                  |> move (0, bValue * 10)
               , rect 100 140
                  |> filled white  
                  |> move (50,-70 + (bValue*10)) 
               , tree 
                  |> rotate (atan2 (rise*10) (run*10))
                  |> move (0, (bValue*10))
               , tree  
                  |> rotate (atan2 (rise*10) (run*10))
                  |> move (40, ((rise*10)/(run*10))*40 + (bValue*10))
               , tree  
                  |> rotate (atan2 (rise*10) (run*10))
                  |> move (-40, ((rise*10)/(run*10))*(-40) + (bValue*10))
                  
               , tree  
                  |> rotate (atan2 (rise*10) (run*10))
                  |> move (80, ((rise*10)/(run*10))*80 + (bValue*10))
               , tree  
                  |> rotate (atan2 (rise*10) (run*10))
                  |> move (-80, ((rise*10)/(run*10))*(-80) + (bValue*10))     
                  
               , displayCoin model rise run bValue isNegative 1
                
                ] )
                  
update msg model = case msg of
                     Tick t _ -> { model | time = t
                                         , hillShape = chooseEqnHill model
                                         , trajectories = chooseEqnTrajectories model
                                         , skierModel = customSkier model.skierColour model.skierHat
                                 }
                     
                     GoToTitle ->
                       case model.state of
                         MainMenu ->
                           { model | state = Title, enlargeButton = 1 }
                         otherwise ->
                           model
                         
                     GoToMainMenu ->
                        case model.state of
                          Title ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          ChooseEqnEasy ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          CorrectEasy ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          IncorrectEasy ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          ChooseEqnMedium ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          CorrectMedium ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          IncorrectMedium ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          ChooseEqnHard ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          CorrectHard ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          IncorrectHard ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          LevelComplete ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          Instructions ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          CharacterCustomization difficulty ->
                            { model | state = MainMenu, enlargeButton = 1 }
                          otherwise ->
                            model
                            
                     GoToCharacterCustomization difficulty ->
                         { model | state = CharacterCustomization difficulty }
                     
                     EasyGame ->
                        case model.state of
                          CharacterCustomization Easy ->
                            { model | state = ChooseEqnEasy
                                    , coins = 0
                                    , choices = randLinEqnTriple model
                             }
                          otherwise ->
                            model
                     
                     MediumGame ->
                        case model.state of
                          CharacterCustomization Medium ->
                            { model | state = ChooseEqnMedium
                                    , coins = 0
                                    , choices = randLinEqnTriple model
                             }
                          otherwise ->
                            model
                            
                     HardGame ->  
                        case model.state of
                          CharacterCustomization Hard ->
                            { model | state = ChooseEqnHard
                                    , coins = 0
                                    , choices = randLinEqnTriple model
                                    , standardCoeff = 
                                          let
                                            listOfCoeff : List Int
                                            listOfCoeff = List.append (List.range (-10) (-1)) (List.range 1 10)                                            
                                          in
                                            [
                                              List.Extra.getAt ( randIdx model listOfCoeff ) listOfCoeff 
                                            , List.Extra.getAt ( randIdx2 model listOfCoeff ) listOfCoeff
                                            , List.Extra.getAt ( randIdx3 model listOfCoeff ) listOfCoeff 
                                            ] |> List.map ( Maybe.withDefault 0 )
                             }  
                          otherwise ->
                            model
                            
                     CorrectEqn ->
                        case model.state of
                          ChooseEqnEasy ->
                            { model | state = CorrectEasy
                                    , coins = model.coins + 1
                            }
                          ChooseEqnMedium ->
                            { model | state = CorrectMedium
                                    , coins = model.coins + 1
                            }
                          ChooseEqnHard ->
                            { model | state = CorrectHard
                                    , coins = model.coins + 1
                            }
                          otherwise ->
                            model
                            
                     IncorrectEqn ->
                        case model.state of
                          ChooseEqnEasy  ->
                            { model | state = IncorrectEasy }
                          ChooseEqnMedium  ->
                            { model | state = IncorrectMedium }
                          ChooseEqnHard  ->
                            { model | state = IncorrectHard }
                          otherwise ->
                            model
                            
                     NextLevel -> 
                        case model.state of
                          CorrectEasy ->
                            { model | state = if model.coins >= maxCoins then LevelComplete else ChooseEqnEasy
                                    , choices = randLinEqnTriple model
                            }  
                          CorrectMedium  ->
                            { model | state = if model.coins >= maxCoins then LevelComplete else ChooseEqnMedium
                                    , choices = randLinEqnTriple model
                            }  
                          CorrectHard  ->
                            { model | state = if model.coins >= maxCoins then LevelComplete else ChooseEqnHard
                                    , choices = randLinEqnTriple model
                                    , standardCoeff = 
                                          let
                                            listOfCoeff : List Int
                                            listOfCoeff = List.append (List.range (-10) (-1)) (List.range 1 10)                                            
                                          in
                                            [
                                              List.Extra.getAt ( randIdx model listOfCoeff ) listOfCoeff 
                                            , List.Extra.getAt ( randIdx2 model listOfCoeff ) listOfCoeff
                                            , List.Extra.getAt ( randIdx model listOfCoeff ) listOfCoeff 
                                            ] |> List.map ( Maybe.withDefault 0 ) 
                            }  
                          otherwise ->
                            model
                            
                     RetryLevel ->
                       case model.state of
                          IncorrectEasy ->
                            { model | state = ChooseEqnEasy
                                    , coins = if model.coins > 0
                                              then model.coins - 1
                                              else 0
                            }  
                          IncorrectMedium ->
                            { model | state = ChooseEqnMedium
                                    , coins = if model.coins > 0
                                              then model.coins - 1
                                              else 0
                            }  
                          IncorrectHard ->
                            { model | state = ChooseEqnHard
                                    , coins = if model.coins > 0
                                              then model.coins - 1
                                              else 0
                            }  
                          otherwise ->
                            model

                     GoToIntro ->
                        case model.state of
                          MainMenu ->
                            { model | state = TutorialIntro }
                          otherwise ->
                            model 
                            
                     GoToEqnExample ->
                        case model.state of
                          TutorialIntro ->
                            { model | state = EqnExample }
                          otherwise ->
                            model       
                            
                     GoToInstructions ->
                        case model.state of
                          EqnExample ->
                            { model | state = Instructions }
                          otherwise ->
                            model
                     
                     ButtonHoverEffect buttonType ->
                         case buttonType of 
                           ChangeColour -> model 
                           DefaultColour -> model
                           Enlarge ->
                             { model | enlargeButton = 1.2 }
                           DefaultSize -> 
                             { model | enlargeButton = 1 }
                             
                     ChangeSkierColour colour ->
                         { model | skierColour = colour }
                     
                     ChangeSkierHat hat ->
                         { model | skierHat = hat } 
                     
                     ChangeSky timeOfDay ->
                         { model | skyColour =
                                     case timeOfDay of
                                       Day -> (rgb 182 202 242) 
                                       Night -> (rgb 56 83 138) }
                                       
                           
                     
                     
                         
init = { time = 0 
       , state = Title
       , choices = []
       , hillShape = []
       , trajectories = []
       , coins = 0
       , standardCoeff = [0,0,0] 
       , enlargeButton = 1
       , skierModel = customSkier Orange None
       , skierColour = Orange
       , skierHat = None
       , skyColour = (rgb 182 202 242)
       }
       
---------------------------------------------------------------------
-- TYPES
---------------------------------------------------------------------

type State = 
      Title
    | MainMenu    
    | TutorialIntro
    | EqnExample
    | Instructions
    | CharacterCustomization Difficulty 
    | ChooseEqnEasy
    | CorrectEasy
    | IncorrectEasy
    | ChooseEqnMedium
    | CorrectMedium
    | IncorrectMedium
    | ChooseEqnHard
    | CorrectHard
    | IncorrectHard
    | LevelComplete

type Difficulty = Easy | Medium | Hard

type ButtonEffect = ChangeColour | DefaultColour | Enlarge | DefaultSize

type SkierColour = Blue | Red | Yellow | Green | Orange | Purple | Brown | Black | Pink

type SkierHat = None | Cap | Crown

type TimeOfDay = Day | Night

type Msg = Tick Float GetKeyState
         | GoToMainMenu
         | GoToTitle
         | GoToCharacterCustomization Difficulty  
         | GoToEqnExample
         | GoToInstructions
         | GoToIntro
         | EasyGame
         | MediumGame
         | HardGame
         | CorrectEqn
         | IncorrectEqn
         | NextLevel
         | RetryLevel
         | ButtonHoverEffect ButtonEffect
         | ChangeSkierColour SkierColour
         | ChangeSkierHat SkierHat
         | ChangeSky TimeOfDay

type alias Model =
    { time : Float
    , state : State 
    , choices : List LinearEqn
    , hillShape : List (Shape Msg)
    , trajectories : List (Shape Msg)
    , coins : Int
    , standardCoeff : List Int
    , enlargeButton : Float
    , skierModel : Shape Msg
    , skierColour : SkierColour
    , skierHat : SkierHat
    , skyColour : Color
    } 
    
type alias LinearEqn = 
    { rise : Int
    , run : Int
    , bValue : Int
    , negativeSlope : Bool
    , isCorrect : Bool
    }

---------------------------------------------------------------------
-- RANDOMIZED DATA FOR MULTIPLE CHOICE
---------------------------------------------------------------------
bValueNoRepeat = 
    [
    [-3, -2, -1] ,
    [-3, -2, 0] ,
    [-3, -2, 1] ,
    [-3, -2, 2] ,
    [-3, -2, 3] ,
    [-3, -1, 0] ,
    [-3, -1, 1] ,
    [-3, -1, 2] ,
    [-3, -1, 3] ,
    [-3, 0, 1] ,
    [-3, 0, 2] ,
    [-3, 0, 3] ,
    [-3, 1, 2] ,
    [-3, 1, 3] ,
    [-3, 2, 3] ,
    [-2, -1, 0] ,
    [-2, -1, 1] ,
    [-2, -1, 2] ,
    [-2, -1, 3] ,
    [-2, 0, 1] ,
    [-2, 0, 2] ,
    [-2, 0, 3] ,
    [-2, 1, 2] ,
    [-2, 1, 3] ,
    [-2, 2, 3] ,
    [-1, 0, 1] ,
    [-1, 0, 2] ,
    [-1, 0, 3] ,
    [-1, 1, 2] ,
    [-1, 1, 3] ,
    [-1, 2, 3] ,
    [0, 1, 2] ,
    [0, 1, 3] ,
    [0, 2, 3] ,
    [1, 2, 3]
    ]
    
randRise = 
  [
  [0, 0, 0] ,
  [3, 0, 1] ,
  [3, 3, 1] ,
  [0, 3, 1] ,
  [2, 1, 0] ,
  [2, 1, 3] ,
  [1, 0, 2] ,
  [3, 2, 0] ,
  [2, 2, 2] ,
  [1, 1, 1] ,
  [1, 3, 0] ,
  [2, 3, 3] ,
  [2, 0, 2] ,
  [3, 2, 3] ,
  [3, 1, 1] ,
  [0, 1, 0] ,
  [2, 2, 3] ,
  [2, 0, 0] ,
  [3, 0, 0] ,
  [0, 3, 3] ,
  [3, 2, 1] ,
  [1, 3, 1] ,
  [1, 1, 0] ,
  [0, 1, 2] ,
  [1, 1, 2] ,
  [1, 3, 1] ,
  [2, 0, 0] ,
  [0, 0, 2] ,
  [1, 1, 1] ,
  [1, 3, 0] ,
  [0, 0, 3] ,
  [0, 3, 1] ,
  [1, 0, 3] ,
  [1, 3, 3] ,
  [1, 3, 0] ,
  [1, 2, 3] ,
  [1, 1, 2] ,
  [0, 2, 2] ,
  [1, 3, 3] ,
  [0, 1, 2] ,
  [1, 3, 1] ,
  [2, 1, 1] ,
  [2, 1, 2] ,
  [3, 2, 3] ,
  [3, 2, 2] ,
  [2, 3, 1] ,
  [3, 3, 3] ,
  [3, 1, 3] ,
  [0, 2, 1] ,
  [1, 0, 3] ,
  [3, 1, 2] ,
  [3, 2, 3] ,
  [3, 3, 2] ,
  [2, 1, 0] ,
  [1, 3, 2] ,
  [3, 0, 3] ,
  [2, 2, 2] ,
  [1, 3, 2] ,
  [3, 2, 0] ,
  [1, 3, 0] ,
  [2, 0, 2] ,
  [2, 2, 2] ,
  [0, 0, 0] ,
  [0, 2, 1] ,
  [2, 2, 1] ,
  [2, 0, 1] ,
  [2, 2, 0] ,
  [0, 0, 0] ,
  [3, 3, 2] ,
  [1, 2, 2] ,
  [1, 3, 2] ,
  [1, 2, 3] ,
  [1, 1, 2] ,
  [2, 2, 3] ,
  [3, 0, 1] ,
  [2, 2, 3] ,
  [1, 3, 3] ,
  [1, 3, 3] ,
  [3, 2, 2] ,
  [0, 0, 1] ,
  [3, 0, 1] ,
  [0, 1, 3] ,
  [3, 0, 0] ,
  [1, 0, 0] ,
  [0, 3, 3] ,
  [0, 1, 1] ,
  [3, 1, 0] ,
  [0, 0, 2] ,
  [1, 0, 1] ,
  [2, 1, 3] ,
  [1, 1, 0] ,
  [2, 3, 2] ,
  [2, 3, 3] ,
  [3, 3, 1] ,
  [2, 3, 1] ,
  [1, 0, 0] ,
  [0, 0, 2] ,
  [2, 1, 3] ,
  [3, 1, 2] ,
  [3, 2, 2]
  ]
randRun =  -- randomized sets 
  [
  [1, 3, 3] ,
  [1, 2, 3] ,
  [3, 1, 2] ,
  [2, 1, 3] ,
  [1, 1, 3] ,
  [1, 1, 2] ,
  [2, 3, 2] ,
  [3, 3, 3] ,
  [1, 2, 2] ,
  [3, 1, 2] ,
  [3, 1, 2] ,
  [1, 2, 3] ,
  [3, 2, 1] ,
  [2, 1, 2] ,
  [1, 2, 1] ,
  [1, 3, 3] ,
  [2, 2, 2] ,
  [3, 2, 2] ,
  [3, 1, 1] ,
  [3, 3, 3] ,
  [1, 1, 1] ,
  [2, 2, 2] ,
  [1, 3, 2] ,
  [1, 3, 1] ,
  [2, 1, 2] ,
  [2, 2, 3] ,
  [1, 3, 2] ,
  [2, 3, 3] ,
  [3, 1, 3] ,
  [2, 2, 3] ,
  [2, 1, 2] ,
  [3, 1, 3] ,
  [3, 2, 3] ,
  [1, 3, 2] ,
  [3, 3, 1] ,
  [3, 2, 1] ,
  [3, 2, 2] ,
  [1, 3, 3] ,
  [3, 1, 2] ,
  [3, 2, 1] ,
  [1, 3, 2] ,
  [1, 1, 2] ,
  [1, 2, 3] ,
  [1, 3, 1] ,
  [2, 3, 3] ,
  [3, 2, 2] ,
  [1, 3, 3] ,
  [2, 3, 3] ,
  [2, 1, 2] ,
  [2, 2, 2] ,
  [3, 1, 2] ,
  [2, 1, 1] ,
  [3, 2, 2] ,
  [1, 2, 2] ,
  [2, 1, 2] ,
  [1, 3, 1] ,
  [3, 2, 1] ,
  [3, 2, 2] ,
  [3, 2, 3] ,
  [3, 3, 2] ,
  [2, 1, 1] ,
  [1, 2, 2] ,
  [2, 2, 2] ,
  [1, 3, 1] ,
  [2, 3, 1] ,
  [1, 3, 1] ,
  [3, 2, 3] ,
  [2, 3, 1] ,
  [1, 3, 3] ,
  [1, 1, 3] ,
  [2, 2, 1] ,
  [3, 2, 2] ,
  [2, 1, 2] ,
  [1, 3, 1] ,
  [1, 2, 2] ,
  [1, 1, 3] ,
  [3, 1, 3] ,
  [2, 3, 2] ,
  [2, 3, 3] ,
  [1, 1, 3] ,
  [2, 2, 2] ,
  [3, 2, 2] ,
  [3, 2, 2] ,
  [1, 3, 2] ,
  [3, 3, 1] ,
  [2, 3, 3] ,
  [1, 2, 3] ,
  [1, 3, 3] ,
  [2, 1, 1] ,
  [2, 2, 1] ,
  [3, 2, 1] ,
  [3, 1, 3] ,
  [3, 1, 1] ,
  [3, 1, 2] ,
  [1, 1, 1] ,
  [1, 2, 3] ,
  [1, 3, 3] ,
  [2, 2, 2] ,
  [3, 1, 1] ,
  [3, 2, 2]
  ]

randSign =  -- only 8 possible combinations here 
  [
  [True, True, True] ,
  [False, False, False] ,
  [True, False, False] ,
  [True, True, False] ,
  [True, False, True],
  [False, True, True] ,
  [False, False, True] ,
  [False, True, False]
  ]
  
randCorrect =  -- only 3 possible combinations
  [
  [True, False, False] ,
  [False, True, False] ,
  [False, False, True]
  ]