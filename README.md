# Inverstor Buyback // WORK IN PROGRESS

Etherum contract that forces buyback of tokens from investors by investee, what reduces the supply, incrising the value of remining ones. 
This solves many legal problems and increases significantly investors' motivation to buy. 
Bought back tokens are burned. 
There is a function allowing to check the trackrecord of buybacks. 



1) Investors send sell token offers to function: 

`submitOfferForBuyback(uint256 priceInWeiTotalPerThousend) public `

2) The 10 lowest offers are selected and bought by investee by calling: 

`function executePayback() public `

3) Check trackrecord before investing: 

 `uint256 public executedPaybacks = 0;
  mapping(uint256 => bool) public executePaybackSuccessById;`


This reduces the number of tokens, increasing the calue of the remaining ones. 
This may aslo reduce the amount of legal restrictions in comparison to other solutions. 



Copy contract to http://remix.ethereum.org and test it! 
