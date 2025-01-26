// SPDX-License-Identifier: MIT
// ctrl shift p => format document => solidity formatter
// cast --to-base 0x547a6 dec  gas fiyatinin hex karsiligini numeric degere cevirir.
// cast call 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 "favoriteNumber()"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY
// cast send 0x6c4791c3a9E9Bc5449045872Bd1b602d6385E3E1 "solveChallenge(string,string)" "lemon" "@avcisec"
//cast send 0x6c4791c3a9E9Bc5449045872Bd1b602d6385E3E1 "solveChallenge(string,string)" "lemon" "@avcisec" --rpc-url $SEPOLIA_URL --private-key $SEPOLIA_KEY
// yukaridaki komut ile fonksiyon cagirabiliriz. gelen degeri hex olarak doner.
/* forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL 
--private-key $PRIVATE_KEY --broadcast --legacy   | --legacy ile gonderirsek tx type 0x0  */
// tx types konusunu arastir. zksync docs ve cyfrin blog
// 346022 gas used with 0x0 tx type
// 346022 gas used with 0x2 tx type
pragma solidity ^0.8.18;

// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;
contract SimpleStorage {
    uint256 public favoriteNumber;
    // dinamik array
    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber; // + 20
    }

    // view, pure
    // calldata ve memory gecici depolama icin
    // memory ve calldatanin farki memory degistirilebilir manipule edilebilir.
    // storage kalici depolama ve modifiye edilebilir
    // fonksiyon disinda kontrat icinde bir degisken tanimlarsaniz otomatik olarak storage da depolanir.
    // array icin memory kelimesini koymaliyiz. buyuzden string memory yaziyoruz. Cunku string bir  array of bytes bytes ise memoryde depolanir.
    // structs, mapping ve arrays memory keywordu gerektirir.
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
