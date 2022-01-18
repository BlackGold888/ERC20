pragma solidity ^0.8.0;
import IERC20 from './IERC20.sol';

contract ERC20 is IERC20{
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    uint256 private totalSupply;
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function name() public view virtual returns (string memory) {
        return name;
    }

    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function symbol() public view virtual returns (string memory) {
        return symbol;
    }

    function balanceOf(address _account) public view virtual returns (uint256) {
        return balances[_account];
    }

    function totalSupply() public view virtual returns (uint256) {
        return totalSupply;
    }

    function transfer(address _to, uint256 _amount) public virtual returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _amount) internal virtual {
        require(_from != address(0), "Transfer from the zero address");
        require(_to != address(0), "Transfer to the zero address");

        uint256 senderBalance = _balances[_from];
        require(senderBalance >= _amount, "Transfer amount exceeds balance");
        _balances[_from] = senderBalance - _amount;
        _balances[_to] += _amount;

        emit Transfer(_from, _to, amount);
    }


}
