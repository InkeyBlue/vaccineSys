// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.10;

contract VaccineSys {
    address private issuerAddress;
    uint256 private idCount;
    mapping(uint8 => string) private vaccineEnum;

    struct Vaccine{
        uint256 id;
        address issuer;
        uint8 vaccineType;
        string value;
    }

    mapping(address => Vaccine) private vaccines;

    constructor() {
        issuerAddress = msg.sender;
        idCount = 1;
        vaccineEnum[0] = "Pfizer";
        vaccineEnum[1] = "Moderna";
        vaccineEnum[2] = "AstraZeneca";
    }

    function claimVaccine(address _proofAddress, uint8 vaccineType, string calldata _value) public returns(bool){
        require(issuerAddress == msg.sender, "Not Issuer");
				Vaccine storage vaccine = vaccines[_proofAddress];
        require(vaccine.id == 0);
        vaccine.id = idCount;
        vaccine.issuer = msg.sender;
        vaccine.vaccineType = vaccineType;
        vaccine.value = _value;
        
        idCount += 1;

        return true;
    }

    function getVaccine(address _proofAddress) public view returns (Vaccine memory){
        return vaccines[_proofAddress];
    }

}
