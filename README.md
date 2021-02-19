![](https://img.shields.io/badge/Microverse-blueviolet)

# Week 2 TicTacToe Rspec

In order to win the game, a player must place three of their marks in a horizontal, vertical, or diagonal row.
Players will soon discover that the best play from both parties leads to a draw.
Hence, tic-tac-toe is most often played by young children, who often have not yet discovered the optimal strategy. 

## How do we play Tic Tac Toe?

Players take turns playing: 
- 1st turn — Player 1: 
Player 1 places their token (X) in only 1 square of their choice
- 2nd turn — Player 2:
 Player 2 places their token (O) in only 1 square of their choice, except they can’t touch the square that Player 1’s token already fills
- 3rd turn- Player 1 …. and the cycle continues until a player wins or there’s a tie game

There are 8 winning combinations: Top row, Middle row, Bottom row, Left column, Middle column, Right column, Left diagonal, and Right diagonal
There’s a draw/tie when the entire board is filled with X’s and O’s but no winning combinations can be found.

## Screenshot
- testing

![rspectest-tictoc-toe](https://user-images.githubusercontent.com/11162987/108459668-2cf05a00-7288-11eb-9c1f-61079e7ce200.PNG)

![Screenshot](TicTacToe.gif)

## Built With
 [RUBY](https://github.com/billodiallo/Rspec-tic_tic_toe)

## Getting Started

This is an example of how you may give instructions on setting up your project locally. Modify this file to match your project, remove sections that don't apply. For example: delete the testing section if the currect project doesn't require testing.

- To get a local copy up and running follow these simple example steps.

- Clone this repository with git clone ```https://github.com/billodiallo/Rspec-tic_tic_toe.git``` using your terminal or command line.
- Change to the project directory by entering :
```cd Rspec-tic_tic_toe``` in the terminal .
- run the command ```bin/main```

## Prequisites

Ruby installed on your local machine.
Terminal or similar to execute the program.

## Testing
In this project the testing was done using RSpec to test all game logic methods.

## Install
- In a terminal window type gem install rspec
- Once rspec install has finished, type rspec --init
- You will see a folder spec and a file .rspec
- Inside spec folder you'll see a spec_helper.rb file.

## Run
We have already created rspec-testing files called logic.rb, and settings.rb.
- go to the folder inside your terminal type rspec
- If all test pass you will see:
 `16 examples, 0 failures` for logic.rb
 `4 examples, 0 failures` for settings.rb

## Authors

👤 Billo Dallio

- GitHub: [@billodiallo](https://github.com/billodiallo)
- Twitter: [@BilloDi83547008](https://twitter.com/BilloDi83547008)

👤 Sergio Cortes Satizabal

- Github: [@sergiocortessat](https://github.com/sergiocortessat)
- Twitter: [@sergiocortessat](https://twitter.com/sergiocortessat)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/greg0109/TicTacToe/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](LICENSE) licensed.
