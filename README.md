An example for codeceptjs rest calls with BDD
============================================================

The setup below is intended for running on Macbook OSX. 

You will need this before running: 

    * Homebrew for OSX 
    * npm 
    * yarn
    * webservice under test

To install Homebrew, in your terminal, run the command
 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
Type `brew` in your terminal to see if homebrew is installed. If it is not a known command, try restarting your terminal and run the command again.    

If you don't have a preference to what version npm you're using, this command will install the most stable version of npm available

    brew install npm
     
Yarn will download the dependencies needed to run this project  

    npm install -g yarn
     
Once you have completed the above steps, go to the project root folder and run this command to download dependencies:  

    yarn install

To change url from default, set env variable CODECEPT_URL

    export CODECEPT_URL="YOUR_ENV_UNDER_TEST"
    
Use this command to run the UI test:

    npx codeceptjs run