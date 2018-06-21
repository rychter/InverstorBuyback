# Inverstor Buyback 
<br/><br/>
 WORK IN PROGRESS
<br/><br/>
Etherum contract that forces buyback of tokens from investors by investee, what reduces the supply, incrising the value of remining ones. <br/>
This solves many legal problems and increases significantly investors' motivation to buy. 
Bought back tokens are burned. <br/>
There is a function allowing to check the trackrecord of buybacks. <br/>
<br/>
<br/>
<br/>



1) Investors send sell token offers to function: 

`submitOfferForBuyback(uint256 priceInWeiTotalPerThousend) public `
<br/>

2) Ten lowest offers are selected and bought by investee by calling: 

`function executePayback() public `
<br/>

3) Check trackrecord before investing: 

 `uint256 public executedPaybacks = 0;
  mapping(uint256 => bool) public executePaybackSuccessById;`
  
  
<br/>
<br/><br/>
This reduces the number of tokens, increasing the calue of the remaining ones. 
This may aslo reduce the amount of legal restrictions in comparison to other solutions. 
<br/><br/>
<br/>
Copy contract to http://remix.ethereum.org and test it! 
