# Inverstor Buyback

Etherum contract that forces buyback of tokens from investors



1) Investors send offers to function: 

`submitOfferForBuyback(uint256 priceInWeiTotalPerThousend) public `

2) 10 lowest offers is selected and bought by investee by calling: 

`function executePayback() public `



This reduces the number of tokens, increasing the calue of the remaining ones. 
This may aslo reduce the amount of legal restrictions in comparison to other solutions. 



Copy contract to http://remix.ethereum.org and test it! 
