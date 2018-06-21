pragma solidity ^0.4.17;

contract InvestorBuyback {

    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    uint256 initialSupply = 1000000;
    uint256 initialInvestmentPerThousendInWei = 100000;
    uint256 public biggestDifference;
    uint256 public currentDifference;
    uint256 public biggestDifferenceId;
    address public creator;
    uint256 public lastExecutedPayback;
    uint256 public executedPaybacks = 0;


    mapping(uint256 => bool) public executePaybackSuccessById;
    mapping(address => uint256) public balanceOf;

    struct buyBackOffer {
        uint256 amount;
        uint256 priceInWei;
        address investorAddress;
    }

    uint256 public buyBackOfferCount = 0;
    mapping(uint256 => uint256) public lowestOffersIds;
    uint256 public lowestOffersIdsCount = 0;
    mapping(uint256 => buyBackOffer) public buyBackOffersById;
    
    function InvestorBuyback(string tokenName, string tokenSymbol) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
        creator = msg.sender;
        lastExecutedPayback = block.timestamp;

        for (uint i = 0; i < 10; i++) {
            buyBackOffersById[i].amount = 1000;
            buyBackOffersById[i].priceInWei = 1000 * initialInvestmentPerThousendInWei;
            buyBackOffersById[i].investorAddress = 0;
        }
    }

    function getBalance() public view returns (uint256){
        return this.balance;
    }


    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    function submitOfferForBuyback(uint256 priceInWeiTotalPerThousend) public {
        
        require(priceInWeiTotalPerThousend <= (100 * initialInvestmentPerThousendInWei));
        require(balanceOf[msg.sender] >= 1000 * 10 ** uint256(decimals));
        require(executedPaybacks <= 100);
        
        bool swap = false;
        biggestDifference = 0;
        currentDifference = 0;

        for (uint i = 0; i < 10; i++) {


            if (priceInWeiTotalPerThousend < buyBackOffersById[i].priceInWei) {
                swap = true;
                currentDifference = buyBackOffersById[i].priceInWei - priceInWeiTotalPerThousend;

                if (biggestDifference < currentDifference) {
                    biggestDifference = currentDifference;
                    biggestDifferenceId = i;
                }
            }
        }
        
        if (swap) {
            
            balanceOf[buyBackOffersById[i].investorAddress] += buyBackOffersById[biggestDifferenceId].amount;

            buyBackOffersById[biggestDifferenceId].amount = 1000;
            buyBackOffersById[biggestDifferenceId].priceInWei = priceInWeiTotalPerThousend;
            buyBackOffersById[biggestDifferenceId].investorAddress = msg.sender;

            balanceOf[buyBackOffersById[biggestDifferenceId].investorAddress] -= buyBackOffersById[biggestDifferenceId].amount;
            
        }
    }

    function executePayback() public {

        //    require((block.timestamp - lastExecutedPayback) >= 2629743); UNCOMMENT ME <---------------------
        require(executedPaybacks <= 100);

        uint256 totalToPay = 0;

        for (uint j = 0; j < 10; j++) {

            if (buyBackOffersById[j].investorAddress != 0) {

                totalToPay += buyBackOffersById[j].priceInWei;

            }

        }
        
        require((totalToPay <= this.balance));
        
        for (uint i = 0; i < 10; i++) {
            if (buyBackOffersById[i].investorAddress != 0) {
                buyBackOffersById[i].investorAddress.transfer(buyBackOffersById[i].priceInWei);

                buyBackOffersById[i].amount = 1000;
                buyBackOffersById[i].priceInWei = 1000 * initialInvestmentPerThousendInWei;
                buyBackOffersById[i].investorAddress = 0;
            }
        }

        lastExecutedPayback = block.timestamp;
        executedPaybacks++;
        wasLastBuybackExecutedOnTime();
    }

    function addBalance() public payable {}

    function wasLastBuybackExecutedOnTime() private {
        if ((block.timestamp - lastExecutedPayback) >= 5259486) {
            executePaybackSuccessById[executedPaybacks] = true;
        } else {
            executePaybackSuccessById[executedPaybacks] = false;
        }
    }
}
