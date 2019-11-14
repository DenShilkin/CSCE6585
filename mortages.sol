pragma solidity ^0.5.0;

import "./mortgage.sol";

contract mortgages {
	function main () public {
		uint Num = 10;
		mortgage[] storage Mortgages = new mortgage[](Num); // create an array of mortgages

		for (uint i = 1; i < Num+1; i++){
			string memory sName = "Name"+ uint2str(i);
			Mortgages[i].addSale(sName, "PropertyAddress"+uint2str(i),
				"SellerAddress"+uint2str(i), "TexasStateID"+uint2str(i), 100000);
		}


	}

	function uint2str(uint i) internal pure returns (string memory){
		if (i == 0) return "0";
		uint j = i;
		uint length;
		while (j != 0){
			length++;
			j /= 10;
		}
		bytes memory bstr = new bytes(length);
		uint k = length - 1;
		while (i != 0) {
			bstr[k--] = byte(48 + i % 10);
			i /= 10;
		}
		return string(bstr);
	}
}
