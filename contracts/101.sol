// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 1、 msg.sender 與 tx.origin 有何不同?
// msg.sender 當前呼叫合約的直接呼叫者地址，可以是外部帳戶（EOA）或合約地址，安全性較高。
// tx.origin 發起整個交易的原始外部帳戶地址，永遠是外部帳戶（EOA），不可能是合約地址，容易被利用。

contract Addr {
    function msgSender() public view returns (address result) {
        result = msg.sender;
    }
    function txOrigin() public view returns (address result){
        result = tx.origin;
    }
}

// 2、 What's "function selector"?
// function selector 是函數簽名的 Keccak-256 雜湊值的前 4 個位元組，用於在合約呼叫時識別要執行的函數。
contract Selector {
    function check() public pure {
        require (bytes4 (keccak256 ("transfer(address,uint256)")) == 0xa9059cbb, "Selector mismatch"
        );
    }
}

// 3、 What's Keccak256?
// Keccak256 是一種加密雜湊函數，它是 SHA-3 標準的基礎。它會將任意大小的輸入資料轉換成一個固定長度，且看似隨機的短字串，這個短字串就是雜湊值(hash value)。

// 4、 寫出一個可以去除 Array 中某一個位置內元素的函數，傳入值是 index，回傳新的 array。

contract Remove {

    // Input two numbers to define max size of array and index of deletion.
    function removeArr(uint8 arraySize, uint8 targetIndex) public pure returns (uint8[] memory result) {

        require (targetIndex < arraySize, "Index is out of bounds.");

        uint8[] memory array = new uint8[](arraySize);

        for (uint8 i = 0; i < arraySize; i++) {
            array[i] = i + 1;
        }

        // Create a new array.
        uint8[] memory newArray = new uint8[](array.length - 1);
        uint8 newArrayIndex = 0;

        for (uint8 i = 0; i < array.length; i++) {
            if (i != targetIndex) {
                newArray[newArrayIndex] = array[i];
                newArrayIndex++;
            }
        }

        return newArray;
    }
}