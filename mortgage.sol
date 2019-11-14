pragma solidity ^0.5.0;

contract mortgage {
	struct sale {
		uint _id;				// sale identification
		uint _status;			// encoded status of a sale (need to think about bit encoding)
		uint _price;			// final (agreed) price for a property
		string _address;		// property address
		uint _propertyID;		// PropertyID
	}
	struct seller {
		uint _price;			// initial seller's ask
		string _name; 			// person name or company name
		string _address; 		// could be different than property address
		string _StateID;		// seller ID for verification
		address _EAddress; 		// Etherium address of a seller
		bool _ok;				// ok to sale
	}
	struct buyer {
		string  _name; 			// person name or company name
		string _address;		//current buyer address
		string  _StateID;		//
		address _EAddress;		//
		uint  _price;			//
		bool _ok;				// ok to buy
	}
	struct lender {
		uint _id;				//
		address _EAddress;		//
	}
	struct loan {
		uint _id;	//loan ID
		string _terms;
		uint _status;
	}
	struct county {
		uint _id;			//
		address _EAddress;	//
		uint  _propertyID;			// property id from county records
		uint  _status;		// results of county records verification (bit encoding)
	}

	sale public Sale;
	seller public Seller;
	buyer public Buyer;
	lender public Lender;
	county public County;
	loan public Loan;

	constructor () public {

	}

	function addSale (string memory sellerName, string memory propertyAddress, string memory sellerAddress,
		string memory sellerStateID, uint askPrice) public {
		Sale._id = random ();
		Sale._address = propertyAddress;
		Sale._price = askPrice;
		Seller._name = sellerName;
		Seller._price = askPrice;
		Seller._address = sellerAddress;
		Seller._StateID = sellerStateID;
	}

	function getSaleID () public returns (uint) {
		return Sale._id;
	}

	function getSaleStatus () public returns (uint) {
		return Sale._status;
	}

	function getSalePropertyAddress () public returns (string memory) {
		return Sale._address;
	}

	function getSalePropertyID () public returns (uint) {
		return Sale._propertyID;
	}

	function getSellerName () public returns (string memory) {
		return Seller._name;
	}

	function setPropertyID (uint propertyID) public {
		Sale._propertyID = propertyID;
	}

	function getPropertyID (string memory propertyAddress) public returns (uint) {
		return getCountyPropertyID(propertyAddress);
	}

	function verifyProperty (uint property_id) public {
		if (getCountyPropertyStatus(property_id) > 0)
			County._status = 1;
		else County._status = 0;
	}

	function addBuyer (string memory buyerName, string memory buyerStateID, string memory buyerAddress, uint BuyerPrice) public {
		Buyer._name = buyerName;
		Buyer._StateID = buyerStateID;
		Buyer._address = buyerAddress;
		Buyer._price = BuyerPrice;
	}

	function updateSalePrice () public {
		if (confirmSalePrice(Seller._price, Buyer._price)) {
			Sale._status = 1;
			Seller._ok = true;
			Buyer._ok = true;
		}
		else Sale._status = 99;
	}

	function updateLenderDetails (uint lenderID) public {
		Lender._id = lenderID;
	}

	function submitLoan (uint buyer_id, uint lender_id) public {
		Loan._id = sendBuyerData_toLender(buyer_id, lender_id);
		Loan._status = 1;
		Sale._status = 2;
	}

	function getLoanStatus (uint loan_id) public returns (uint) {
		Loan._status = getLoanStatus_fromLender(loan_id);
		return Loan._status;
	}

	function updateSaleLoan (uint sale_id, uint loan_id) public {
		Sale._status = 3;
	}

	function finalizeSale(uint sale_id) public returns (uint) {
		Sale._status = 4;
		return Sale._status;
	}

	function closeSale (uint sale_id) public returns (uint) {
		Sale._status = 5;
		return Sale._status;
	}

	function random() private view returns (uint8) {
		return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%251);
	}

	//function random() private view returns (uint) {
	//	return 667543;
	//}

	// Dummy functions. These should request data from external systems and update values.

	function getLoanStatus_fromLender (uint loan_id) public returns (uint){
		return 2;
	}

	function getCountyPropertyID (string memory propertyAddress) public returns (uint) {
		// there should be a call to external system to get Property ID based on Property Address
		return 99002291;
	}

	function getCountyPropertyStatus (uint propertyID) public returns (uint) {
		// there should be a call to external system to get Property Status (i.e. current register owners, etc.)
		return 1;
	}

	function confirmSalePrice(uint sellerPrice, uint BuyerPrice) public returns (bool) {
		// there should be a call to Seller and Buyer personal accounts with request to confirm agreement on price.
		return true;
	}
	function sendBuyerData_toLender (uint buyerID, uint lenderID) public returns (uint){
		return 1;
	}
}
