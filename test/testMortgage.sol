pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/mortgage.sol";

contract testMortgage {
	// The address of the contract to be tested
	mortgage mortgage1 = mortgage(DeployedAddresses.mortgage());

	function testAddSale () public {
		mortgage1.addSale("Denis Shilkin", "Denis's old address", "Denis's new address", "Driver Licence", 500000);
		uint newSaleID = mortgage1.getSaleID();
		Assert.equal(mortgage1.getSellerName(), "Denis Shilkin", "Name should be Denis Shilkin");
		Assert.equal(newSaleID, 0, "Dummy check for SaleID");
	}

	function testGetSalePropertyAddress () public {
		mortgage1.addSale("Denis Shilkin", "Denis's old address", "Denis's new address", "Driver Licence", 500000);
		uint newSaleID = mortgage1.getSaleID();
		Assert.equal(newSaleID, 0, "Dummy check for SaleID");
		Assert.equal(mortgage1.getSalePropertyAddress(), "Denis's old address", "There should be old address");
	}

}
